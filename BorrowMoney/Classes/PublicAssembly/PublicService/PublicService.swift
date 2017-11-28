//
//  PublicService.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/7.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class PublicService: NSObject {
    static let publicServiceInstance = PublicService()
    static let urlDataCenter : URLDataCenter = URLDataCenter()
    
    // 密码登录
    func login(userName:String,password:String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.login(mobile:userName,password:password)
        
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            failure(errorInfo)
        }
    }
    
    
    // 验证码登录
    func loginWithVerifyCode(userName:String,code:String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.loginWithCode(mobile: userName, code: code)

        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            
            let dataDict : NSDictionary = responseObject as! NSDictionary
            success(dataDict["data"] as AnyObject)
        }) { (errorInfo) in
            failure(errorInfo)
        }
    }

    
    // 获取验证码
    func requestVerificationCode(mobile:String,code:String,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        let serviceUrlCenter : URLCenter = PublicService.urlDataCenter.verificationCode(mobile: mobile, code: code)
        
        AlamofireManager.shareNetWork.postRequest(urlCenter : serviceUrlCenter, success: { (responseObject) in
            // 数据处理 json转model
            success(responseObject)
        }) { (errorInfo) in
            failure(errorInfo)
        }
    }
    
    
    
}
