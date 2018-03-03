//
//  BasicWebVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/21.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class BasicWebVC: BasicVC, UIWebViewDelegate {

    var url : String = ""// url链接
    var webView : UIWebView?//
    var webReloadData : Bool = false// 是否刷新界面
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建webview
        createWebUI()
        
        // 页面加载
        loadWebViewWithUrl()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    
    // 创建webview
    func createWebUI() -> Void {
        let webView : UIWebView = UIWebView()
        webView.scalesPageToFit = true
        webView.delegate = self
        self.webView = webView
        self.view.addSubview(self.webView!)
        self.webView?.snp.makeConstraints({ (make) in
            make.left.right.top.bottom.equalTo(self.view)
        })
    }
    
    
    // MARK: UIWebViewDelegate
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let title : String = webView.stringByEvaluatingJavaScript(from: "document.title")!
        if title.isEmpty {
            self.navigationItem.titleView = NaviBarView().setUpNaviBarWithTitle(title: "借点钱");
        } else {
            self.navigationItem.titleView = NaviBarView().setUpNaviBarWithTitle(title: title);
        }
    }
    
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
    }
    
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let linkStr : String = (request.url?.absoluteString)!
        if linkStr.count <= 0 {
            return false
        }
        
        return characterStringParseOfUrl(link: linkStr)
    }
    
    
    // 字符串截取
    func characterStringParseOfUrl(link : String) -> Bool {
        return true
    }
    
    
    // 刷新界面
    func refreshWebView() -> Void {
        if self.webReloadData {
            self.webView?.reload()
        }
    }
    
    
    func loadWebViewWithUrl() -> Void {
        if USERINFO?.sessionId != nil{
            if (self.url.range(of: "jiedianqian") != nil) || (self.url.range(of: "rongzhijia") != nil) {
            } else {
                return
            }
        } else {
            userLogin(successHandler: { () -> (Void) in
                // 成功登录后重新加载界面
                self.loadWebViewWithUrl()
            }) { () -> (Void) in
                
            }
            return
        }
    }
    
    
    // url后添加Session
    func urlWithSession() -> String {
        if self.url.range(of: "?") != nil {
            return String (format: "%@&sessionId=", self.url,(USERINFO?.sessionId)!)
        } else {
            return String (format: "%@?sessionId=", self.url,(USERINFO?.sessionId)!)
        }
    }
    
    
    // session添加到cookie里面(待测试)
    func urlWithCookie() -> Void {
        let webUrl = NSURL (string: self.url)
        let properties : NSDictionary = NSDictionary()
        properties.setValue(USERINFO?.sessionId, forKey: HTTPCookiePropertyKey.value.rawValue)
        properties.setValue("sessionId", forKey: HTTPCookiePropertyKey.name.rawValue)
        properties.setValue(webUrl?.host, forKey: HTTPCookiePropertyKey.domain.rawValue)
        properties.setValue(NSDate (timeIntervalSinceNow: 24 * 60 * 60), forKey: HTTPCookiePropertyKey.expires.rawValue)
        properties.setValue("/", forKey: HTTPCookiePropertyKey.path.rawValue)
        let cookie : HTTPCookie = HTTPCookie (properties: properties as! [HTTPCookiePropertyKey : Any])!
        HTTPCookieStorage.shared.setCookie(cookie)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    deinit {
        self.webView?.stopLoading()
        self.webView?.delegate = nil
    }
}
