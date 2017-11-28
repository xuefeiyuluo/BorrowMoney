//
//  ModifyPasswordVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/21.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class ModifyPasswordVC: BasicVC {
    
    var psw1 : UITextField?
    var psw2 : UITextField?
    var psw1View : UIView?
    var psw2View : UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
    }

    // 创建界面
    func createUI() -> Void {
        // 设置登陆密码
        createPsw1()
        
        // 再次设置登陆密码
        createPsw2()
        
        // 按钮
        createBtnUI()
    }
    
    
    
    func createPsw1() -> Void {
        let userView = UIView()
        userView.backgroundColor = UIColor.white
        self.psw1View = userView
        self.view .addSubview(userView)
        userView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
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
        
        let iconImage = UIImageView (image: UIImage (named: "pass_icon"))
        iconImage.contentMode = UIViewContentMode.center
        userView.addSubview(iconImage)
        iconImage .snp .makeConstraints { (make) in
            make.left.equalTo(userView.snp.left).offset(15 * WIDTH_SCALE)
            make.top.bottom.equalTo(userView)
            make.width.equalTo(25 * WIDTH_SCALE)
        }
        
        let lineView2 = UIView()
        lineView2.backgroundColor = LINE_COLOR2
        userView .addSubview(lineView2)
        lineView2 .snp .makeConstraints { (make) in
            make.top.equalTo(userView.snp.top).offset(13 * HEIGHT_SCALE)
            make.left.equalTo(iconImage.snp.right).offset(3 * WIDTH_SCALE)
            make.width.equalTo(1 * HEIGHT_SCALE)
            make.bottom.equalTo(userView.snp.bottom).offset(-10 * HEIGHT_SCALE)
        }
        
        self.psw1 = UITextField()
        self.psw1?.placeholder = "请设置登陆密码"
        self.psw1?.font = UIFont .systemFont(ofSize: 14 * WIDTH_SCALE)
        self.psw1?.keyboardType = UIKeyboardType.numberPad
        self.psw1?.clearButtonMode = UITextFieldViewMode.always
        userView .addSubview(self.psw1!)
        self.psw1?.snp.makeConstraints { (make) in
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

    
    func createPsw2() -> Void {
        let view = UIView()
        view.backgroundColor = UIColor.white
        self.psw2View = view
        self.view .addSubview(self.psw2View!)
        self.psw2View?.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo((self.psw1View?.snp.bottom)!)
            make.height.equalTo(45 * HEIGHT_SCALE)
        }
        
        
        let pswImage = UIImageView (image: UIImage (named: "pass_icon"))
        pswImage .contentMode = UIViewContentMode.center
        self.psw2View? .addSubview(pswImage)
        pswImage .snp .makeConstraints { (make) in
            make.left.equalTo((self.psw2View?.snp.left)!).offset(15 * WIDTH_SCALE)
            make.top.bottom.equalTo(self.psw2View!)
            make.width.equalTo(25 * WIDTH_SCALE)
        }
        
        let lineView2 = UIView()
        lineView2.backgroundColor = LINE_COLOR2
        self.psw2View? .addSubview(lineView2)
        lineView2 .snp .makeConstraints { (make) in
            make.top.equalTo((self.psw2View?.snp.top)!).offset(13 * HEIGHT_SCALE)
            make.left.equalTo(pswImage.snp.right).offset(3 * WIDTH_SCALE)
            make.width.equalTo(1 * HEIGHT_SCALE)
            make.bottom.equalTo((self.psw2View?.snp.bottom)!).offset(-10 * HEIGHT_SCALE)
        }
        
        self.psw2 = UITextField()
        self.psw2?.placeholder = "请再次设置登陆密码"
        self.psw2?.font = UIFont .systemFont(ofSize: 14 * WIDTH_SCALE)
        self.psw2?.keyboardType = UIKeyboardType.asciiCapable
        self.psw2?.clearButtonMode = UITextFieldViewMode.always
        self.psw2View? .addSubview(self.psw2!)
        self.psw2?.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self.psw2View!)
            make.left.equalTo(lineView2.snp.right).offset(10 * WIDTH_SCALE)
        }
    }
    
    
    func createBtnUI() -> Void {
        let loginBtn = UIButton (type: UIButtonType.custom)
        loginBtn.backgroundColor = NAVIGATION_COLOR
        loginBtn .setTitle("下一步", for: UIControlState.normal)
        loginBtn.titleLabel?.font = UIFont .systemFont(ofSize: 17 * HEIGHT_SCALE)
        loginBtn.layer.cornerRadius = 2 * HEIGHT_SCALE
        loginBtn.layer.masksToBounds = true
        loginBtn .addTarget(self, action: #selector(loginClick), for: UIControlEvents.touchUpInside)
        self.view .addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo((self.psw2View?.snp.bottom)!).offset(15 * HEIGHT_SCALE)
            make.left.equalTo(self.view.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.view.snp.right).offset(-10 * WIDTH_SCALE)
            make.height.equalTo(44 * HEIGHT_SCALE)
        }
        
        
        let textBtn = UIButton (type: UIButtonType.custom)
        textBtn .setTitle("登陆密码至少为6个字符", for: UIControlState.normal)
        textBtn .setTitleColor(TEXT_LIGHT_COLOR, for: UIControlState.normal)
        textBtn.setImage(UIImage (named: "sigh_icon.png"), for: UIControlState.normal)
        textBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 7 * WIDTH_SCALE)
        textBtn.titleLabel?.font = UIFont .systemFont(ofSize: 13 * HEIGHT_SCALE)
        self.view .addSubview(textBtn)
        textBtn.snp.makeConstraints { (make) in
            make.top.equalTo(loginBtn.snp.bottom).offset(10 * HEIGHT_SCALE)
            make.left.right.equalTo(self.view)
            make.height.equalTo(15 * HEIGHT_SCALE)
        }
    }
    
    
    // 下一步点击事件
    func loginClick() -> Void {
        // 输入信息验证
        if dataValidation() {
            UserCenterService.userInstance.changePassword(psw: (self.psw1?.text)!, success: { (responseObject) in
                self.navigationController?.popViewController(animated: true)
            }, failure: { (errorInfo) in
                
            })
        }
    }
    
    
    // 输入信息验证
    func dataValidation() -> Bool {
        if self.isEmptyAndNil(str: (self.psw1?.text)!) || (self.psw1?.text?.characters.count)! < 6 || self.isEmptyAndNil(str: (self.psw2?.text)!) || (self.psw2?.text?.characters.count)! < 6{
            SVProgressHUD.showError(withStatus: "请设置正确的登陆密码")
            return false
        } else if self.psw1?.text != self.psw2?.text{
            SVProgressHUD.showError(withStatus: "输入的两次登陆密码不一致")
            return false
        }
        return true
    }
    
    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "修改密码");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
