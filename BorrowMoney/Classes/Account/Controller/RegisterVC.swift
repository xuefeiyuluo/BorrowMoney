//
//  RegisterVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/3.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class RegisterVC: BasicVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    // 创建界面
    func createUI() -> Void {

    
    }

    
    
    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "注册");
    }
}
