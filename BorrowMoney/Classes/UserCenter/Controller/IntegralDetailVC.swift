//
//  IntegralDetailVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/4.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class IntegralDetailVC: BasicVC {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "积分明细");
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}