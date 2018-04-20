//
//  LoginVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/10/16.
//  Copyright © 2017年 sparrow. All rights reserved.
//

class LoginVC: BasicVC {
    var successHandler:(() -> ())?;
    var cancelHandler:(() -> ())?;
    lazy var segmentedView : LoginSegmentedView = LoginSegmentedView()
    lazy var loginView : LoginInfoView = LoginInfoView()
    lazy var footerView : LoginFooterView = LoginFooterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建头部
        createSegmentedView()
        
        // 创建登录界面
        createLoginView()
        
        // 创建底部界面
        createFooterView()
    }
    
    // 创建头部
    func createSegmentedView() -> () {
        self.segmentedView.backgroundColor = UIColor.white
        self.view .addSubview(self.segmentedView)
        self.segmentedView .snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(46 * HEIGHT_SCALE)
        }
        
        // 登录方式的切换
        self.segmentedView.clickBlock = { (tag) in
            // 普通登录
            self.view.endEditing(true)
            self.loginView.pswField.text = ""
            if tag == 500 { 
                self.loginView.userImage = UIImageView (image: UIImage (named: "user_icon"))
                self.loginView.pswField.placeholder = "请输入登录密码"
                self.loginView.pswField.keyboardType = UIKeyboardType.asciiCapable
                self.loginView.pswField.isSecureTextEntry = true
                self.loginView.codeBtn.isHidden = true
                self.loginView.forgetBtn.isHidden = false
            } else {
                self.loginView.userImage = UIImageView (image: UIImage (named: "write_phone"))
                self.loginView.pswField.placeholder = "请输入验证码"
                self.loginView.pswField.keyboardType = UIKeyboardType.numberPad
                self.loginView.pswField.isSecureTextEntry = false
                self.loginView.codeBtn.isHidden = false
                self.loginView.forgetBtn.isHidden = true
            }
        }
    }
    
    // 创建登录界面
    func createLoginView() -> () {
        
        self.loginView.backgroundColor = UIColor.white
        self.view .addSubview(self.loginView)
        self.loginView .snp .makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.segmentedView.snp.bottom)
            make.height.equalTo(190 * HEIGHT_SCALE)
        }
        
        self.loginView.jumpBlock = {(sign) in
            // 100忘记密码  200注册
            if sign == 100 {
                self.navigationController?.pushViewController(ForgetVC(), animated: true)
            } else {
                self.navigationController?.pushViewController(RegisterVC(), animated: true)
            }
        }
        
        self.loginView.loginBlock = { (sign) in
            SVProgressHUD .show()
            // 300为验证码登录  400密码登录
            if sign == 400 {
                PublicService.publicServiceInstance.login(userName: self.loginView.phoneField.text!, password: self.loginView.pswField.text!, success: { (responseObject) in
                    // 登录成功后的数据处理
                    self.loginSuccessDataHandle(dict: responseObject as! NSDictionary)
                }, failure: { (errorInfo) in
                    
                })
            } else {
                PublicService.publicServiceInstance.loginWithVerifyCode(userName: self.loginView.phoneField.text!, code: self.loginView.pswField.text!, success: { (responseObject) in
                    // 登录成功后的数据处理
                    self.loginSuccessDataHandle(dict: responseObject as! NSDictionary)
                }, failure: { (errorInfo) in
                    
                })
            }
        }
    }
    
    // 创建底部界面
    func createFooterView() -> () {
        self.view .addSubview(self.footerView)
        self.footerView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self.view)
            make.height.equalTo(150 * HEIGHT_SCALE)
        }
    }
    
    
    // 登录成功后的数据处理
    func loginSuccessDataHandle(dict : NSDictionary) -> Void {
        let userInfo : UserModel = UserModel()
        userInfo.sessionId = dict["sessionId"] as? String
        userInfo.webCookies = dict["webCookies"] as? NSArray
        userInfo.hasPassword = dict["hasPassword"] as? Bool
        USERDEFAULT.saveCustomObject(customObject: userInfo as NSCoding, key: "userInfo")
        
        // 获取用户基本信息
        requestBaseInfo()
        
        // 返回原来的界面
        self.loginSuccess()
    }
    
    
    // 登录成功
    func loginSuccess() -> Void {
        if self.successHandler != nil {
            self.successHandler!()
        }
    }
    
    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "登录");
    }
    
    
    override func comeBack() -> () {
        if self.cancelHandler != nil {
            self.cancelHandler!()
        }
    }
    
    
    // 获取用户基本信息
    func requestBaseInfo() -> Void {
        UserCenterService.userInstance.baseInfo(success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            let userInfo : UserModel = USERINFO!
            userInfo.hasPassword = dataDict["hasPassword"] == nil ? false : dataDict["hasPassword"] as? Bool
            userInfo.mobile = dataDict["mobile"] == nil ? "" : dataDict["mobile"] as? String
            userInfo.isNewUser = dataDict["isNewUser"] == nil ? "" : dataDict["isNewUser"] as? String
            userInfo.name = dataDict["name"] == nil ? "" : dataDict["name"] as? String
            userInfo.idCard = dataDict["idCard"] == nil ? "" : dataDict["idCard"] as? String
            userInfo.roleType = dataDict["roleType"] == nil ? "" : dataDict["roleType"] as? String
            if dataDict["verify"] == nil {
                userInfo.verify = 0
            } else {
                userInfo.verify = dataDict["verify"] as? Int
            }
            userInfo.headImage = dataDict["headImage"] == nil ? "" : dataDict["headImage"] as? String
            if dataDict["redPacketCount"] == nil {
                userInfo.redPacketCount = 0
            } else {
                userInfo.redPacketCount = dataDict["redPacketCount"] as? Int
            }
            if dataDict["balanceAmount"] == nil {
                userInfo.balanceAmount = 0.0
            } else {
                userInfo.balanceAmount = dataDict["balanceAmount"] as? Double
            }
            userInfo.signInToday = dataDict["signInToday"] == nil ? "" : dataDict["signInToday"] as? String
            userInfo.yhzxShowFlag = dataDict["yhzxShowFlag"] == nil ? "" : dataDict["yhzxShowFlag"] as? String
            userInfo.gender = dataDict["gender"] == nil ? "" : dataDict["gender"] as? String
            USERDEFAULT.saveCustomObject(customObject: userInfo, key: "userInfo")
        }) { (errorInfo) in
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
