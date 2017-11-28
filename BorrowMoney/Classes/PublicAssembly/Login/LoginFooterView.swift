//
//  LoginFooterView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/3.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

typealias FooterClickBlock = (Int) -> Void
class LoginFooterView: UIView {

    var bottomBlock : FooterClickBlock?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        // 创建底部View
        createFooterView()
    }
    
    
    func createFooterView() -> () {
        let mutableText = NSMutableAttributedString (string: "点击”登录“代表您已同意《借点钱服务条款》")
        let textColor = UIColor().colorWithHexString(hex: "009CFF")
        mutableText.addAttribute(NSForegroundColorAttributeName, value: UIColor().colorWithHexString(hex: "B3B3B3"),range: NSMakeRange(0, 12))
        mutableText.addAttribute(NSForegroundColorAttributeName, value: textColor,range: NSMakeRange(12, 9))
        let agreementLabel = UIButton (type: UIButtonType.custom)
        agreementLabel.titleLabel?.font = UIFont .systemFont(ofSize: 11 * HEIGHT_SCALE)
        agreementLabel .setAttributedTitle(mutableText, for: UIControlState.normal)
        agreementLabel .addTarget(self, action: #selector(agreementTapClick), for: UIControlEvents.touchUpInside)
        self .addSubview(agreementLabel)
        agreementLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(40 * HEIGHT_SCALE)
        }
        
        // 微信
        let weixin = UIButton (type: UIButtonType.custom)
        weixin .setBackgroundImage(UIImage (named: "weixin_icon"), for: UIControlState.normal)
        weixin .addTarget(self, action: #selector(weixinClick), for: UIControlEvents.touchUpInside)
        self .addSubview(weixin)
        weixin .snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.centerX).offset(-25 * WIDTH_SCALE)
            make.height.width.equalTo(50 * HEIGHT_SCALE)
            make.bottom.equalTo(agreementLabel.snp.top).offset(-10 * HEIGHT_SCALE)
        }
        
        // QQ
        let QQ = UIButton (type: UIButtonType.custom)
        QQ .setBackgroundImage(UIImage (named: "kongjian_icon"), for: UIControlState.normal)
        QQ .addTarget(self, action: #selector(QQClick), for: UIControlEvents.touchUpInside)
        self .addSubview(QQ)
        QQ .snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.centerX).offset(25 * WIDTH_SCALE)
            make.height.width.equalTo(50 * HEIGHT_SCALE)
            make.bottom.equalTo(agreementLabel.snp.top).offset(-10 * HEIGHT_SCALE)
        }
        
        // 推荐登录方式
        let thirdLogin = UILabel()
        thirdLogin.text = "推荐登录方式"
        thirdLogin.font = UIFont .systemFont(ofSize: 12 * HEIGHT_SCALE)
        thirdLogin.textColor = TEXT_LIGHT_COLOR
        thirdLogin.textAlignment = NSTextAlignment.center
        self .addSubview(thirdLogin)
        thirdLogin .snp .makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(weixin .snp .top).offset(-25 * HEIGHT_SCALE)
        }
        
        let leftLine = UIView()
        leftLine.backgroundColor = LINE_COLOR3
        self .addSubview(leftLine)
        leftLine .snp .makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(12 * WIDTH_SCALE)
            make.height.equalTo(1 * HEIGHT_SCALE)
            make.centerY.equalTo(thirdLogin.snp.centerY)
            make.right.equalTo(thirdLogin.snp.left).offset(-12 * WIDTH_SCALE)
        }
        
        let rightLine = UIView()
        rightLine.backgroundColor = LINE_COLOR3
        self .addSubview(rightLine)
        rightLine .snp .makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-12 * WIDTH_SCALE)
            make.height.equalTo(1 * HEIGHT_SCALE)
            make.centerY.equalTo(thirdLogin.snp.centerY)
            make.left.equalTo(thirdLogin.snp.right).offset(12 * WIDTH_SCALE)
        }
    }
    
    
    // 协议的点击事件
    func agreementTapClick() -> () {
        if self.bottomBlock != nil {
            self.bottomBlock!(900)
        }
    }
    
    
    // 微信的点击事件
    func weixinClick() -> () {
        if self.bottomBlock != nil {
            self.bottomBlock!(700)
        }
    }
    
    
    // QQ的点击事件
    func QQClick() -> () {
        if self.bottomBlock != nil {
            self.bottomBlock!(800)
        }
    }
}
