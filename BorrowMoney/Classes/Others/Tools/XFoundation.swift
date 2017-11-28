//
//  HEFoundation.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/20.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import Foundation

class XFoundation: NSObject {
    static let set = NSSet(array: [
        NSURL.classForCoder(),
        NSDate.classForCoder(),
        NSValue.classForCoder(),
        NSData.classForCoder(),
        NSError.classForCoder(),
        NSArray.classForCoder(),
        NSDictionary.classForCoder(),
        NSString.classForCoder(),
        NSAttributedString.classForCoder()
        ])
    static let  bundlePath = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String

    /*** 判断某个类是否是 Foundation中自带的类 */
    class func isClassFromFoundation(c:AnyClass)->Bool {
        var  result = false
        if c == NSObject.classForCoder(){
            result = true
        }else{
            set.enumerateObjects({ (foundation,  stop) -> Void in
                if c.isSubclass(of: foundation as! AnyClass) {
                    result = true
                    stop.initialize(to: true)
                }
            })
        }
        return result
    }

    /** 很据属性信息， 获得自定义类的 类名*/
    /**
     let propertyType = String.fromCString(property_getAttributes(property))! 获取属性类型
     到这个属性的类型是自定义的类时， 会得到下面的格式： T+@+"+..+工程的名字+数字+类名+"+,+其他,
     而我们想要的只是类名，所以要修改这个字符串
     */
    class func getCustomObjectType(code:String)->String?{

        var code = code
        
        //不是自定义类
        if (code.range(of: bundlePath) == nil) {
            return nil
        }
        
        code = (code.components(separatedBy: "\"") as NSArray)[1] as! String
        
        if let range = code.range(of: bundlePath){
            code = code.substring(from: range.upperBound)
            var numStr = "" //类名前面的数字
            for c:Character in code.characters{
                if c <= "9" && c >= "0"{
                    numStr+=String(c)
                }
            }
            if let numRange = code.range(of: numStr){
                code = code.substring(from: numRange.upperBound)
            }
            return bundlePath+"."+code
        }
        return nil
    }
}
