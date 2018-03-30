//
//  NSDictionary+Extension.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/22.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import Foundation

extension Data {
    
    // Utf8解码 utf8 -> string
    func utf8ToStringDecoded() -> String {
        let str : String = (NSString(data: self, encoding: String.Encoding.utf8.rawValue))! as String
        return str
    }
}
