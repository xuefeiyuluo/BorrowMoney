//
//  TabBarController.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/10/12.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置所有UITabBarItem的文字属性
        setupItemTitleTextAttributes()
        
        // 添加子控制器
        setupChildViewControllers()
    }

    // 设置所有UITabBarItem的文字属性
    fileprivate func setupItemTitleTextAttributes() {
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = MAIN_COLOR.cgColor
        tabBar .barStyle = UIBarStyle.black;
        tabBar .barTintColor = MAIN_COLOR
        tabBar .tintColor = UIColor.orange
        tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orange,NSFontAttributeName:UIFont.systemFont(ofSize: 11)], for: UIControlState.normal)
        tabBarItem .setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.gray,NSFontAttributeName:UIFont.systemFont(ofSize: 11)], for: UIControlState.selected)
    }
    
    // 添加子控制器
    fileprivate func setupChildViewControllers() {
        setupOneChildViewController(vc: CustomNavigationController(rootViewController: HomePageVC()), title: "首页", image: "tab_icon_home_normal", selectedImage:"tab_icon_home_selected")
        setupOneChildViewController(vc: CustomNavigationController(rootViewController: LoanBooksVC()), title: "贷款大全", image: "tab_icon_discover_normal", selectedImage:"tab_icon_discover_selected")
        setupOneChildViewController(vc: CustomNavigationController(rootViewController: UserCenterVC()), title: "个人中心", image: "tab_icon_my_normal", selectedImage:"tab_icon_my_selected")
    }
    
    
    
    fileprivate func setupOneChildViewController(vc : CustomNavigationController, title : String, image : String, selectedImage : String) {
        vc.tabBarItem.title = title;
        if image .lengthOfBytes(using: String.Encoding(rawValue: String.Encoding.utf16.rawValue)) > 0 {
            vc.tabBarItem.image = UIImage (named: image)
            vc.tabBarItem.selectedImage = UIImage (named: selectedImage)
        }
        
        addChildViewController(vc)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
