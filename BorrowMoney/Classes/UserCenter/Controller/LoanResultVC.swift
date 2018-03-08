//
//  LoanResultVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/7.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class LoanResultVC: BasicVC {
    var loanOrder : LoanOrderModel?//
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func setUpNavigationView() {
        super.setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "查询\"\"贷款结果")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
