//
//  LargeOneToOneVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/9.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class LargeOneToOneVC: BasicVC {
    var dataDict : NSDictionary = [:]// 上个界面传过来

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "信贷经理一对一贷款服务");
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
