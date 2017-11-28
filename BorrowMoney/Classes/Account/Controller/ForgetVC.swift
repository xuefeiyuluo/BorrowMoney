//
//  ForgetVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/3.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class ForgetVC: BasicVC {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "忘记密码");
    }
}
