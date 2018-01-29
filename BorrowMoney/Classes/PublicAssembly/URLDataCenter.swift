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
        let param : URLCenter = URLCenter()
        param.dict = ["mobile":mobile,"password":password]
        param.method = "account.login"
        param.sessionBool = false
        return param
    }
    
    
    // 验证码登录
    public func loginWithCode(mobile : String,code : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["mobile":mobile,"verifyCode":code]
        param.method = "account.do_register"
        param.sessionBool = false
        return param
    }
    
    
    // 获取验证码
    public func verificationCode(mobile : String,code : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["mobile":mobile,"captchaCode":code]
        param.method = "account.send_verify_code"
        param.sessionBool = false
        return param
    }
    
    // 个人中心
    public func baseInfo() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "roleInfo.getBasicInfo"
        return param
    }

    // 退出登录
    public func loginOut() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "account.logout"
        return param
    }
    
    // 是否接受推送消息
    public func pushMessageChange(state : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["notifcationEnable":state]
        param.method = "configure.saveNotifcationEnable"
        return param
    }
    
    // 查询推送消息状态
    public func requestPushMessageState() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "configure.getNotifcationEnable"
        return param
    }
    
    // 修改登录密码
    public func changePassword(psw : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["password":psw]
        param.method = "account.set_password"
        return param
    }
    
    // 大额信贷经理
    public func requestLoanOffice() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "xdb.entry.getAlreadyContactProvider"
        param.engineeringBool = true
        return param
    }
    
    // 消息中心
    public func requestMessageCount() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "notification.getNewMessageCount"
        param.loadingIcon = false
        return param
    }
    
    
    // 消息列表  
    public func requestMessageListData(currentPage:String,pageSize:String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["pageNo":currentPage,"pageSize":pageSize]
        param.method = "product.getMessageByUid"
        return param
    }
    
    
    // 消息列表
    public func deleteMessageData(status:String,messageId:String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["status":status,"message_id":messageId]
        param.method = "product.updateMessage"
        return param
    }
    
    // 全部已读消息列表
    public func allMessageData() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "product.markAllMessageAsRead"
        return param
    }

    // 还款管理列表
    public func repayManageData() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "roleInfo.loanList"
        return param
    }

    // 设为已还
    public func requestMakeRepaid(planId : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["ids":planId]
        param.method = "roleInfo.makeRepaid"
        return param
    }
    
    // 账户异常
    public func accountAbnormal(accountId : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["id":accountId]
        param.method = "roleInfo.flushStatus"
        return param
    }
    
    // 首页广告信息
    public func bannerInfo(system : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["system":system]
        param.method = "appBanner.getBanner"
        return param
    }
    
    
    // 首页热门贷款
    public func hotInfo() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "rank.getHotLoan"
        return param
    }
    
    // 最近热搜
    public func hotKeyword() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "rank.getHotLoan"
        return param
    }
    
    // 贷款大全 贷款类型
    public func requestLoanType() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "rank.getTagList"
        return param
    }
    
    // 贷款大全 贷款金额
    public func requestLoanAmountRank() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "rank.getSearchAmount"
        return param
    }
    

    // 贷款大全贷款列表
    public func loanBooksList(rankType : String,loanTagId : String,leftRange : String,rightRange : String,offset : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["rankType":rankType,"loanTagId":loanTagId,"leftRange":leftRange,"rightRange":rightRange,"offset":offset,"returnType":"returnList","pageSize":"10"]
        param.method = "rank.getRecommendation"
        return param
    }
}




