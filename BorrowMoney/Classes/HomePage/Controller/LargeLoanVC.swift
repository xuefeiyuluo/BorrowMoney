//
//  LargeLoanVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/2/26.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class LargeLoanVC: BasicVC {

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "大额贷款");
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
