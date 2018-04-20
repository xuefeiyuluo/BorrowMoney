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

    
    // 获取定位城市信息
    public func locationCityInfo(city : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["name":city]
        param.method = "xdb.entry.getCityByName"
        param.engineeringBool = true
        param.loadingIcon = false
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
    
    // 最近热搜列表
    public func hotKeyword() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "rank.getHotLoan"
        return param
    }
    
    
    // 最近热搜词
    public func hotKeyText() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "rank.getHotKeyword"
        return param
    }
    
    
    // 根据热搜词列表
    public func hotKeyLoanlist(keyword:String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "rank.searchProduct"
        param.dict = ["keyword":keyword]
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
    

    // 贷款详情
    public func requestLoanDetailInfo(productId : String,rzj : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["product_id":productId,"rzj_s":rzj]
        param.method = "rank.getProductDetail"
        return param
    }
    
    
    // 贷款详情 用户评价
    public func requestEvaluateList(productId : String,pageNo : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["product_id":productId,"pageNo":pageNo]
        param.method = "product.getCommentByPidV2"
        return param
    }
    
    
    // 贷款详情 用户基本信息
    public func requestLoanUserInfo() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "roleInfo.getUserBasicInfo"
        return param
    }
    
    
    // 贷款详情 未登录时申请资料的接口
    public func requestApplicantInfo(productId : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["productId":productId]
        param.method = "application.getApplicationInfoWithoutLogin"
        return param
    }

    
    // 贷款详情 获取用户的角色信息
    public func requestRoleInfo() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "roleInfo.getRole"
        return param
    }

    
    // 贷款详情 已登录时申请资料的接口
    public func requestApplicantLoginInInfo(productId : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["product_id":productId]
        param.method = "application.getApplicationInfoV2"
        return param
    }
    
    
    // 我的现金 基本信息
    public func requestMyCashInfo() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "mgm.getBalance"
        return param
    }
    
    // 资金明细
    public func requestCaptialDetail() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["type":"all"]
        param.method = "mgm.getWalletDetail"
        return param
    }
    
    
    // 银行列表
    public func requestBankList() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "mgm.getBankList"
        return param
    }
    
    
    // 银行卡正确性认证
    public func requestBankCardVerify(cardNo : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["cardNo":cardNo]
        param.method = "mgm.verifyBank"
        return param
    }
    
    
    // 银行卡id
    public func requestBankCardId(mobilePhone : String,cardNo : String,name : String,idCard : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["mobilephone":mobilePhone,"cardNo":cardNo,"name":name,"idCard":idCard]
        param.method = "mgm.send_bind_card_verify_code"
        return param
    }
    

    // 完成银行卡认证
    public func requestCompeleBankCardVerify(verifyCode : String,mobilePhone : String,requestId : String,bankName : String,cardNo : String,name : String,idCard : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["verifyCode":verifyCode,"mobilephone":mobilePhone,"requestId":requestId,"bankName":bankName,"cardNo":cardNo,"ownerName":name,"ownerIdcard":idCard]
        param.method = "mgm.bindBank"
        return param
    }
    
    
    // 免息卷列表
    public func requestDiscountlist() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "mgm.getMyRedPacket"
        return param
    }
    
    
    //  积分数量
    public func requestIntegralAmount() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "taskCenter.getBalance"
        return param
    }
    
    
    //  积分信息
    public func requestIntegralInfo() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "taskCenter.getUserTaskList"
        return param
    }
    

    //  订单管理列表
    public func requestOrderList(status : String,pageNo : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["status":status,"pageSize":"10","pageNo":pageNo]
        param.method = "userOrder.queryOrderList"
        return param
    }
    

    //  还款管理推荐列表
    public func requestRepayRecommendList(pageNo : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["pageSize":"10","pageNo":pageNo]
        param.method = "roleInfo.recommendLoan"
        return param
    }
    
    
    //  订单详情
    public func requestOrderDetail(orderId : String,loanType : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["orderId":orderId,"loanType":loanType]
        param.method = "userOrder.queryOrderDetail"
        return param
    }
    

    //  推荐列表
    public func requestRecommendList(pageNo : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["pageNo":pageNo,"pageSize":"10"]
        param.method = "roleInfo.recommendLoan"
        return param
    }

    
    //  账单详情
    public func requestBillDetail(loanId : String,loanType : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["id":loanId,"loanType":loanType]
        param.method = "roleInfo.loanDetail"
        return param
    }
    

    //  账单详情 设为已还
    public func requestBillRepaid(ids : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["ids":ids]
        param.method = "roleInfo.makeRepaid"
        return param
    }
    
    
    // 账号管理列表 
    public func requestAccountManage() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "userAccount.getAccouns"
        return param
    }
    
    
    // 添加机构列表
    public func requestAddOrganList() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "userAccount.getEnableChannel"
        return param
    }
    
    
    // 更新机构状态
    public func requestUpdateChannelSatet(channelId : String,loanUserName : String,loanPassword : String,delFlag : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["channelId":channelId,"loanUserName":loanUserName,"loanPassword" : loanPassword,"delFlag" : delFlag]
        param.method = "userAccount.updateAccount"
        return param
    }
    
    
    
    // 添加机构
    public func requestAddChannelSatet(channelId : String,loanUserName : String,loanPassword : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["channelId":channelId,"loanUserName":loanUserName,"loanPassword" : loanPassword]
        param.method = "userAccount.addAccount"
        return param
    }
    
    
    // 获取机构登录的提示信息
    public func requestChannelPlaceholder(channelId : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["channelId":channelId]
        param.method = "userAccount.getChannelTip"
        return param
    }
    
    
    // 获取积分明细列表
    public func requestIntegralDetail() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "taskCenter.getGoldRecord"
        return param
    }
    
    
    // 获取评价的标签列表
    public func requestEvaluateList() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "product.getCommentTagList"
        return param
    }
    
    
    // 获取所有城市
    public func allCityList() -> URLCenter {
        let param : URLCenter = URLCenter()
        param.method = "roleInfo.getCity"
        return param
    }
    
    
    // 获取信贷员列表
    public func loanListData(cityId : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["cityId":cityId]
        param.engineeringBool = true
        param.method = "xdb.entry.getProviderService"
        return param
    }
    
    
    // 提交用户信息
    public func userIfo(attributeName : String,value : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["attribute_name":attributeName,"value" : value]
        param.method = "roleInfo.changeBasicInfo"
        return param
    }

    
    // 提交信贷经理
    public func creditManager(applyAmount : String,applyTerm : String,idCard : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["applyAmount":applyAmount,"applyTermMouth" : applyTerm,"idCard" : idCard]
        param.engineeringBool = true
        param.method = "xdb.entry.checkLargeLoanApply"
        return param
    }
    
    
    // 判断是否可以拨打电话
    public func beforeCall(applyAmount : String,applyTerm : String,card : String,city : String,name : String,providerId : String,spreadType : String,spreadTypeName : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["applyAmount":applyAmount,"applyTermMouth" : applyTerm,"card" : card,"city" : city,"name":name,"providerId" : providerId,"spreadType" : spreadType,"spreadTypeName" : spreadTypeName]
        param.engineeringBool = true
        param.method = "xdb.entry.checkLargeLoanApply"
        return param
    }
    

    // 判断是否可以拨打电话
    public func callResult(recordId : String) -> URLCenter {
        let param : URLCenter = URLCenter()
        param.dict = ["recordId":recordId]
        param.engineeringBool = true
        param.method = "xdb.entry.getCallProviderStatus"
        return param
    }
    
    //  查询xx贷款结果
//    public func requestLoanResult(status : String,pageNo : String) -> URLCenter {
//        let param : URLCenter = URLCenter()
//        param.dict = ["status":status,"pageSize":"10","pageNo":pageNo]
//        param.method = "userOrder.queryOrderList"
//        return param
//    }
}




