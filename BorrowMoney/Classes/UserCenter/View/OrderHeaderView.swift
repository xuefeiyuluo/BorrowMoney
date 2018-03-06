//
//  OrderHeaderView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/5.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias OrderClickBlock = (Int) -> Void
class OrderHeaderView: BasicView {
    var titleArray : [String] = [String]()// 头部数组
    var uiArray : [UIButton] = [UIButton]()// 控件数组
    var lineView : UIView = UIView()// 横线
    var orderClickBlock : OrderClickBlock?;// 点击回调
    let btnWidth : CGFloat = SCREEN_WIDTH / 3// 宽度
    
    override func createUI() {
        super.createUI()

        
        for i in 0 ..< self.titleArray.count {
            let btn : UIButton = UIButton (type: UIButtonType.custom)
            if i == 0 {
                btn.isSelected = true
            } else {
                btn.isSelected = false
            }
            btn.tag = i
            btn.setTitle(self.titleArray[i], for: UIControlState.normal)
            btn.setTitleColor(TEXT_SECOND_COLOR, for: UIControlState.normal)
            btn.setTitleColor(NAVIGATION_COLOR, for: UIControlState.selected)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
            btn.addTarget(self, action: #selector(tapClick(sender:)), for: UIControlEvents.touchUpInside)
            btn.frame = CGRect (x: CGFloat(i) * btnWidth, y: 0, width: self.btnWidth, height: 39 * HEIGHT_SCALE)
            self.uiArray.append(btn)
            self.addSubview(btn)
        }
        
        // 横线
        self.lineView.frame = CGRect (x: 0, y:39 * HEIGHT_SCALE, width: self.btnWidth, height: 1 * HEIGHT_SCALE)
        self.lineView.backgroundColor = NAVIGATION_COLOR
        self.addSubview(self.lineView)
        
    }

    
    // 按钮的点击事件
    func tapClick(sender : UIButton) -> Void {
        for i in 0 ..< self.uiArray.count {
            let btn : UIButton = self.uiArray[i] as UIButton;
            if btn.tag == sender.tag {
                btn.isSelected = true
            } else {
                btn.isSelected = false
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            self.lineView.frame = CGRect (x: CGFloat(sender.tag) * self.btnWidth, y: 39 * HEIGHT_SCALE, width: self.btnWidth, height: 1 * HEIGHT_SCALE)
        }
        
        if self.orderClickBlock != nil {
            self.orderClickBlock!(sender.tag)
        }
    }
    
    
    
    
    override func initializationData() {
        self.titleArray = ["未放款","待还款","全部"]
    }
    
    
}
