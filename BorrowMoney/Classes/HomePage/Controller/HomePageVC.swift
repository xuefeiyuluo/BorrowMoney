//
//  HomePageVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/10/12.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class HomePageVC: BasicVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        let view = UIView (frame: CGRect (x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64 - 44))
        
        view.backgroundColor = MAIN_COLOR
        self.view .addSubview(view)
        
        
        let btn = UIButton (type: .custom)
        btn.frame = CGRect (x: 100, y: 100, width: 100, height: 30)
        btn.setTitle("点击", for: .normal)
        btn.backgroundColor = UIColor .yellow
        btn .addTarget(self, action: #selector(tapClick), for: UIControlEvents.touchUpInside)
        self.view .addSubview(btn)
    }

    
    func tapClick() -> () {
        userLogin(successHandler: { () -> (Void) in
            XPrint("成功。。。。。")
        }) { () -> (Void) in
            XPrint("失败。。。。。")
        }
    }

    override func setUpNavigationView() {
        super.setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "首页");
        self.navigationItem .leftBarButtonItem = nil
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
