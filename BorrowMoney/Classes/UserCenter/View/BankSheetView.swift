//
//  BankSheetView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/2/28.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias BankSheetBlock = (Int) -> Void
class BankSheetView: BasicView {

    var bankSheetBlock : BankSheetBlock?
    
    // 创建UI
    override func createUI() {
        super.createUI()
        
        // 取消
        let cancelBtn : UIButton = UIButton (type: UIButtonType.custom)
        cancelBtn.setTitle("取消", for: UIControlState.normal)
        cancelBtn.setTitleColor(UIColor().colorWithHexString(hex: "333333"), for: UIControlState.normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17 * WIDTH_SCALE)
        cancelBtn.setBackgroundImage(UIImage (named: "btnOn.png"), for: UIControlState.normal)
        cancelBtn.setBackgroundImage(UIImage (named: "btnOff.png"), for: UIControlState.highlighted)
        cancelBtn.addTarget(self, action: #selector(tapClick(sender:)), for: UIControlEvents.touchUpInside)
        cancelBtn.tag = 500
        self.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.top.left.equalTo(self)
            make.height.equalTo(40 * HEIGHT_SCALE)
            make.width.equalTo((SCREEN_WIDTH - 1) / 2)
        }
        
        let lineView : UIView = UIView()
        lineView.backgroundColor = UIColor.lightGray
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(cancelBtn.snp.left)
            make.height.equalTo(cancelBtn.snp.height)
            make.width.equalTo(1)
        }
        
        // 确定
        let determineBtn : UIButton = UIButton (type: UIButtonType.custom)
        determineBtn.setTitle("确定", for: UIControlState.normal)
        determineBtn.setTitleColor(UIColor().colorWithHexString(hex: "333333"), for: UIControlState.normal)
        determineBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17 * WIDTH_SCALE)
        determineBtn.setBackgroundImage(UIImage (named: "btnOn.png"), for: UIControlState.normal)
        determineBtn.setBackgroundImage(UIImage (named: "btnOff.png"), for: UIControlState.highlighted)
        determineBtn.addTarget(self, action: #selector(tapClick(sender:)), for: UIControlEvents.touchUpInside)
        determineBtn.tag = 501
        self.addSubview(determineBtn)
        determineBtn.snp.makeConstraints { (make) in
            make.top.right.equalTo(self)
            make.height.equalTo(40 * HEIGHT_SCALE)
            make.width.equalTo((SCREEN_WIDTH - 1) / 2)
        }
    }
    
    
    // 按钮的点击事件
    func tapClick(sender : UIButton) -> Void {
        if self.bankSheetBlock != nil {
            self.bankSheetBlock!(sender.tag)
        }
    }
}
