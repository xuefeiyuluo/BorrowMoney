//
//  HomePageService.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/12/1.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class HomePageService: NSObject {
    static let homeInstance = HomePageService()
    static let urlDataCenter : URLDataCenter = URLDataCenter()
    
    // 首页广告信息
    func requestBannerInfo(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.bannerInfo(system:"jiedianqian")
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 首页热门贷款
    func requestHotLoanList(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.hotInfo()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 最近热搜列表
    func requestHotKeyword(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.hotInfo()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 最近热搜text
    func requestHotKeyText(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.hotKeyText()
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            SVProgressHUD.showError(withStatus: String (format: "%@%@", errorInfo.methodName,errorInfo.msg))
            XPrint("\(errorInfo.methodName)\(errorInfo.msg)")
            failure(errorInfo)
        }
    }
    
    
    // 关键词搜索
    func requestSearchText(keyword : String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.hotKeyLoanlist(keyword: keyword)
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
