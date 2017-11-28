//
//  LoginSegmentedView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/10/24.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit
typealias ClickBlock = (Int) -> Void
class LoginSegmentedView: UIView {

    var publicBtn : UIButton = UIButton (type: UIButtonType.custom)
    var codeBtn : UIButton = UIButton (type: UIButtonType.custom)
    var lineView2 : UIView = UIView()
    var clickBlock : ClickBlock?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        // 创建UI
        createSegmentView()
    }

    // 创建UI
    func createSegmentView() -> () {
        // 普通登录
        self .publicBtn .setTitle("普通登录", for: UIControlState.normal)
        self .publicBtn .titleLabel? .font = UIFont .systemFont(ofSize: 15 * WIDTH_SCALE)
        self .publicBtn .setTitleColor(TEXT_BLACK_COLOR, for: UIControlState.normal)
        self .publicBtn .setTitleColor(NAVIGATION_COLOR, for: UIControlState.selected)
        self .publicBtn .tag = 500
        self .publicBtn .isSelected = true
        self .publicBtn .addTarget(self, action: #selector(tapClick(sender:)), for: UIControlEvents.touchUpInside)
        self .addSubview(self .publicBtn)
        self .publicBtn .snp .makeConstraints { (make) in
            make.top.left.equalTo(self)
            make.height.equalTo(45 * HEIGHT_SCALE)
            make.width.equalTo((SCREEN_WIDTH - 0.5) / 2)
        }
        
        
        let lineView1 = UIView()
        lineView1 .backgroundColor = LINE_COLOR2
        self .addSubview(lineView1)
        lineView1 .snp .makeConstraints { (make) in
            make.left.equalTo(self .publicBtn.snp.right)
            make.width.equalTo(0.5)
            make.top.equalTo(self.snp.top).offset(13 * HEIGHT_SCALE)
            make.bottom.equalTo(self.snp.bottom).offset(-13 * HEIGHT_SCALE)
        }
        
        
        // 验证码登录
        self .codeBtn .setTitle("动态验证码登录", for: UIControlState.normal)
        self .codeBtn .titleLabel? .font = UIFont .systemFont(ofSize: 15 * WIDTH_SCALE)
        self .codeBtn .setTitleColor(TEXT_BLACK_COLOR, for: UIControlState.normal)
        self .codeBtn .setTitleColor(NAVIGATION_COLOR, for: UIControlState.selected)
        self .codeBtn .tag = 501
        self .codeBtn .addTarget(self, action: #selector(tapClick(sender:)), for: UIControlEvents.touchUpInside)
        self .addSubview(self .codeBtn)
        self .codeBtn .snp .makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(lineView1.snp.right)
            make.height.equalTo(45 * HEIGHT_SCALE)
            make.width.equalTo((SCREEN_WIDTH - 0.5) / 2)
        }
        

        self .lineView2 .backgroundColor = NAVIGATION_COLOR
        self .addSubview(self .lineView2)
        self .lineView2 .snp .makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(45 * HEIGHT_SCALE)
            make.left.equalTo(self)
            make.height.equalTo(1 * HEIGHT_SCALE)
            make.width.equalTo(SCREEN_WIDTH / 2)
        }
    }
    
    
    // 按钮的点击事件
    func tapClick(sender : UIButton) -> () {
        // 普通登录
        if sender.tag == 500 {
            self.publicBtn.isSelected = true
            self.codeBtn.isSelected = false
            
            
            UIView .animate(withDuration: 0.35, animations: { 
                self.lineView2 .snp .updateConstraints({ (make) in
                    make.left.equalTo(self)
                })
                self .layoutIfNeeded()
            })

        // 验证码登录
        } else {
            self.codeBtn.isSelected = true
            self.publicBtn.isSelected = false
            
            UIView .animate(withDuration: 0.35, animations: {
                self.lineView2 .snp .updateConstraints({ (make) in
                    make.left.equalTo(self.snp.left).offset(SCREEN_WIDTH / 2)
                })
                self .layoutIfNeeded()
            })
        }
        
        if clickBlock != nil {
            self.clickBlock!(sender.tag)
        }
    }
}
