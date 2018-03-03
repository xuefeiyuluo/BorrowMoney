//
//  URLCenter.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/9.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class URLCenter: NSObject {
    public var dict : NSDictionary = [:]
    public var method : String = ""
    public var sessionBool : Bool = true
    public var engineeringBool : Bool = false // 方法名前是否添加的前缀
    public var loadingIcon : Bool = true // 请求数据是否要“转圈”
}
