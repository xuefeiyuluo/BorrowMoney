//
//  CalculatorHeaderView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/22.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias CalculatorBlock = (Int) -> Void
class CalculatorHeaderView: BasicView {
    var titleArray : [String] = [String]()// 头部数据
    var uiArray : [UIButton] = [UIButton]()// 控件
    var lineView : UIView = UIView()// 移动的横线
    var calculatorBlock : CalculatorBlock?// 按钮点击回调
    

    // 创建UI
    override func createUI() {
        self.backgroundColor = UIColor.clear
        let backView : UIView = UIView()
        self.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.right.left.equalTo(self)
            make.height.equalTo(40 * HEIGHT_SCALE)
        }
        
        let viewWidth : CGFloat = SCREEN_WIDTH / 4
        for i in 0 ..< 4 {
            let viewBtn : UIButton = UIButton()
            viewBtn.tag = i
            viewBtn.setTitle(self.titleArray[i], for: UIControlState.normal)
            viewBtn.setTitleColor(UIColor().colorWithHexString(hex: "7F7F7F"), for: UIControlState.normal)
            viewBtn.setTitleColor(NAVIGATION_COLOR, for: UIControlState.selected)
            viewBtn.addTarget(self, action: #selector(tapClick(sender:)), for: UIControlEvents.touchUpInside)
            if i == 0 {
                viewBtn.isSelected = true
            } else {
                viewBtn.isSelected = false
            }
            backView.addSubview(viewBtn)
            viewBtn.snp.makeConstraints({ (make) in
                make.top.bottom.equalTo(backView)
                make.width.equalTo(viewWidth)
                make.left.equalTo(backView.snp.left).offset(CGFloat(i) * viewWidth)
            })
            // 将控件添加到数组
            self.uiArray.append(viewBtn)
        }
        
        self.lineView.frame = CGRect (x: 0, y: 39 * HEIGHT_SCALE, width: viewWidth, height: 1)
        lineView.backgroundColor = NAVIGATION_COLOR
        backView.addSubview(self.lineView)
    }
    
    
    // 按钮的点击事件
    func tapClick(sender: UIButton) -> Void {
        let viewWidth : CGFloat = SCREEN_WIDTH / 4
        for i in 0 ..< self.uiArray.count {
            let btn : UIButton = self.uiArray[i] as UIButton;
            if sender.tag == i {
                btn.isSelected = true
                UIView.animate(withDuration: 0.3, animations: {
                    self.lineView.frame = CGRect (x: CGFloat(i) * viewWidth, y: 39 * HEIGHT_SCALE, width: viewWidth, height: 1)
                })
            } else {
                btn.isSelected = false
            }
        }
        
        if self.calculatorBlock != nil {
            self.calculatorBlock!(sender.tag)
        }
    }
    
    
    // 初始化数据
    override func initializationData() {
        super.initializationData()
        
        self.titleArray = ["贷款","车贷","房贷","公积金贷"]
    }
}
