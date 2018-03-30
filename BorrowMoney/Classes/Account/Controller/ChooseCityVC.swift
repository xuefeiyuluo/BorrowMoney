//
//  ChooseCityVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/29.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class ChooseCityVC: BasicVC {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "选择城市");
    }
}
