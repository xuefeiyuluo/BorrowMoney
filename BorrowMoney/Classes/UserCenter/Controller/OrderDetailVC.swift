//
//  OrderDetailVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/6.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class OrderDetailVC: BasicVC {
    var orderModel : OrderManageModel?// 订单列表模型
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    override func setUpNavigationView() {
        super.setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "订单详情")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
