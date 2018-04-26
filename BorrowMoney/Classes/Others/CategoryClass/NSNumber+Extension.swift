//
//  NSDictionary+Extension.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/22.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import Foundation

extension Int {
    
    // Int -> string
    func stringValue() -> String {
        return NSString (format: "%i", self) as String
    }
    
}



extension Float {
    // Float -> string
    func stringValue() -> String {
        return NSString (format: "%f", self) as String
    }
}



extension Double {
    // Double -> string
    func stringValue(bit : Int) -> String {
        return NSString (format: "%.\(bit)f" as NSString, self) as String
    }
}
