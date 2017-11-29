//
//  URLCenter.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/7.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class URLDataCenter: NSObject {
    // 登录
    public func login(mobile : String,password : String) -> URLCenter {
        URLCenter.urlCenterInstance.dict = ["mobile":mobile,"password":password]
        URLCenter.urlCenterInstance.method = "account.login"
        URLCenter.urlCenterInstance.sessionBool = false
        return URLCenter.urlCenterInstance
    }
    
    
    // 验证码登录
    public func loginWithCode(mobile : String,code : String) -> URLCenter {
        URLCenter.urlCenterInstance.dict = ["mobile":mobile,"verifyCode":code]
        URLCenter.urlCenterInstance.method = "account.do_register"
        URLCenter.urlCenterInstance.sessionBool = false
        URLCenter.urlCenterInstance.engineeringBool = false
        return URLCenter.urlCenterInstance
    }
    
    
    // 获取验证码
    public func verificationCode(mobile : String,code : String) -> URLCenter {
        URLCenter.urlCenterInstance.dict = ["mobile":mobile,"captchaCode":code]
        URLCenter.urlCenterInstance.method = "account.send_verify_code"
        URLCenter.urlCenterInstance.sessionBool = false
        URLCenter.urlCenterInstance.engineeringBool = false
        return URLCenter.urlCenterInstance
    }
    
    // 获取验证码
    public func baseInfo() -> URLCenter {
        URLCenter.urlCenterInstance.dict = [:]
        URLCenter.urlCenterInstance.method = "roleInfo.getBasicInfo"
        URLCenter.urlCenterInstance.sessionBool = true
        URLCenter.urlCenterInstance.engineeringBool = false
        return URLCenter.urlCenterInstance
    }

    // 获取验证码
    public func loginOut() -> URLCenter {
        URLCenter.urlCenterInstance.dict = [:]
        URLCenter.urlCenterInstance.method = "account.logout"
        URLCenter.urlCenterInstance.sessionBool = true
        URLCenter.urlCenterInstance.engineeringBool = false
        return URLCenter.urlCenterInstance
    }
    
    // 是否接受推送消息
    public func pushMessageChange(state : String) -> URLCenter {
        URLCenter.urlCenterInstance.dict = ["notifcationEnable":state]
        URLCenter.urlCenterInstance.method = "configure.saveNotifcationEnable"
        URLCenter.urlCenterInstance.sessionBool = true
        URLCenter.urlCenterInstance.engineeringBool = false
        return URLCenter.urlCenterInstance
    }
    
    // 查询推送消息状态
    public func requestPushMessageState() -> URLCenter {
        URLCenter.urlCenterInstance.dict = [:]
        URLCenter.urlCenterInstance.method = "configure.getNotifcationEnable"
        URLCenter.urlCenterInstance.sessionBool = true
        URLCenter.urlCenterInstance.engineeringBool = false
        return URLCenter.urlCenterInstance
    }
    
    // 修改登录密码
    public func changePassword(psw : String) -> URLCenter {
        URLCenter.urlCenterInstance.dict = ["password":psw]
        URLCenter.urlCenterInstance.method = "account.set_password"
        URLCenter.urlCenterInstance.sessionBool = true
        URLCenter.urlCenterInstance.engineeringBool = false
        return URLCenter.urlCenterInstance
    }
    
    // 大额信贷经理
    public func requestLoanOffice() -> URLCenter {
        URLCenter.urlCenterInstance.dict = [:]
        URLCenter.urlCenterInstance.method = "xdb.entry.getAlreadyContactProvider"
        URLCenter.urlCenterInstance.sessionBool = true
        URLCenter.urlCenterInstance.engineeringBool = true
        return URLCenter.urlCenterInstance
    }
    
    // 消息中心
    public func requestMessageCount() -> URLCenter {
        URLCenter.urlCenterInstance.dict = [:]
        URLCenter.urlCenterInstance.method = "notification.getNewMessageCount"
        URLCenter.urlCenterInstance.sessionBool = true
        URLCenter.urlCenterInstance.engineeringBool = false
        return URLCenter.urlCenterInstance
    }
    
    
    // 消息列表  
    public func requestMessageListData(currentPage:String,pageSize:String) -> URLCenter {
        URLCenter.urlCenterInstance.dict = ["pageNo":currentPage,"pageSize":pageSize]
        URLCenter.urlCenterInstance.method = "product.getMessageByUid"
        URLCenter.urlCenterInstance.sessionBool = true
        URLCenter.urlCenterInstance.engineeringBool = false
        return URLCenter.urlCenterInstance
    }
    
    
    // 消息列表
    public func deleteMessageData(status:String,messageId:String) -> URLCenter {
        URLCenter.urlCenterInstance.dict = ["status":status,"message_id":messageId]
        URLCenter.urlCenterInstance.method = "product.updateMessage"
        URLCenter.urlCenterInstance.sessionBool = true
        URLCenter.urlCenterInstance.engineeringBool = false
        return URLCenter.urlCenterInstance
    }
    
    // 全部已读消息列表
    public func allMessageData() -> URLCenter {
        URLCenter.urlCenterInstance.dict = [:]
        URLCenter.urlCenterInstance.method = "product.markAllMessageAsRead"
        URLCenter.urlCenterInstance.sessionBool = true
        URLCenter.urlCenterInstance.engineeringBool = false
        return URLCenter.urlCenterInstance
    }

    // 还款管理列表
    public func repayManageData() -> URLCenter {
        URLCenter.urlCenterInstance.dict = [:]
        URLCenter.urlCenterInstance.method = "roleInfo.loanList"
        URLCenter.urlCenterInstance.sessionBool = true
        URLCenter.urlCenterInstance.engineeringBool = false
        return URLCenter.urlCenterInstance
    }

    // 设为已还
    public func requestMakeRepaid(planId : String) -> URLCenter {
        URLCenter.urlCenterInstance.dict = ["ids":planId]
        URLCenter.urlCenterInstance.method = "roleInfo.makeRepaid"
        URLCenter.urlCenterInstance.sessionBool = true
        URLCenter.urlCenterInstance.engineeringBool = false
        return URLCenter.urlCenterInstance
    }
    
    // 账户异常
    public func accountAbnormal(accountId : String) -> URLCenter {
        URLCenter.urlCenterInstance.dict = ["id":accountId]
        URLCenter.urlCenterInstance.method = "roleInfo.flushStatus"
        URLCenter.urlCenterInstance.sessionBool = true
        URLCenter.urlCenterInstance.engineeringBool = false
        return URLCenter.urlCenterInstance
    }
}




