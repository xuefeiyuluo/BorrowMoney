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
    

    // 创建UI
    override func createUI() {
        super.createUI()
        
        let submitBtn : UIButton = UIButton (type: UIButtonType.custom)
        submitBtn.setTitle("提交申请", for: UIControlState.normal)
        submitBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18 * WIDTH_SCALE)
        submitBtn.backgroundColor = NAVIGATION_COLOR
        submitBtn.addTarget(self, action: #selector(submitClick), for: UIControlEvents.touchUpInside)
        self.addSubview(submitBtn)
        submitBtn.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self)
        }
    }
    
    
    // 提交申请的点击事件
    func submitClick() -> Void {
        if self.loansubmitBlock != nil {
            self.loansubmitBlock!()
        }
    }
}
