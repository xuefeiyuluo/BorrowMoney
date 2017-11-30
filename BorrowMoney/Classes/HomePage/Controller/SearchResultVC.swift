//
//  SearchResultVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/30.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class SearchResultVC: BasicVC {

    var navigationView : SearchNavigationView?//
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 隐藏导航栏
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建自定义导航栏
        createCustomNavigationView()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 显示导航栏
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    // 创建自定义导航栏
    func createCustomNavigationView() -> Void {
        let navigationView : SearchNavigationView = SearchNavigationView()
        self.navigationView = navigationView
        self.view.addSubview(self.navigationView!)
        self.navigationView?.snp.makeConstraints({ (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(64)
        })
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
