//
//  RepayRecordVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/29.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class RepayRecordVC: BasicVC {
    var loanModel : LoanManageData?//

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "还款记录");
    }
    
    
    
    // 创建当前的类
    func createCurrentClass(loanData : LoanManageData) -> BasicVC {
        let repayRecord : RepayRecordVC = RepayRecordVC()
        self.loanModel = loanData
        return repayRecord
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
