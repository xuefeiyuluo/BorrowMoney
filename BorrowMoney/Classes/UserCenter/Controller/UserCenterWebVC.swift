//
//  UserCenterWebVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/2/12.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class UserCenterWebVC: BasicWebVC {

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
    
    
    // 字符串截取
    override func characterStringParseOfUrl(link: String) -> Bool {

        return true
    }
    
    
    override func loadWebViewWithUrl() {
        super.loadWebViewWithUrl()
        
        let webUrl : String = self.urlWithSession()
        let request : URLRequest = URLRequest (url: NSURL (string: webUrl)! as URL)
        self.webView?.loadRequest(request)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
