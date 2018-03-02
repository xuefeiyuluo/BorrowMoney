//
//  LoginInfoView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/2.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

typealias JumpBlock = (Int) -> Void
typealias LoginBlock = (Int) -> Void
class LoginInfoView: BasicView {

    var userImage : UIImageView = UIImageView()
    var pswField : UITextField = UITextField()
    var pswView : UIView = UIView()
    var codeBtn : UIButton = UIButton()
    var forgetBtn : UIButton = UIButton()
    var loginView : UIView = UIView()
    var phoneField : UITextField = UITextField()
    var graphicCode : String = ""
    var countdownTimer: Timer?
    var second : Int = 60
    var loginBlock : LoginBlock?
    var jumpBlock : JumpBlock?

    
    override func initializationData() {
        super.initializationData()
        NotificationCenter.default.addObserver(self, selector: #selector(loginTextFieldChange(notification:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    
    // 创建登录view
    override func createUI() -> () {
        
        // 手机号view
        createUserView()
        
        // 密码view
        ceatePassword()
        
        // 登录按钮view
        createLoginBtnView()
    }
    
    
    func createUserView() -> () {
        let userView = UIView()
        self .addSubview(userView)
        userView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(45 * HEIGHT_SCALE)
        }
        
        let lineView1 = UIView()
        lineView1.backgroundColor = LINE_COLOR1
        userView .addSubview(lineView1)
        lineView1 .snp .makeConstraints { (make) in
            make.top.right.equalTo(userView)
            make.left.equalTo(userView.snp.left).offset(15 * WIDTH_SCALE)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        self.userImage = UIImageView (image: UIImage (named: "user_icon"))
        self.userImage .contentMode = UIViewContentMode.center
        userView .addSubview(self.userImage)
        self.userImage .snp .makeConstraints { (make) in
            make.left.equalTo(userView.snp.left).offset(15 * WIDTH_SCALE)
            make.top.bottom.equalTo(userView)
            make.width.equalTo(25 * WIDTH_SCALE)
        }
        
        let lineView2 = UIView()
        lineView2.backgroundColor = LINE_COLOR2
        userView .addSubview(lineView2)
        lineView2 .snp .makeConstraints { (make) in
            make.top.equalTo(userView.snp.top).offset(13 * HEIGHT_SCALE)
            make.left.equalTo(self.userImage.snp.right).offset(3 * WIDTH_SCALE)
            make.width.equalTo(1 * HEIGHT_SCALE)
            make.bottom.equalTo(userView.snp.bottom).offset(-10 * HEIGHT_SCALE)
        }
        
        self.phoneField = UITextField()
        self.phoneField.placeholder = "请输入手机号码"
        self.phoneField.font = UIFont .systemFont(ofSize: 14 * WIDTH_SCALE)
        self.phoneField.keyboardType = UIKeyboardType.numberPad
        self.phoneField.clearButtonMode = UITextFieldViewMode.always
        userView .addSubview(self.phoneField)
        self.phoneField.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(userView)
            make.left.equalTo(lineView2.snp.right).offset(10 * WIDTH_SCALE)
        }
        
        let lineView3 = UIView()
        lineView3.backgroundColor = LINE_COLOR1
        userView .addSubview(lineView3)
        lineView3 .snp .makeConstraints { (make) in
            make.bottom.right.equalTo(userView)
            make.left.equalTo(userView.snp.left).offset(15 * WIDTH_SCALE)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
    }
    
    
    func ceatePassword() -> () {
        self .addSubview(self.pswView)
        self.pswView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.snp.top).offset(45 * HEIGHT_SCALE)
            make.height.equalTo(45 * HEIGHT_SCALE)
        }
        
        
        let pswImage = UIImageView (image: UIImage (named: "pass_icon"))
        pswImage .contentMode = UIViewContentMode.center
        self.pswView .addSubview(pswImage)
        pswImage .snp .makeConstraints { (make) in
            make.left.equalTo(self.pswView.snp.left).offset(15 * WIDTH_SCALE)
            make.top.bottom.equalTo(self.pswView)
            make.width.equalTo(25 * WIDTH_SCALE)
        }
        
        let lineView2 = UIView()
        lineView2.backgroundColor = LINE_COLOR2
        self.pswView .addSubview(lineView2)
        lineView2 .snp .makeConstraints { (make) in
            make.top.equalTo(self.pswView.snp.top).offset(13 * HEIGHT_SCALE)
            make.left.equalTo(pswImage.snp.right).offset(3 * WIDTH_SCALE)
            make.width.equalTo(1 * HEIGHT_SCALE)
            make.bottom.equalTo(self.pswView.snp.bottom).offset(-10 * HEIGHT_SCALE)
        }

        self.pswField.placeholder = "请输入登录密码"
        self.pswField.font = UIFont .systemFont(ofSize: 14 * WIDTH_SCALE)
        self.pswField.keyboardType = UIKeyboardType.asciiCapable
        self.pswField.clearButtonMode = UITextFieldViewMode.always
        self.pswField.isSecureTextEntry = true
        self.pswView .addSubview(self.pswField)
        self.pswField.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self.pswView)
            make.left.equalTo(lineView2.snp.right).offset(10 * WIDTH_SCALE)
        }
    
        self.codeBtn = UIButton (type: UIButtonType.custom)
        self.codeBtn .setTitle("获取验证码", for: UIControlState.normal)
        self.codeBtn.backgroundColor = NAVIGATION_COLOR
        self.codeBtn.isHidden = true
        self.codeBtn .setTitleColor(UIColor.white, for: UIControlState.normal)
        self.codeBtn.titleLabel?.font = UIFont .systemFont(ofSize: 14 * WIDTH_SCALE)
        self.codeBtn.layer.cornerRadius = 2
        self.codeBtn.layer.masksToBounds = true
        self.codeBtn .addTarget(self, action: #selector(codeClick), for: UIControlEvents.touchUpInside)
        self.pswView .addSubview(self.codeBtn)
        self.codeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.pswView.snp.top).offset(5 * HEIGHT_SCALE)
            make.bottom.equalTo(self.pswView.snp.bottom).offset(-5 * HEIGHT_SCALE)
            make.right.equalTo(self.pswView.snp.right).offset(-10 * WIDTH_SCALE)
            make.width.equalTo(110 * WIDTH_SCALE)
        }

        let lineView3 = UIView()
        lineView3.backgroundColor = LINE_COLOR1
        self.pswView .addSubview(lineView3)
        lineView3 .snp .makeConstraints { (make) in
            make.bottom.right.equalTo(self.pswView)
            make.left.equalTo(self.pswView.snp.left).offset(15 * WIDTH_SCALE)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
    }
    
    
    func createLoginBtnView() -> () {
        self.loginView.backgroundColor = MAIN_COLOR
        self .addSubview(self.loginView)
        self.loginView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.pswView.snp.bottom)
            make.height.equalTo(100 * HEIGHT_SCALE)
        }
        
        let loginBtn = UIButton (type: UIButtonType.custom)
        loginBtn.backgroundColor = NAVIGATION_COLOR
        loginBtn .setTitle("登录", for: UIControlState.normal)
        loginBtn.titleLabel?.font = UIFont .systemFont(ofSize: 17 * HEIGHT_SCALE)
        loginBtn.layer.cornerRadius = 2 * HEIGHT_SCALE
        loginBtn.layer.masksToBounds = true
        loginBtn .addTarget(self, action: #selector(loginClick), for: UIControlEvents.touchUpInside)
        self.loginView .addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.pswView.snp.bottom).offset(20 * HEIGHT_SCALE)
            make.left.equalTo(self.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.snp.right).offset(-10 * WIDTH_SCALE)
            make.height.equalTo(44 * HEIGHT_SCALE)
        }
        
        self.forgetBtn = UIButton (type: UIButtonType.custom)
        self.forgetBtn .setTitle("忘记登录密码？", for: UIControlState.normal)
        self.forgetBtn .setTitleColor(TEXT_LIGHT_COLOR, for: UIControlState.normal)
        self.forgetBtn.titleLabel?.font = UIFont .systemFont(ofSize: 13 * HEIGHT_SCALE)
        self.forgetBtn .addTarget(self, action: #selector(forgetClick), for: UIControlEvents.touchUpInside)
        self.loginView .addSubview(self.forgetBtn)
        self.forgetBtn.snp.makeConstraints { (make) in
            make.top.equalTo(loginBtn.snp.bottom).offset(15 * HEIGHT_SCALE)
            make.left.equalTo(self.snp.left).offset(10 * WIDTH_SCALE)
            make.height.equalTo(20 * HEIGHT_SCALE)
        }
        
        let registerBtn = UIButton (type: UIButtonType.custom)
        registerBtn .setTitle("注册 >", for: UIControlState.normal)
        registerBtn .setTitleColor(NAVIGATION_COLOR, for: UIControlState.normal)
        registerBtn.titleLabel?.font = UIFont .systemFont(ofSize: 13 * HEIGHT_SCALE)
        registerBtn .addTarget(self, action: #selector(registerClick), for: UIControlEvents.touchUpInside)
        self.loginView .addSubview(registerBtn)
        registerBtn.snp.makeConstraints { (make) in
            make.top.equalTo(loginBtn.snp.bottom).offset(15 * HEIGHT_SCALE)
            make.right.equalTo(self.snp.right).offset(-10 * WIDTH_SCALE)
            make.height.equalTo(20 * HEIGHT_SCALE)
        }
    }
    
    
    // text改变时调用
    func loginTextFieldChange(notification:Notification) -> Void {
        let textField:UITextField! = notification.object as! UITextField
        if textField == self.phoneField {
            if (textField.text?.count)! > 11 {
                self.phoneField.text = textField.text?.substringInRange(0...10)
            }
        } else if textField == self.pswField {
            if (textField.text?.count)! > 20 {
                self.pswField.text = textField.text?.substringInRange(0...19)
            }
        }
    }
    
    
    // 获取验证码的点击事件
    func codeClick() -> () {
        if (self.phoneField.text?.count)! < 11  {
            SVProgressHUD.showError(withStatus: "请输入正确的手机号码")
            return
        }
        self .endEditing(true)
        
        PublicService.publicServiceInstance.requestVerificationCode(mobile: self.phoneField.text!, code: self.graphicCode, success: { (responseObject) in
            let resultDict = responseObject as! NSDictionary
            if resultDict["code"] as! String == "0" {
                SVProgressHUD .showSuccess(withStatus: "验证码已发送")
                self.countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
                self.codeBtn.isEnabled = false
                self.second = 60;
            } else if resultDict["code"] as! String == "-69" {
                let dataDict : NSDictionary = resultDict["data"] as! NSDictionary
                let graphicView : GraphicView = GraphicView()
                graphicView.showInRect(rect: CGRect (x: 15 * WIDTH_SCALE, y: (SCREEN_HEIGHT - 180 * HEIGHT_SCALE) / 2, width: SCREEN_WIDTH - 30 * WIDTH_SCALE, height: 180 * HEIGHT_SCALE))
                graphicView.imageCode = dataDict["captchaCode"] as? String;
                
                graphicView.submitClickBlock = { (code : String) in
                    self.graphicCode = code
                    self.codeClick()
                }
            }
        }) { (error) in
        }
    }
    
    // 定时器
    func updateTime() -> Void {
        self.second -= 1;
        if self.second > 0 {
            self.codeBtn .setTitle(String (format: "%i'后重新获取", second), for: UIControlState.normal)
        } else {
            countdownTimer?.invalidate()
            countdownTimer = nil
            self.codeBtn .setTitle("重发验证码", for: UIControlState.normal)
            self.codeBtn.isEnabled = true
        }
    }
    
    
    // 登录点击事件
    func loginClick() -> () {
        // 输入信息验证
        if self .dataValidation() {
            if self.loginBlock != nil {
                // 300为验证码登录  400密码登录
                if self.pswField.placeholder == "请输入验证码" {
                    self.loginBlock!(300)
                } else {
                    self.loginBlock!(400)
                }
                
            }
        }
    }
    
    
    // 输入信息验证
    func dataValidation() -> Bool {
        if (self.phoneField.text?.count)! < 11  {
            SVProgressHUD.showError(withStatus: "请输入正确的手机号码")
            return false
        }
        
        if self.pswField.placeholder == "请输入验证码"  {
            if (self.pswField.text?.count)! < 6  {
                SVProgressHUD.showError(withStatus: "请输入正确的验证码")
                return false
            }
        } else {
            if (self.pswField.text?.count)! < 6 || (self.pswField.text?.count)! > 20 {
                SVProgressHUD.showError(withStatus: "请输入正确的登录密码")
                return false
            }
        }
        return true
    }
    
    
    // 忘记密码点击事件
    func forgetClick() -> () {
        if self.jumpBlock != nil {
            jumpBlock!(100)
        }
    }
    
    
    func registerClick() -> () {
        if self.jumpBlock != nil {
            jumpBlock!(200)
        }
    }
}
