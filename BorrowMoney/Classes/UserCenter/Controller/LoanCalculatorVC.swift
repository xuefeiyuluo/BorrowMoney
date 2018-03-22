//
//  LoanCalculatorVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/2/27.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class LoanCalculatorVC: BasicVC, UIWebViewDelegate {
    var headerView : CalculatorHeaderView = CalculatorHeaderView()// 头部
    var webView : UIWebView = UIWebView()
    var urlArray : [String] = [String]()// url列表
    var tagSelected : Int = 0// 选中的tag
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建UI
        createUI()
        
        // 加载html
        loadWebViewWithUrl(url: self.urlArray[0])
    }
    
    
    // 创建UI
    func createUI() -> Void {
        // 头部View
        self.view.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(40 * HEIGHT_SCALE)
        }
        weak var weakSelf = self
        self.headerView.calculatorBlock = { (tag) in
            XPrint(tag)
            weakSelf?.tagSelected = tag
            weakSelf?.loadWebViewWithUrl(url: self.urlArray[tag])
        }
        
        
        // webView
        self.webView.scalesPageToFit = true
        self.webView.delegate = self
        self.view.addSubview(self.webView)
        self.webView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.headerView.snp.bottom)
        }
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
        
        return true
    }
    
    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "贷款计算器");
    }
    
    
    // 初始化数据
    override func initializationData() {
        super.initializationData()
        
        self.urlArray = ["http://www.jiedianqian.com/calc/indexnew.html","http://www.jiedianqian.com/calc/cindex.html","http://www.jiedianqian.com/calc/findex.html","http://www.jiedianqian.com/calc/gindex.html"];
    }
    
    
    // 加载url
    func loadWebViewWithUrl(url : String) -> Void {
        if USERINFO?.sessionId != nil{
            if (url.range(of: "jiedianqian") != nil) || (url.range(of: "rongzhijia") != nil) {
                let webUrl : String = self.urlWithSession(url: url)
                let request : URLRequest = URLRequest (url: NSURL (string: webUrl)! as URL)
                self.webView.loadRequest(request)
            } else {
                return
            }
        } else {
            userLogin(successHandler: { () -> (Void) in
                // 成功登录后重新加载界面
                self.loadWebViewWithUrl(url: self.urlArray[self.tagSelected])
            }) { () -> (Void) in
            }
            return
        }
    }
    
    
    // url后添加Session
    func urlWithSession(url : String) -> String {
        if url.range(of: "?") != nil {
            return String (format: "%@&sessionId=", url,(USERINFO?.sessionId)!)
        } else {
            return String (format: "%@?sessionId=", url,(USERINFO?.sessionId)!)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
