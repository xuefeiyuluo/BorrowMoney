//
//  XConfigure.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/22.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import Foundation

// ******************************** 基本信息 ***************************************
var BASICINFO : BasicModel? {
    get {
        return XConfigure.instance.requestBacicInfo() as BasicModel
    }
}


// ******************************** 用户信息 ***************************************
var USERINFO : UserModel? {
    get {
        return XConfigure.instance.requestUserInfo() as UserModel
    }
}


// ******************************** 是否登录 ***************************************
var ASSERLOGIN : Bool? {
    get {
        return XConfigure.instance.assertionUserLogin() as Bool
    }
}


class XConfigure: NSObject {
    static let instance : XConfigure = XConfigure()
    
    // 获取基本信息
    func requestBacicInfo() -> BasicModel {
        var basicModel : BasicModel?
        if (USERDEFAULT.getCustomObject(key: "basicInfo") != nil) {
            basicModel = USERDEFAULT.getCustomObject(key: "basicInfo") as? BasicModel
        } else {
            basicModel = BasicModel()
            basicModel?.uuid = NSUUID().uuidString
            USERDEFAULT.saveCustomObject(customObject: (basicModel)!, key: "basicInfo")
        }
        return basicModel!
    }
    
    
    // 获取用户信息
    func requestUserInfo() -> UserModel {
        var userInfo : UserModel?
        if (USERDEFAULT.getCustomObject(key: "userInfo") != nil) {
            userInfo = USERDEFAULT.getCustomObject(key: "userInfo") as? UserModel
            return userInfo!
        }
        return UserModel()
    }
    
    
    // 是否已登录
    func assertionUserLogin() -> Bool {
        if (USERDEFAULT.getCustomObject(key: "userInfo") != nil) {
            return true
        } else {
            return false
        }
    }
}
