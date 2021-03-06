//
//  NSObject+Extension.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/20.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import Foundation

/** 当字典中存在数组， 并且数组中保存的值得类型是字典， 那么就需要指定数组中的字典对应的类类型。
 这里以键值对的形式保存
 eg 字典如下：
 key: [[key1:value1, key2:value2],[key1:value3, key2:value4],[key1:value5, key2:value6]]
 
 key：  key值
 value: 字典[key1:value1, key2:value2] 对应的模型
 */
@objc public protocol ArrayToModelProtocol{
    static func customClassMapping() -> [String: String]?
}


extension NSObject {
    
    // dict: 要进行转换的字典
    class func objectWithKeyValues(dict: NSDictionary)->AnyObject?{
        if XFoundation.isClassFromFoundation(c: self) {
            print("只有自定义模型类才可以字典转模型")
            assert(true)
            return nil
        }
        
        let obj : AnyObject = self.init()

        // 当前类的类型
        var cls : AnyClass = self.classForCoder()

        while("NSObject" !=  "\(cls)"){
            var count:UInt32 = 0
            // 获取属性列表
            let properties =  class_copyPropertyList(cls, &count)
             // 保存替换前的属性值
            var originalPropertyKey = ""
            for i in 0..<count{
                // 获取模型中的某一个属性
                let property = properties?[Int(i)]
                
                // 属性类型
                let propertyType = String (validatingUTF8: property_getAttributes(property))
                // 属性名称
                var propertyKey = String (validatingUTF8: property_getName(property))
                // description是Foundation中的计算型属性，是实例的描述信息
                if propertyKey == "description"{
                    XPrint("description是Foundation中自带属性")
                    continue
                }
//                XPrint(propertyKey)
                // 获取替换的属性key
                let key = requestReplacedKey(key : propertyKey!,obj : obj)
                if key != "" {
                    originalPropertyKey = propertyKey!
                    propertyKey = String(key)
                } else {
                    originalPropertyKey = ""
                }
                
                // 取得字典中的值
                var value:AnyObject! = dict[propertyKey!] as AnyObject
                if value == nil {continue}

                // 字典中保存的值得类型
                let valueType =  "\(value.classForCoder)"

                // 1，值是字典,这个字典要对应一个自定义的模型类并且这个类不是Foundation中定义的类型。
                if (valueType.range(of: "NSDictionary") != nil) {
                    let subModelStr:String! = XFoundation.getCustomObjectType(code: propertyType!)
                    if subModelStr == nil{
                        XPrint("你定义的模型与字典不匹配，字典中的键\(String(describing: propertyKey))对应一个自定义的模型")
                    } else {
                        if NSClassFromString(subModelStr) != nil{
                            // 递归
                            value = NSClassFromString(subModelStr)?.objectWithKeyValues(dict: value as! NSDictionary)
                        }
                    }
                // 值是数组。 数组中存放字典。 将字典转换成模型。 如果协议中没有定义映射关系，就不做处理
                }else if (valueType.range(of: "NSArray") != nil){
                    // 子模型的类名称
                    if cls.responds(to: "customClassMapping") {
                        if var subModelClassName = cls.customClassMapping()?[propertyKey!]{
                            subModelClassName =  XFoundation.bundlePath + "." + subModelClassName
                            if NSClassFromString(subModelClassName) != nil{
                                value = NSClassFromString(subModelClassName)?.objectArrayWithKeyValuesArray(array: value as! NSArray)
                            } else {
                            XPrint("你定义的模型与数组不匹配，数组\(String(describing: propertyKey))对应一个自定义的模型")
                            }
                        }
                    }
                // NSNumber转换为String
                } else if (valueType.range(of: "Number") != nil) {
                    value = String (format: "%@", value as! CVarArg) as AnyObject
                    
                // NSNull时装换为“”
                } else if (valueType.range(of: "NSNull") != nil) {
                    let subModelStr:String! = XFoundation.getCustomObjectType(code: propertyType!)
                    if subModelStr == nil{
                        // 判断当前key的类型如NSArray，NSDictionary
                        let keyType : [String] = (propertyType?.components(separatedBy: "\""))!
                        if keyType.count >= 2 {
                            if keyType[1] == "NSArray" || keyType[1] == "Array" {
                                value = [AnyObject]() as AnyObject
                            } else if keyType[1] == "NSDictionary" || keyType[1] == "Dictionary" {
                                value = [String:Any]() as AnyObject
                            } else {
                                value = "" as AnyObject
                            }
                        } else {
                            value = "" as AnyObject
                        }
                    } else {
                        value = nil
                    }
                }

                if originalPropertyKey != "" {
                    propertyKey = originalPropertyKey
                }
                obj.setValue(value, forKey: propertyKey!)
            }
            free(properties)                            //释放内存
            cls = cls.superclass()!                     //处理父类
        }
        return obj
    }
    
    
    // 获取替换的属性key
    class func requestReplacedKey(key : String,obj : AnyObject) -> String {
        let replaceDict : NSDictionary = obj.replacedKeyFromPropertyName()
        if replaceDict[key] != nil {
            return replaceDict[key] as! String
        } else {
            return ""
        }
    }
    
    
    /**
     将字典数组转换成模型数组
     array: 要转换的数组, 数组中包含的字典所对应的模型类就是 调用这个类方法的类
     
     当数组中嵌套数组， 内部的数组包含字典，cls就是内部数组中的字典对应的模型
     */
    class func objectArrayWithKeyValuesArray(array: NSArray)->NSArray?{
        if array.count == 0{
            return []
        }
        var result = [AnyObject]()
        for item in array{
            let type = "\((item as AnyObject).classForCoder)"
            if (type.range(of: "NSDictionary") != nil) {
                if let model = objectWithKeyValues(dict: item as! NSDictionary){
                    result.append(model)
                }
            } else if (type.range(of: "NSArray") != nil) {
                if let model = objectArrayWithKeyValuesArray(array: item as! NSArray) {
                    result.append(model)
                }
            } else {
                result.append(item as AnyObject)
            }
        }
        if result.count==0{
            return nil
        }else{
            return result as NSArray
        }
    }
    
    
    // 添加属性的替换的方法
    func replacedKeyFromPropertyName() -> NSDictionary {
        // [替换后的key:原来的key]
        return [:]
    }
    
    
    // 获取当前控制器
    func getCurrentVC()->UIViewController{
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindowLevelNormal{
            let windows = UIApplication.shared.windows
            for  tempwin in windows{
                if tempwin.windowLevel == UIWindowLevelNormal{
                    window = tempwin
                    break
                }
            }
        }
        let frontView = (window?.subviews)![0]
        let nextResponder = frontView.next
        if nextResponder?.isKind(of: UIViewController.classForCoder()) == true {
            return nextResponder as! UIViewController
        } else if nextResponder?.isKind(of: UINavigationController.classForCoder()) == true {
            return (nextResponder as! UINavigationController).visibleViewController!
        } else {
            if (window?.rootViewController) is UINavigationController{
                //只有这个是显示的controller 是可以的必须有nav才行
                return ((window?.rootViewController) as! UINavigationController).visibleViewController!
            }else if (window?.rootViewController) is TabBarController {
                //不行只是最三个开始的页面
                return ((window?.rootViewController) as! UITabBarController).selectedViewController!
            }
            return (window?.rootViewController)!
        }
    }
    
    
    // 计算文字的尺寸
    func sizeWithText(text : String,font : UIFont, maxSize : CGSize) -> CGSize {
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        let size : CGSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context: nil).size
        return size
    }
    
    
    // 设置文本的行间距
    func setTextLineSpace(text : String,lineSpacing : CGFloat,font : UIFont) -> NSAttributedString {
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        let attributedStr = NSMutableAttributedString(string: text)
        let paragraphStye = NSMutableParagraphStyle()
        paragraphStye.lineSpacing = lineSpacing
        let rang = NSMakeRange(0, CFStringGetLength(text as CFString?))
        attributedStr.setAttributes(dic as? [String : Any], range: rang)
        attributedStr.addAttribute(NSParagraphStyleAttributeName, value: paragraphStye, range: rang)
        return attributedStr
    }
    
    
    // 计算Attribute文本的高度
    func sizeWithAttributeText(text : String,font : UIFont, maxSize : CGSize,paragraphStyle : NSMutableParagraphStyle) -> CGSize {
        let dic = [NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy()]
        let size : CGSize = text.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin,.usesFontLeading,.truncatesLastVisibleLine], attributes: dic, context: nil).size
        return size
    }
    
    
    
    
    
}
