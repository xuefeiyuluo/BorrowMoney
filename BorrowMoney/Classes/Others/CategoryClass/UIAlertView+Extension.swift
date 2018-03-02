//
//  UIAlertView+Extension.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/1.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import Foundation

typealias AlertBlock = (_ btnIndex : Int,_ btnTitle : String)->()
extension UIAlertView : UIAlertViewDelegate {
    private static var blockKey = "AlertViewBlock"
    
    // 给alertView添加了一个Block的属性
    func showWithAlertBlock(alertBlock : AlertBlock) -> Void {
        
        objc_removeAssociatedObjects(self)
        objc_setAssociatedObject(self, &UIAlertView.blockKey, alertBlock, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        self.delegate = self
    
        // 获取当前的控制器vc
        let vc  = self.getCurrentVC()
        if vc.isKind(of: LoginVC.self) != true {
            self.show()
        }
    }
    
    
    public func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        let block : AlertBlock = objc_getAssociatedObject(self, &UIAlertView.blockKey) as! AlertBlock
        block(buttonIndex,alertView.buttonTitle(at: buttonIndex)!)
    }
}

