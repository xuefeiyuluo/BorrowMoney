//
//  CustomNavigationController.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/10/12.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController,UINavigationControllerDelegate {
    
    var popDelegate : UIGestureRecognizerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.delegate = self
    }

    
    // UINavigationControllerDelegate方法 解决自定义导航栏后侧滑返回功能失效问题
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //实现滑动返回功能
        //清空滑动返回手势的代理就能实现
        if viewController == self.viewControllers[0] {
            self.interactivePopGestureRecognizer!.delegate = self.popDelegate
        }
        else {
            self.interactivePopGestureRecognizer!.delegate = nil
        }
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        
        super .pushViewController(viewController, animated: animated)
    }
    
    
    override func popViewController(animated: Bool) -> UIViewController? {
        
        return super .popViewController(animated: animated)
    }
    
    
    override var childViewControllerForStatusBarStyle: UIViewController?{
        get {
            return self.topViewController
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
