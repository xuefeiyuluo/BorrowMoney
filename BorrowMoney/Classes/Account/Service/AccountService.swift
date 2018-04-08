//
//  AccountService.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/2.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class AccountService: NSObject {
    static let accountInstance = AccountService()
    static let urlDataCenter : URLDataCenter = URLDataCenter()
    
    // 获取城市列表
    func requestCityResultList(success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.allCityList()
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
