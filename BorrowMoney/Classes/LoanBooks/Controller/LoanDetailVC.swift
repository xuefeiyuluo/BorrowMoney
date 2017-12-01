//
//  LoanDetailVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/12/2.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class LoanDetailVC: BasicVC {
    var hotLoan : HotLoanModel?{
        didSet {
            // title “贷款详情”
            self.navigationItem.titleView = NaviBarView() .setUpNaviBarWithTitle(title: String (format: "%@-%@", (hotLoan?.channelName)!,(hotLoan?.name)!));
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    override func setUpNavigationView() {
        super.setUpNavigationView()
        let rightBtn = UIButton (type: UIButtonType.custom)
        rightBtn.setTitle("贷款攻略", for: UIControlState.normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        rightBtn.setTitleColor(TEXT_LIGHT_COLOR, for:  UIControlState.normal)
        rightBtn.frame = CGRect (x: 0, y: 0, width: 60 * WIDTH_SCALE, height: 30)
        rightBtn .addTarget(self, action: #selector(tapClick), for: UIControlEvents.touchUpInside)
        rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20 * WIDTH_SCALE)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (customView: rightBtn)
    }
    
    
    // 贷款攻略的点击事件
    func tapClick() -> Void {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
