//
//  YLLog.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/10/18.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import Foundation

//自定义 log

func XPrint<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        
        print("\(fileName):  \(lineNum)  \(message)");
    #endif
}
