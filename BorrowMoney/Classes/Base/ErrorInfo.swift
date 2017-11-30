//
//  ErrorInfo.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/10.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class ErrorInfo: NSObject {
    public var errNo : NSInteger? = nil
    public var methodName : String = ""// 请求方法名称
    public var msg : String = "请求失败"
    public var error : Error? = nil
}
