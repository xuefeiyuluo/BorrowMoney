//
//  MyIntegralVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/2/27.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class MyIntegralVC: BasicVC {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "我要攒积分");
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
