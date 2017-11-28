//
//  URLCenter.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/9.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class URLCenter: NSObject {
    static let urlCenterInstance : URLCenter = URLCenter()
    
    public var dict : NSDictionary?
    public var method : String = ""
    public var sessionBool : Bool = true
    public var engineeringBool : Bool = false // 方法名前是否添加的前缀
}
