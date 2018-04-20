//
//  LoanBooksService.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/1/25.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class LoanBooksService: NSObject {
    static let loanInstance = LoanBooksService()
    static let urlDataCenter : URLDataCenter = URLDataCenter()
    
    // 贷款大全列表
    func requestLoanBooksList(rankType:String,loanTagId:String,leftRange:String,rightRange:String,offset:String,  success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.loanBooksList(rankType: rankType, loanTagId: loanTagId, leftRange: leftRange, rightRange: rightRange, offset: offset)
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 贷款大全 贷款类型
    func requestLoanType(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestLoanType()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 贷款大全 贷款金额区间
    func requestLoanAmontRank(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestLoanAmountRank()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }

    
    // 贷款详情界面
    func requestLoanDetailInfo(productId : String,rzj : String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestLoanDetailInfo(productId: productId, rzj: rzj)
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 贷款详情界面 用户评价
    func requestEvaluateList(productId : String,pageNo : String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestEvaluateList(productId: productId, pageNo: pageNo)
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 贷款详情 用户的基本信息
    func requestLoanUserBaseInfo(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestLoanUserInfo()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 贷款详情 未登录时申请资料的接口
    func requestApplicantLoginOut(productId : String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestApplicantInfo(productId: productId)
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 贷款详情 获取用户的角色信息
    func requestLoanRoleInfo(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestRoleInfo()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 贷款详情 已登录时申请资料的接口
    func requestApplicantLoginIn(productId : String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.requestApplicantLoginInInfo(productId: productId)
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
