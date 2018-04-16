//
//  UserEvaluateVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/12.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class UserEvaluateVC: BasicVC {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "用户评价");
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
