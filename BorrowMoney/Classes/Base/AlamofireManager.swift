//
//  AlamofireManager.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/3.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit
import Alamofire

final class AlamofireManager: NSObject {
    static let shareNetWork = AlamofireManager()
    static let secret = "fbcf15e88f1b821cb9a1b4446cea1e8f"
    var alertView : UIAlertView?//"-8"重新登录弹框
    
    // get请求
    func getRequest(urlCenter : URLCenter,params:NSMutableDictionary,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-type":"application/json;charset=utf-8"
//            "Accept": "text/javascript",
//            "Accept": "text/html",
//            "Accept": "text/plain"
        ]
        
        Alamofire.request(urlCenter.method as String, method: .get, parameters:params as? Parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject:DataResponse<Any>) in
            switch(responseObject.result){
            case .success(let value):
                
                
                
                success(value as AnyObject)
                break
            case .failure(let error):
                let errorInfo = self.handleFailResult(error: error,urlCenter : urlCenter)
                failure(errorInfo)
                break
            }
        }
    }
    
    
    // post请求
    func postRequest(urlCenter : URLCenter,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        if urlCenter.loadingIcon {
            SVProgressHUD.show()
        }
        
        let headers: HTTPHeaders = ["Accept": "application/json","Content-type":"application/json;charset=utf-8"]
        
        // 设置请求超时时长
        self.setRequestTimeOut()
        
        // 数据组装
        let dict : NSMutableDictionary = self.requestDataAssemble(urlCenter: urlCenter)
        
        Alamofire.request(SERVERURL as String, method: .post, parameters:dict as? Parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (responseObject:DataResponse<Any>) in
            switch(responseObject.result){
            case .success(let value):
                SVProgressHUD .dismiss()
                // 返回结果处理
                self.handleSuccessResult(value: value, success: success, failure: failure)
                break
            case .failure(let error):
                SVProgressHUD .dismiss()
                let errorInfo = self.handleFailResult(error: error,urlCenter : urlCenter)
                failure(errorInfo)
                break
            }
        }
    }
    
    
    // post json数据请求
    func postJsonRequest(url:String,params:NSMutableDictionary,success:@escaping (AnyObject)->(),failure:@escaping (Error)->()) -> Void {
        
    }
    
    
    // 上传图片
    func imageRequest(url:String,params:NSMutableDictionary,success:@escaping (AnyObject)->(),failure:@escaping (Error)->()) -> Void {
        Alamofire.upload(multipartFormData: { (multipartFormData:MultipartFormData) in
            
            for (key, value)in params {
                if value is Data || value is NSData {
                    let imageName = String(describing: NSDate()).appending(".png")
                    multipartFormData.append(value as! Data, withName: key as! String, fileName: imageName, mimeType: "image/png")
                } else {
                    let str:String = value as! String
                    multipartFormData.append(str.data(using: .utf8)!, withName: key as! String)
                    
                }
                
            }
        }, to: url) { (responseObject:SessionManager.MultipartFormDataEncodingResult) in
            switch responseObject {
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler: { (response:DataResponse<Any>) in
                    switch(response.result) {
                    case .success(let value):
                        
                        let dic:NSDictionary = value as! NSDictionary
                        let status:NSNumber = dic.object(forKey:"success") as! NSNumber
                        if status.isEqual(to: NSNumber.init(value: 0)) {
                            
                            //返回错误码
                            success(dic.object(forKey: "code") as AnyObject)
                            
                        } else {
                            
                            let resultData:NSString = dic.object(forKey: "result") as! NSString
                            
                            if resultData.length == 0 {
                                //123456代表没有数据
                                success(NSNumber.init(value: 123456) as AnyObject)
                                
                            } else {
                                
                                //base64解码
                                let decodedData = NSData.init(base64Encoded: dic.object(forKey: "result") as! String, options: NSData.Base64DecodingOptions.init(rawValue: 0))
                                
                                let decodedString:NSString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue)!
                                
                                //解析json字符串
                                let data:Data = decodedString.data(using: String.Encoding.utf8.rawValue)!
                                let resultDic = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                                success(resultDic as AnyObject)
                            }
                        }
                        break
                    case .failure(let error):
                        failure(error)
                        break
                    }
                })
                break
            case .failure(let error):
                failure(error)
                break;
            }
        }
    }
    
    
    // 处理成功结果
    func handleSuccessResult(value : Any,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        SVProgressHUD .dismiss()
        let resultDict : NSMutableDictionary = NSMutableDictionary (dictionary: (value as! NSDictionary))
        // "0"请求成功
        if resultDict["code"] is NSNumber {
            resultDict .setValue((resultDict["code"] as! NSNumber).stringValue, forKey: "code")
        }
        
        if resultDict["code"] as! String == "0" {
            success(resultDict as AnyObject)
        } else {
            self.errorResult(resultDict: resultDict, success: success, failure:failure)
        }
    }
    
    
    // 处理请求成功但返回的一些错误信息
    func errorResult(resultDict : NSDictionary,success:@escaping (AnyObject)->(),failure:@escaping (ErrorInfo)->()) -> Void {
        // 登录超时，重新登录界面
        if (resultDict["code"]as! String) == "-8" {
            USERDEFAULT.clearUserDefaultsData()
            NotificationCenter.default.post(name: NSNotification.Name (rawValue: "NotificationLoginOut"), object: nil)

            if self.alertView == nil {
                self.alertView = UIAlertView (title: "登录失效，请重新登录", message: "", delegate: nil, cancelButtonTitle: "取消", otherButtonTitles: "登录")
                showAlertView(alertView: self.alertView!)
            } else {
                if (self.alertView?.isVisible)! == false{
                    showAlertView(alertView: self.alertView!)
                }
            }
            
        // 短信发送触发图形码验证
        } else if (resultDict["code"]as! String) == "-69" {
            success(resultDict)
        } else {
            SVProgressHUD .showError(withStatus: resultDict["desc"]as! String)
        }
    }
    
    
    // 显示登录弹框
    func showAlertView(alertView : UIAlertView) -> Void {
        alertView.showWithAlertBlock(alertBlock: { (btnIndex, btnTitle) in
            if btnIndex != 0 {
                userLogin(successHandler: { () -> (Void) in
                }) { () -> (Void) in
                    // 跳转贷款大全
                    APPDELEGATE.tabBarControllerSelectedIndex(index: 1)
                }
            }
        })
    }
    
    
    // 处理失败结果
    func handleFailResult(error : Error,urlCenter : URLCenter) -> (ErrorInfo) {
        let errorInfo = ErrorInfo()
        errorInfo.methodName = urlCenter.method
        errorInfo.error = error
        return errorInfo
    }
    
    
    // 请求数据组装
    func requestDataAssemble(urlCenter : URLCenter) -> (NSMutableDictionary) {
        let dict : NSMutableDictionary = NSMutableDictionary (dictionary: urlCenter.dict)
        dict .setObject(self.requestTimeInterval(), forKey: "timestamp" as NSCopying)
        dict .setObject("b28f79b83f1e1862", forKey: "appkey" as NSCopying)
        dict .setObject("1.0", forKey: "version" as NSCopying)
        dict .setObject("MD5", forKey: "signType" as NSCopying)
        dict .setObject(CURRENTVERSION, forKey: "appVersion" as NSCopying)
        dict .setObject("IOS", forKey: "deviceType" as NSCopying)
        dict.setObject("jiedianqian", forKey: "system" as NSCopying)
        dict.setObject(BASICINFO?.uuid! as Any, forKey: "uid" as NSCopying)
        var method : String = urlCenter.method
        if !urlCenter.engineeringBool {
            method = "jiedianqian.".appending(method)
        } else {
            
        }
        dict .setObject(method, forKey: "method" as NSCopying)
        if urlCenter.sessionBool {
            if USERINFO?.sessionId != nil{
                dict .setObject(USERINFO?.sessionId! as Any, forKey: "sessionId" as NSCopying)
            }
        }
        dict .setObject(self.createMd5Sign(dict: dict), forKey: "sign" as NSCopying)
        return dict
    }
    
    
    // 当前时间的时间戳
    func requestTimeInterval() -> (String) {
        let currentDate = NSDate()
        let timeInterval : TimeInterval = currentDate.timeIntervalSince1970
        let timeStamp = String (format: "%i", Int(timeInterval))
        return timeStamp
    }
    
    
    // md5加密
    func createMd5Sign(dict : NSDictionary) -> (String) {
        var contentString = String()
        let tempArray = dict.allKeys
        let keyArray : NSArray =  (tempArray as NSArray).sortedArray(comparator: { (obj1 : Any, obj2 : Any) -> ComparisonResult in
            return (obj1 as! String).compare(obj2 as! String)
        }) as NSArray
        
        for i in 0 ..< keyArray.count {
            let key : String = keyArray[i] as! String
            if !(dict[key] as! String == "") && !(key == "sign"){
                if i == keyArray .count - 1 {
                   contentString = contentString.appendingFormat("%@=%@",key,(dict[key] as! String) .removingPercentEncoding!)
                } else {
                    contentString = contentString.appendingFormat("%@=%@&",key,(dict[key] as! String) .removingPercentEncoding!)
                }
            }
        }
        
        let tempSign = contentString.md5.appending(AlamofireManager.secret)
        let md5Sign = tempSign.md5
        return md5Sign
    }
    
    
    // 设置请求超时时长
    func setRequestTimeOut() -> Void {
        var sessionManager:Alamofire.SessionManager!
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
}
