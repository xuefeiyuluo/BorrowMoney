//
//  AppDelegate.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/10/11.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

var rootViewController : CustomNavigationController?// 根控制器默认为隐藏
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {
    
    var window: UIWindow?
    var tabBar : UITabBarController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        self.tabBar = TabBarController()
        self.tabBar?.delegate = self
        rootViewController = CustomNavigationController(rootViewController:tabBar!)
        rootViewController?.navigationBar.isHidden = true
        window?.rootViewController = rootViewController;
        
        // 数据初始化
        self .initializationData()
        
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    

    // MARK: UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let nav : UINavigationController = viewController as? UINavigationController {
            let array : NSArray = nav.viewControllers as NSArray
            let vc : UIViewController = array[0] as! UIViewController
            XPrint(String (format: "点击了%@", vc))
        }
        return true
    }
    
    // tableBar界面的跳转
    func tabBarControllerSelectedIndex(index : Int) -> Void {
        self.tabBar?.selectedIndex = index
    }
    
    
    // 数据初始化
    func initializationData() -> Void {
        // 设置弹框最小显示时间
        SVProgressHUD .setMinimumDismissTimeInterval(1.0)
    }
    
}

