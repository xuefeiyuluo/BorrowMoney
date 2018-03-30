//
//  UserCenterService.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/15.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import Foundation

class UserCenterService: NSObject {
    static let userInstance = UserCenterService()
    static let urlDataCenter : URLDataCenter = URLDataCenter()
    
    // 基本细信息
    func baseInfo(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.baseInfo()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 退出登录
    func loginOut(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.loginOut()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            success(responseObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    // 是否接受消息推送
    func pushMessageChangeStates(state : String, success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.pushMessageChange(state: state)
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            success(responseObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    // 查询消息推送状态
    func requestPushMessageChangeStates(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestPushMessageState()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 修改登录密码
    func changePassword(psw : String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.changePassword(psw : psw)
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 大额信贷经理
    func requestLoanOfficeSate(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestLoanOffice()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 消息中心
    func requestMessageSate(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestMessageCount()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    // 消息列表
    func requestMessageListData(currentPage:String,pageSize:String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestMessageListData(currentPage: currentPage, pageSize: pageSize)
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 更改某条消息的状态
    func updateMessageData(state:String,messageId:String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.deleteMessageData(status: state, messageId: messageId)
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            
            success(dataDict as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    // 更改某条消息的状态
    func allMessageData(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.allMessageData()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            
            success(dataDict as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 还款管理列表
    func requestRepayManageListData(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.repayManageData()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }

    // 设为已还
    func requestMakeRepaids(planId : String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestMakeRepaid(planId: planId)
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            
            success(dataDict as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    // 账户异常
    func requestAccountError(accountId : String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.accountAbnormal(accountId: accountId)
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            
            success(dataDict as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 我的现金
    func requestMyCash(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestMyCashInfo()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    // 资金明细
    func requestCaptialList(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestCaptialDetail()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    // 银行列表
    func requestBankListData(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestBankList()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 银行卡号验证
    func requestBankCardVerify(cardNo : String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestBankCardVerify(cardNo: cardNo)
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    

    // 银行卡code
    func requestBankCardRequestId(mobilePhone : String,cardNo : String,name : String,idCard : String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestBankCardId(mobilePhone: mobilePhone, cardNo: cardNo, name: name, idCard: idCard)
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 银行卡认证
    func requestCompeleBankCardVerify(verifyCode : String,mobilePhone : String,requestId : String,bankName : String,cardNo : String,name : String,idCard : String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestCompeleBankCardVerify(verifyCode: verifyCode, mobilePhone: mobilePhone, requestId: requestId, bankName: bankName, cardNo: cardNo, name: name, idCard: idCard)
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            
            success(dataDict)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 免息卷列表界面
    func requestDiscountList(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestDiscountlist()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 获取积分数量
    func requestIntegralAmount(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestIntegralAmount()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 获取积分信息
    func requestIntegralInfo(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestIntegralInfo()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 获取订单管理列表
    func requestOrderManageList(state : String,pageNo : String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestOrderList(status: state, pageNo: pageNo)
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 获取还款管理推荐列表
    func requestRepayRecommendList(pageNo : String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestRepayRecommendList(pageNo: pageNo)
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 获取订单详情
    func requestOrderDetailInfo(orderId: String,loanType : String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestOrderDetail(orderId: orderId, loanType: loanType)
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            if !(dataDict["data"] is NSNull) {
                success(dataDict["data"] as AnyObject)
            }
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 获取推荐列表
    func requestRecommendList(pageNo: String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestRecommendList(pageNo: pageNo)
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    

    // 获取账单详情数据
    func requestBillDetailData(loanId: String,loanType : String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestBillDetail(loanId: loanId, loanType: loanType)
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 获取账单详情 设为已还
    func requestBillMakeRepaid(ids: String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestBillRepaid(ids: ids)
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    // 账号管理
    func requestAccountManage(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestAccountManage()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 添加机构列表
    func requestAddOrganList(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestAddOrganList()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    

    // 更改机构的状态
    func requestUpdateChannelState(channelId : String,loanUserName : String,loanPassword : String,delFlag : String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestUpdateChannelSatet(channelId: channelId, loanUserName: loanUserName, loanPassword: loanPassword, delFlag: delFlag)
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 更改机构的状态
    func requestAddChannelState(channelId : String,loanUserName : String,loanPassword : String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestAddChannelSatet(channelId: channelId, loanUserName: loanUserName, loanPassword: loanPassword)
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    

    // 获取机构登录的提示信息
    func requestChannelLoginPlaceholder(channelId : String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestChannelPlaceholder(channelId: channelId)
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 获取积分明细列表
    func requestIntergralDetailList(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestIntegralDetail()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 获取评价的标签列表
    func requestEvaluateMarkList(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestEvaluateList()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
}
