//
//  EvaluateSubmitView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/22.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class EvaluateSubmitView: BasicView {
    var evaluateBtn : UIButton = UIButton()// 提交评价按钮
    
    
    // 创建UI
    override func createUI() {
        super.createUI()
        
        // 提交评价按钮
        self.evaluateBtn.setTitle("提交评价", for: UIControlState.normal)
        self.evaluateBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.evaluateBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17 * WIDTH_SCALE)
        self.evaluateBtn.layer.cornerRadius = 5 * WIDTH_SCALE
        self.evaluateBtn.backgroundColor = LINE_COLOR3
        self.evaluateBtn.isEnabled = false
        self.evaluateBtn.layer.masksToBounds = true
        self.addSubview(self.evaluateBtn)
        self.evaluateBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(20 * WIDTH_SCALE)
            make.right.equalTo(self.snp.right).offset(-15 * WIDTH_SCALE)
            make.height.equalTo(45 * HEIGHT_SCALE)
            make.top.equalTo(15 * HEIGHT_SCALE)
        }
        
        let label : UILabel = UILabel()
        label.text = "所有评论均匿名展示，保护您的安全隐私"
        label.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        label.textColor = UIColor().colorWithHexString(hex: "666666")
        label.textAlignment = NSTextAlignment.center
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.evaluateBtn.snp.bottom).offset(10 * HEIGHT_SCALE)
        }
    }
    
    
    // 更新按钮的状态
    func updateEvaluateBtnState(evaluateState : Bool) -> Void {
        if evaluateState {
            self.evaluateBtn.backgroundColor = NAVIGATION_COLOR
            self.evaluateBtn.isEnabled = true
        } else {
            self.evaluateBtn.backgroundColor = LINE_COLOR3
            self.evaluateBtn.isEnabled = false
        }
    }
}
