//
//  NSDictionary+Extension.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/22.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import Foundation

extension NSDictionary {
    // 字典的取值nil判断
    func stringForKey(key : String) -> String {
        var value = self.object(forKey: key)
        if value is String {
        } else if value is NSNumber {
            return (value as! NSNumber).stringValue
        } else {
            value = ""
        }
        return value as! String
    }
}
