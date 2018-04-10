//
//  CallPhoneView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/9.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias CallBtnBlock = () -> Void
class CallPhoneView: BasicView {
    var callImageView : UIImageView = UIImageView()
    var promptLabel : UILabel = UILabel()// 提示信息
    var cancelBtn : UIButton = UIButton()// 取消按钮
    var callBtnBlock : CallBtnBlock?// 取消按钮的回调
    var callAlertView : UIView = UIView()// 弹框View
    var textLabel : UILabel = UILabel()// 弹框文案
    var leftBtn : UIButton = UIButton()// 左边按钮
    var rightBtn : UIButton = UIButton()// 右边按钮
    var dataDict : NSDictionary = NSDictionary()// 电话结果的数据
    

    // 创建UI
    override func createUI() {
        super.createUI()
        self.backgroundColor = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
        
        
        self.callImageView.contentMode = .center
        self.callImageView.image = UIImage (named: "phoneCall")
        self.addSubview(self.callImageView)
        self.callImageView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.snp.top).offset(180 * HEIGHT_SCALE)
            make.height.equalTo(170 * HEIGHT_SCALE)
        }
        
        // 提示信息
        self.promptLabel.text = "正在通话中..."
        self.promptLabel.textAlignment = .center
        self.promptLabel.textColor = UIColor.white
        self.promptLabel.font = UIFont .boldSystemFont(ofSize: 17 * WIDTH_SCALE)
        self.addSubview(self.promptLabel)
        self.promptLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.callImageView.snp.bottom).offset(20 * HEIGHT_SCALE)
        }
        
        // 取消按钮
        self.cancelBtn.setBackgroundImage(UIImage (named: "phoneClose"), for: UIControlState.normal)
        self.cancelBtn.addTarget(self, action: #selector(cancelClick), for: UIControlEvents.touchUpInside)
        self.addSubview(self.cancelBtn)
        self.cancelBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).offset(-40 * HEIGHT_SCALE)
            make.width.equalTo(48 * WIDTH_SCALE)
            make.height.equalTo(48 * WIDTH_SCALE)
        }
        
        // 创建弹框View
        createAlertView()
    }
    
    
    // 创建弹框View
    func createAlertView() -> Void {
        self.callAlertView.backgroundColor = UIColor.white
        self.callAlertView.isHidden = true
        self.callAlertView.layer.cornerRadius = 4 * WIDTH_SCALE
        self.callAlertView.layer.masksToBounds = true
        self.addSubview(self.callAlertView)
        self.callAlertView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(25 * WIDTH_SCALE)
            make.right.equalTo(self.snp.right).offset(-25 * WIDTH_SCALE)
            make.height.equalTo(170 * HEIGHT_SCALE)
        }
        
        
        self.textLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.textLabel.textColor = LINE_COLOR3
        self.textLabel.numberOfLines = 0
        self.callAlertView.addSubview(self.textLabel)
        self.textLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.callAlertView.snp.left).offset(20 * WIDTH_SCALE)
            make.right.equalTo(self.callAlertView.snp.right).offset(-20 * WIDTH_SCALE)
            make.top.equalTo(self.callAlertView.snp.top).offset(25 * HEIGHT_SCALE)
        }
        
        
        let lineView : UIView = UIView()
        lineView.backgroundColor = LINE_COLOR1
        self.callAlertView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self.callAlertView.snp.left).offset(20 * WIDTH_SCALE)
            make.right.equalTo(self.callAlertView.snp.right).offset(-20 * WIDTH_SCALE)
            make.bottom.equalTo(self.callAlertView.snp.bottom).offset(-85 * HEIGHT_SCALE)
            make.height.equalTo(0.5 * HEIGHT_SCALE)
        }
        
        self.leftBtn.setTitleColor(NAVIGATION_COLOR, for: UIControlState.normal)
        self.leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17 * WIDTH_SCALE)
        self.leftBtn.layer.borderColor = NAVIGATION_COLOR.cgColor
        self.leftBtn.layer.cornerRadius = 2 * WIDTH_SCALE
        self.leftBtn.layer.masksToBounds = true
        self.leftBtn.tag = 500
        self.leftBtn.addTarget(self, action: #selector(btnClick(sender:)), for: UIControlEvents.touchUpInside)
        self.leftBtn.layer.borderWidth = 1 * WIDTH_SCALE
        self.callAlertView.addSubview(self.leftBtn)
        self.leftBtn.snp.makeConstraints { (make) in
            make.height.equalTo(45 * HEIGHT_SCALE)
            make.left.equalTo(self.callAlertView.snp.left).offset(20 * WIDTH_SCALE)
            make.bottom.equalTo(self.callAlertView.snp.bottom).offset(-20 * HEIGHT_SCALE)
            make.width.equalTo(135 * WIDTH_SCALE)
        }
        
        
        self.rightBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.rightBtn.backgroundColor = NAVIGATION_COLOR
        self.rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17 * WIDTH_SCALE)
        self.rightBtn.tag = 600
        self.rightBtn.addTarget(self, action: #selector(btnClick(sender:)), for: UIControlEvents.touchUpInside)
        self.rightBtn.layer.cornerRadius = 2 * WIDTH_SCALE
        self.rightBtn.layer.masksToBounds = true
        self.callAlertView.addSubview(self.rightBtn)
        self.rightBtn.snp.makeConstraints { (make) in
            make.height.equalTo(45 * HEIGHT_SCALE)
            make.right.equalTo(self.callAlertView.snp.right).offset(-20 * WIDTH_SCALE)
            make.bottom.equalTo(self.callAlertView.snp.bottom).offset(-20 * HEIGHT_SCALE)
            make.width.equalTo(135 * WIDTH_SCALE)
        }
    }
    
    
    // 界面数据填充
    func updateCallPhoneView(dict : NSDictionary) -> Void {
        self.dataDict = dict
        self.callAlertView.isHidden = false
        
        self.textLabel.text = dict.stringForKey(key: "btnContent")
        self.leftBtn.setTitle(dict.stringForKey(key: "btnLeft"), for: UIControlState.normal)
        self.rightBtn.setTitle(dict.stringForKey(key: "btnRight"), for: UIControlState.normal)
    }
    
    
    // 按钮的点击事件
    func btnClick(sender: UIButton) -> Void {
        // 500表示左边按钮  600表示右边按钮
        if sender.tag == 500 {
            removeCallView()
        } else {
            if self.dataDict.stringForKey(key: "stateSign") == "noProvider" || self.dataDict.stringForKey(key: "stateSign") == "callFail" {
                removeCallView()
            } else  {
                if self.callBtnBlock != nil {
                    self.callBtnBlock!()
                }
            }
        }
    }
    
    
    // 取消电话拨打
    func cancelClick() -> Void {
        removeCallView()
    }
    
    
    // 移除拨打电话View
    func removeCallView() -> Void {
        self.removeFromSuperview()
    }
}
