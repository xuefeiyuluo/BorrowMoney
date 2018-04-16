//
//  LoanDetailSegmentedCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/13.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias LoanDetailSegmentBlock = (Int) -> Void
class LoanDetailSegmentedCell: BasicViewCell {
    var titleArray : [String] = [String]()// 标题
    var lineView : UIView = UIView()// 移动的横线
    var leftBtn : UIButton = UIButton()// 申请资料
    var rightBtn : UIButton = UIButton()// 用户评价
    var loanDetailSegmentBlock : LoanDetailSegmentBlock?// 点击的BLOCK
    

    // 创建UI
    override func createUI() {
        self.backgroundColor = UIColor.white

        let lineView1 : UIView = UIView()
        lineView1.backgroundColor = LINE_COLOR2
        self.addSubview(lineView1)
        lineView1.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        self.leftBtn.setTitle("申请资料", for: UIControlState.normal)
        self.leftBtn.setTitleColor(TEXT_SECOND_COLOR, for: UIControlState.normal)
        self.leftBtn.setTitleColor(NAVIGATION_COLOR, for: UIControlState.selected)
        self.leftBtn.tag = 500
        self.leftBtn.isSelected = true
        self.leftBtn.addTarget(self, action: #selector(tapClick(sender:)), for: UIControlEvents.touchUpInside)
        self.leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        self.addSubview(self.leftBtn)
        self.leftBtn.snp.makeConstraints { (make) in
            make.top.bottom.left.equalTo(self)
            make.width.equalTo(SCREEN_WIDTH / 2)
        }
        
        let verticalView : UIView = UIView()
        verticalView.backgroundColor = LINE_COLOR2
        self.addSubview(verticalView)
        verticalView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(13 * HEIGHT_SCALE)
            make.bottom.equalTo(self.snp.bottom).offset(-13 * HEIGHT_SCALE)
            make.width.equalTo(1 * WIDTH_SCALE)
            make.left.equalTo(SCREEN_WIDTH / 2 - 1 * WIDTH_SCALE)
        }
        
        self.rightBtn.setTitle("用户评价", for: UIControlState.normal)
        self.rightBtn.setTitleColor(TEXT_SECOND_COLOR, for: UIControlState.normal)
        self.rightBtn.setTitleColor(NAVIGATION_COLOR, for: UIControlState.selected)
        self.rightBtn.tag = 600
        self.rightBtn.addTarget(self, action: #selector(tapClick(sender:)), for: UIControlEvents.touchUpInside)
        self.rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        self.addSubview(self.rightBtn)
        self.rightBtn.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(self.leftBtn.snp.right)
            make.width.equalTo(SCREEN_WIDTH / 2)
        }
        
        
        let lineView2 : UIView = UIView()
        lineView2.backgroundColor = LINE_COLOR2
        self.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.right.left.bottom.equalTo(self)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        // 选择滚动的线条
        self.lineView.frame = CGRect (x: 0, y: 49 * HEIGHT_SCALE, width: SCREEN_WIDTH / 2, height: 1 * HEIGHT_SCALE)
        lineView.backgroundColor = NAVIGATION_COLOR
        self.addSubview(self.lineView)
    }
    
    
    
    // 按钮的点击事件
    func tapClick(sender: UIButton) -> Void {
        
        var lineViewX : CGFloat = 0.0
        // 500申请资料  600用户评价
        if sender.tag == 500 {
            self.leftBtn.isSelected = true
            self.rightBtn.isSelected = false
            lineViewX = 0
        } else {
            self.leftBtn.isSelected = false
            self.rightBtn.isSelected = true
            lineViewX = SCREEN_WIDTH / 2
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.lineView.frame = CGRect (x: lineViewX, y: 49 * HEIGHT_SCALE, width: SCREEN_WIDTH / 2, height: 1)
        })
        
        if self.loanDetailSegmentBlock != nil {
            self.loanDetailSegmentBlock!(sender.tag)
        }
    }
}
