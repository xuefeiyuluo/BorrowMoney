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
            failure(errorInfo)
        }
    }
}
