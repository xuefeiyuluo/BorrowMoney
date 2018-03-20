//
//  MechanismLoginVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/20.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class MechanismLoginVC: BasicVC {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    override func setUpNavigationView() {
        super.setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "机构登录")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
