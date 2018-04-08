//
//  UserModel.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/10.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class UserModel: NSObject, NSCoding{
    
    var mobile : String? = ""// 手机号码
    var sessionId : String? = ""// session
    var isNewUser : String? = ""//
    var hasPassword : Bool? = false//
    var name : String? = ""//
    var idCard : String? = ""// 身份证号码
    var roleType : String? = ""//
    var verify : Int?//
    var headImage : String? = ""// 头像
    var webCookies : NSArray? = []//
    var redPacketCount : Int?//
    var balanceAmount : Double?//
    var signInToday : String? = ""//
    var yhzxShowFlag : String? = ""//
    var gender : String? = ""//
    var bankCard : String? = ""// 银行卡号
    
    override init() {
        super.init()
    }
    
    required init(coder decoder: NSCoder) {
        super.init()
        
        mobile = decoder.decodeObject(forKey: "mobile") as? String
        sessionId = decoder.decodeObject(forKey: "sessionId") as? String
        webCookies = decoder.decodeObject(forKey: "webCookies") as? NSArray
        hasPassword = decoder.decodeObject(forKey: "hasPassword") as? Bool
        isNewUser = decoder.decodeObject(forKey: "isNewUser") as? String
        name = decoder.decodeObject(forKey: "name") as? String
        idCard = decoder.decodeObject(forKey: "idCard") as? String
        roleType = decoder.decodeObject(forKey: "roleType") as? String
        verify = decoder.decodeObject(forKey: "verify") as? Int
        headImage = decoder.decodeObject(forKey: "headImage") as? String
        redPacketCount = decoder.decodeObject(forKey: "redPacketCount") as? Int
        balanceAmount = decoder.decodeObject(forKey: "balanceAmount") as? Double
        signInToday = decoder.decodeObject(forKey: "signInToday") as? String
        yhzxShowFlag = decoder.decodeObject(forKey: "yhzxShowFlag") as? String
        gender = decoder.decodeObject(forKey: "gender") as? String
        bankCard = decoder.decodeObject(forKey: "bankCard") as? String
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(mobile, forKey: "mobile")
        aCoder.encode(sessionId, forKey: "sessionId")
        aCoder.encode(webCookies, forKey: "webCookies")
        aCoder.encode(hasPassword, forKey: "hasPassword")
        aCoder.encode(isNewUser, forKey: "isNewUser")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(idCard, forKey: "idCard")
        aCoder.encode(roleType, forKey: "roleType")
        aCoder.encode(verify, forKey: "verify")
        aCoder.encode(headImage, forKey: "headImage")
        aCoder.encode(redPacketCount, forKey: "redPacketCount")
        aCoder.encode(balanceAmount, forKey: "balanceAmount")
        aCoder.encode(yhzxShowFlag, forKey: "yhzxShowFlag")
        aCoder.encode(signInToday, forKey: "signInToday")
        aCoder.encode(gender, forKey: "gender")
        aCoder.encode(bankCard, forKey: "bankCard")
    }

}
