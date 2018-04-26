//
//  LoanDetailBottomView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/11.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias loanDetailSubmitBlock = () -> Void
class LoanDetailBottomView: BasicView {
    var loansubmitBlock : loanDetailSubmitBlock?// 提交申请的回调
    var submitBtn : UIButton = UIButton (type: UIButtonType.custom)

    // 创建UI
    override func createUI() {
        super.createUI()
        
        self.submitBtn.setTitle("提交申请", for: UIControlState.normal)
        self.submitBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18 * WIDTH_SCALE)
        self.submitBtn.backgroundColor = NAVIGATION_COLOR
        self.submitBtn.addTarget(self, action: #selector(submitClick), for: UIControlEvents.touchUpInside)
        self.addSubview(self.submitBtn)
        self.submitBtn.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self)
        }
    }
    
    
    // 更改按钮的样式
    func updateSubmitBtn(selected : Bool) -> Void {
        if selected {
            self.submitBtn.backgroundColor = NAVIGATION_COLOR
        } else {
            self.submitBtn.backgroundColor = TEXT_LIGHT_COLOR
        }
    }
    
    
    // 提交申请的点击事件
    func submitClick() -> Void {
        if self.loansubmitBlock != nil {
            self.loansubmitBlock!()
        }
    }
}
