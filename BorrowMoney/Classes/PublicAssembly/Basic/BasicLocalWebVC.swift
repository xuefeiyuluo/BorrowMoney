//
//  BasicLocalWebVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/3.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class BasicLocalWebVC: BasicVC, UIWebViewDelegate {
    var path : String = ""// 路径地址
    var webView : UIWebView?//
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建webview
        createWebUI()
        
        // 页面加载
        loadWebViewWithHtml()
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
        
        
        return true
    }
    
    
    func loadWebViewWithHtml() -> Void {
        if USERINFO?.sessionId != nil{
            // 加载html代码
//            let filepath : NSString = Bundle.main.path(forResource: "redPackExplain", ofType: "html")! as NSString
//            self.webView?.loadHTMLString(filepath as String, baseURL: nil)
            
            let urlStr = NSURL.fileURL(withPath: self.path)
            self.webView?.loadRequest(NSURLRequest.init(url: urlStr) as URLRequest)
        } else {
            userLogin(successHandler: { () -> (Void) in
                // 成功登录后重新加载界面
                self.loadWebViewWithHtml()
            }) { () -> (Void) in
                
            }
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
