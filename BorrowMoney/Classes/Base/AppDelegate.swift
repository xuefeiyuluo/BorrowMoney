//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？


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
            SVProgressHUD.dismiss()
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

