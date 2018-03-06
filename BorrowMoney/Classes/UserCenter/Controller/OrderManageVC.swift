//
//  OrderManageVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/15.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class OrderManageVC: BasicVC {
    var headerView : OrderHeaderView = OrderHeaderView()// 头部view
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建UI
        createUI()
    }
    
    
    // 创建UI
    func createUI() -> Void {
        self.view.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(40 * HEIGHT_SCALE)
        }
        self.headerView.orderClickBlock = {tag in
            XPrint(tag)
        }
    }
    
    override func setUpNavigationView() {
        super.setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "订单管理")
    }
    
    
    
}

