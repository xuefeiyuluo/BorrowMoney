//
//  NSArray+Extension.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/17.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import Foundation


extension NSObject {
    var keyValues:[String:AnyObject]?{                   //获取一个模型对应的字典
        get{
            var result = [String: AnyObject]()           //保存结果
            var classType:AnyClass = self.classForCoder
            while("NSObject" !=  "\(classType)" ){
                var count:UInt32 = 0
                let properties = class_copyPropertyList(classType, &count)
                for i in 0..<count{
                    let property = properties?[Int(i)]
//                    let propertyKey = String.fromCString(property_getName(property))!
                     //模型中属性名称
                    let propertyKey = String (validatingUTF8: property_getName(property))
                    
//                    let propertyType = String.fromCString(property_getAttributes(property))!  
                    //模型中属性类型
                    let propertyType = String (validatingUTF8: property_getAttributes(property))
                    
                    //描述，不是属性
                    if "description" == propertyKey{ continue }

                    let tempValue:AnyObject!  = self.value(forKey: propertyKey!)! as AnyObject
                    if  tempValue == nil { continue }

                    //1,自定义的类
                    if let _ =  XFoundation.getCustomObjectType(code: propertyType!) {
                        result[propertyKey!] = tempValue.keyValues as AnyObject
                    //2, 数组, 将数组中的模型转成字典
                    }else if ((propertyType?.range(of: "NSArray")) != nil){
                        result[propertyKey!] = tempValue.keyValuesArray as AnyObject
                    //3， 基本数据
                    }else{
                        result[propertyKey!] = tempValue
                    }
                }
                free(properties)
                classType = classType.superclass()!
            }
            if result.count == 0{
                return nil
            }else{
                return result
            }
            
        }
    }
}


extension NSArray {
    
    var keyValuesArray:[AnyObject]?{
        get{
            var result = [AnyObject]()
            for item in self{
                if !XFoundation.isClassFromFoundation(c: (item as AnyObject).classForCoder){ //1,自定义的类
                    let subKeyValues:[String:AnyObject]! = (item as AnyObject).keyValues
                    if  subKeyValues == nil {continue}
                    result.append(subKeyValues as AnyObject)
                }else if (item as AnyObject).classForCoder == NSArray.classForCoder(){    //2, 如果item 是数组
                    let subKeyValues:[AnyObject]! = (item as AnyObject).keyValuesArray
                    if  subKeyValues == nil {continue}
                    result.append(subKeyValues as AnyObject)
                }else{                                                     //3, 基本数据类型
                    result.append(item as AnyObject)
                }
            }
            if result.count == 0{
                return nil
            }else{
                return result
            }
            
        }
    }
}
