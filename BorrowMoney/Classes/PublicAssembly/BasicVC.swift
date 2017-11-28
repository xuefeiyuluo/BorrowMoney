//
//  BasicVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/10/24.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class BasicVC: UIViewController {

    var navigationLine : Bool? {
        didSet {
            if navigationLine! {
                // 隐藏navigationBar下面的一条横线
                self.navigationController?.navigationBar .setBackgroundImage(UIImage(), for: UIBarMetrics.default)
                self.navigationController?.navigationBar.shadowImage = UIImage()
            } else {
                self.navigationController?.navigationBar .setBackgroundImage(nil, for: UIBarMetrics.default)
                self.navigationController?.navigationBar.shadowImage = nil
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view .backgroundColor = MAIN_COLOR
        
        // 设置导航栏
        setUpNavigationView()
    }
    
    // 设置导航栏
    func setUpNavigationView() -> () {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = NAVIGATION_COLOR
        self.navigationItem .leftBarButtonItem = NaviBarView() .addBarButtonItem(target: self, action: #selector(comeBack))
    }
    
    
    // 返回上一个界面
    func comeBack() -> () {
        self.view .endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
