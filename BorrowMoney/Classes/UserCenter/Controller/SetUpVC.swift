//
//  SetUpVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/15.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class SetUpVC: BasicVC {

    var messageView : UIView?
    var pswView : UIView?
    var phoneView : UIView?
    var aboutView : UIView?
    var pushSwith : UISwitch?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 查询消息推送的状态
        requestPushMessageState()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 建界面
        createUI()
    }
    
    
    // 创建界面
    func createUI() -> Void {
        // 消息推送
        createMessageView()
        
        // 密码修改
        createPswView()
        
        // 客服电话
        createPhoneView()
        
        // 关于
        createAboutView()
        
        let loginOut : UIButton = UIButton (type: UIButtonType.custom)
        loginOut.backgroundColor = UIColor.red
        loginOut .setTitle("退出登录", for: UIControlState.normal)
        loginOut.layer.cornerRadius = 2;
        loginOut.layer.masksToBounds = true
        loginOut .addTarget(self, action: #selector(loginOutClick), for: UIControlEvents.touchUpInside)
        loginOut.titleLabel?.font = UIFont .systemFont(ofSize: 17 * WIDTH_SCALE)
        self.view .addSubview(loginOut)
        loginOut.snp.makeConstraints { (make) in
            make.top.equalTo((self.aboutView?.snp.bottom)!).offset(20 * HEIGHT_SCALE)
            make.left.equalTo(self.view.snp.left).offset(20 * WIDTH_SCALE)
            make.right.equalTo(self.view.snp.right).offset(-20 * WIDTH_SCALE)
            make.height.equalTo(45 * HEIGHT_SCALE)
        }
        
    }
    
    // 消息推送
    func createMessageView() -> Void {
        let messageView = UIView()
        messageView.backgroundColor = UIColor.white
        self.messageView = messageView
        self.view .addSubview(self.messageView!)
        self.messageView?.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view.snp.top).offset(10 * HEIGHT_SCALE)
            make.height.equalTo(44 * HEIGHT_SCALE)
        }
        
        let titleName = UILabel()
        titleName.text = "消息推送"
        titleName.textColor = TEXT_BLACK_COLOR
        titleName.font = UIFont .systemFont(ofSize: 14 * HEIGHT_SCALE)
        self.messageView?.addSubview(titleName)
        titleName.snp.makeConstraints { (make) in
            make.top.equalTo(self.messageView!)
            make.left.equalTo((self.messageView?.snp.left)!).offset(15 * HEIGHT_SCALE)
            make.bottom.equalTo((self.messageView?.snp.bottom)!).offset(-0.5 * HEIGHT_SCALE)
        }

        
        let pushSwith : UISwitch = UISwitch()
        pushSwith .addTarget(self, action: #selector(pushSwitchClick), for: UIControlEvents.valueChanged)
        self.pushSwith = pushSwith
        self.messageView?.addSubview(self.pushSwith!)
        self.pushSwith?.snp.makeConstraints { (make) in
            make.top.equalTo((self.messageView?.snp.top)!).offset(8 * HEIGHT_SCALE)
            make.bottom.equalTo((self.messageView?.snp.bottom)!).offset(-8 * HEIGHT_SCALE)
            make.right.equalTo((self.messageView?.snp.right)!).offset(-15 * WIDTH_SCALE)
        }
        
        
        let lineView2 = UIView()
        lineView2.backgroundColor = LINE_COLOR1
        self.messageView?.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self.messageView!)
            make.height.equalTo(0.5 * HEIGHT_SCALE)
        }
    }
    
    
    // 密码修改
    func createPswView() -> Void {
        let pswView = UIView()
        pswView.backgroundColor = UIColor.white
        self.pswView = pswView
        self.view .addSubview(self.pswView!)
        self.pswView?.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo((self.messageView?.snp.bottom)!).offset(10 * HEIGHT_SCALE)
            make.height.equalTo(44 * HEIGHT_SCALE)
        }
        let tapClick : UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(tapPswClick))
        self.pswView?.addGestureRecognizer(tapClick)
        
        
        let titleName = UILabel()
        titleName.text = "密码修改"
        titleName.textColor = TEXT_BLACK_COLOR
        titleName.font = UIFont .systemFont(ofSize: 14 * HEIGHT_SCALE)
        self.pswView?.addSubview(titleName)
        titleName.snp.makeConstraints { (make) in
            make.top.equalTo(self.pswView!)
            make.left.equalTo((self.pswView?.snp.left)!).offset(15 * HEIGHT_SCALE)
            make.bottom.equalTo((self.pswView?.snp.bottom)!).offset(-0.5 * HEIGHT_SCALE)
        }
        
        
        let enterImageView : UIImageView = UIImageView()
        enterImageView.contentMode = .center
        enterImageView.image = UIImage (named: "rightArrow.png")
        pswView.addSubview(enterImageView)
        enterImageView.snp.makeConstraints { (make) in
            make.right.equalTo((self.pswView?.snp.right)!).offset(-10 * WIDTH_SCALE)
            make.top.bottom.equalTo(self.pswView!)
            make.width.equalTo(25 * WIDTH_SCALE)
        }

        
        let lineView2 = UIView()
        lineView2.backgroundColor = LINE_COLOR1
        self.pswView?.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self.pswView!)
            make.height.equalTo(0.5 * HEIGHT_SCALE)
        }
    }
    
    // 客服电话
    func createPhoneView() -> Void {
        let phoneView = UIView()
        phoneView.backgroundColor = UIColor.white
        self.phoneView = phoneView
        self.view .addSubview(self.phoneView!)
        self.phoneView?.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo((self.pswView?.snp.bottom)!).offset(10 * HEIGHT_SCALE)
            make.height.equalTo(44 * HEIGHT_SCALE)
        }
        let tapClick : UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(tapPhoneClick))
        self.phoneView?.addGestureRecognizer(tapClick)
        
        let titleName = UILabel()
        titleName.text = "客服电话"
        titleName.textColor = TEXT_BLACK_COLOR
        titleName.font = UIFont .systemFont(ofSize: 14 * HEIGHT_SCALE)
        self.phoneView?.addSubview(titleName)
        titleName.snp.makeConstraints { (make) in
            make.top.equalTo(self.phoneView!)
            make.left.equalTo((self.phoneView?.snp.left)!).offset(15 * HEIGHT_SCALE)
            make.bottom.equalTo((self.phoneView?.snp.bottom)!).offset(-0.5 * HEIGHT_SCALE)
        }
        
        
        let enterImageView : UIImageView = UIImageView()
        enterImageView.contentMode = .center
        enterImageView.image = UIImage (named: "rightArrow.png")
        phoneView.addSubview(enterImageView)
        enterImageView.snp.makeConstraints { (make) in
            make.right.equalTo((self.phoneView?.snp.right)!).offset(-10 * WIDTH_SCALE)
            make.top.bottom.equalTo(self.phoneView!)
            make.width.equalTo(25 * WIDTH_SCALE)
        }
        
        let telLabel = UILabel()
        telLabel.font = UIFont .systemFont(ofSize: 14 * WIDTH_SCALE)
        telLabel.textColor = UIColor.red
        telLabel.text = "400-825-2221"
        phoneView .addSubview(telLabel)
        telLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.phoneView!)
            make.right.equalTo(enterImageView.snp.left)
        }
        
        
        let lineView2 = UIView()
        lineView2.backgroundColor = LINE_COLOR1
        self.phoneView?.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self.phoneView!)
            make.height.equalTo(0.5 * HEIGHT_SCALE)
        }
    }
    
    
    // 关于
    func createAboutView() -> Void {
        let aboutView = UIView()
        aboutView.isUserInteractionEnabled = true
        aboutView.backgroundColor = UIColor.white
        self.aboutView = aboutView
        self.view .addSubview(self.aboutView!)
        self.aboutView?.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo((self.phoneView?.snp.bottom)!).offset(10 * HEIGHT_SCALE)
            make.height.equalTo(44 * HEIGHT_SCALE)
        }
        let tapClick : UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(tapAboutClick))
        self.aboutView?.addGestureRecognizer(tapClick)
        
        
        let titleName = UILabel()
        titleName.text = "关于"
        titleName.textColor = TEXT_BLACK_COLOR
        titleName.font = UIFont .systemFont(ofSize: 14 * HEIGHT_SCALE)
        self.aboutView?.addSubview(titleName)
        titleName.snp.makeConstraints { (make) in
            make.top.equalTo(self.aboutView!)
            make.left.equalTo((self.aboutView?.snp.left)!).offset(15 * HEIGHT_SCALE)
            make.bottom.equalTo((self.aboutView?.snp.bottom)!).offset(-0.5 * HEIGHT_SCALE)
        }
        
        
        let enterImageView : UIImageView = UIImageView()
        enterImageView.contentMode = .center
        enterImageView.image = UIImage (named: "rightArrow.png")
        self.aboutView?.addSubview(enterImageView)
        enterImageView.snp.makeConstraints { (make) in
            make.right.equalTo((self.aboutView?.snp.right)!).offset(-10 * WIDTH_SCALE)
            make.top.bottom.equalTo(self.aboutView!)
            make.width.equalTo(25 * WIDTH_SCALE)
        }
        
        
        let lineView2 = UIView()
        lineView2.backgroundColor = LINE_COLOR1
        self.aboutView?.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self.aboutView!)
            make.height.equalTo(0.5 * HEIGHT_SCALE)
        }
    }
    
    
    // 消息推送开关
    func pushSwitchClick() -> Void {
        var state : String = ""
        
        if (self.pushSwith?.isOn)! {
            state = "1"
        } else {
            state = "0"
        }
        
        UserCenterService.userInstance.pushMessageChangeStates(state: state, success: { (responseObject) in
        }) { (errorInfo) in
        }
    }
    
    
    // 修改密码
    func tapPswClick() -> Void {
        self.navigationController?.pushViewController(modifyPassword(), animated: true)
    }
    
    
    // 客服电话
    func tapPhoneClick() -> Void {
        UIApplication.shared.openURL(URL (string: "tel://4008252221")!)
    }
    
    
    // 关于
    func tapAboutClick() -> Void {
        self.navigationController?.pushViewController(about(), animated: true)
    }
    
    
    // 退出登录
    func loginOutClick() -> Void {
        UserCenterService.userInstance.loginOut(success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            if dataDict["code"] as! String == "0" {
                USERDEFAULT.removeObject(forKey: "userInfo")
                USERDEFAULT.synchronize()
                self.navigationController?.popViewController(animated: true)
                
                
                
                
            }
        }) { (errorInfo) in
        }
    }

    
    // 查询消息推送的状态
    func requestPushMessageState() -> Void {
        UserCenterService.userInstance.requestPushMessageChangeStates(success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            if dataDict["ios_notification_enable"] as! Int == 0 {
                self.pushSwith?.setOn(false, animated: true)
            } else {
                self.pushSwith?.setOn(true, animated: true)
            }
        }) { (errorInfo) in
            
        }
    }
    
    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "设置");
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
