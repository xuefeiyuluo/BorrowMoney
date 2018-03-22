//
//  MechanismLoginVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/20.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class OrganLoginVC: BasicVC {
    var organModel : OrganModel?// 上一个界面
    var iconView : UIView = UIView()// 图标View
    var accountView : UIView = UIView()// 账号View
    var loginView : UIView = UIView()// 登录View
    var footerView : UIView = UIView()// 底部View
    var mobileField : UITextField = UITextField()// 手机号码
    var pswField : UITextField = UITextField()// 密码
    var promptBtn : UIButton = UIButton()// 协议
    var channelModel : ChannelModel = ChannelModel()// 机构信息
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建UI
        createUI()
        
        // 获取用户登录的提示信息
        requestChannelLoginPlaceholder()
    }

    // 创建UI
    func createUI() -> Void {
        // 创建图标View
        createIconView()
        
        // 创建账号View
        createAccountView()
        
        // 创建登录View
        createLoginView()
        
        // 创建底部View
        createBottomView()
    }
    
    // 创建图标View
    func createIconView() -> Void {
        self.view.addSubview(self.iconView)
        self.iconView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(150 * HEIGHT_SCALE)
        }
        
        let backImageView : UIImageView = UIImageView()
        backImageView.layer.cornerRadius = 85 * WIDTH_SCALE / 2
        backImageView.layer.borderColor = UIColor.lightGray.cgColor
        backImageView.layer.borderWidth = 1 * WIDTH_SCALE
        backImageView.backgroundColor = UIColor.white
        backImageView.layer.masksToBounds = true
        self.iconView.addSubview(backImageView)
        backImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view.snp.top).offset(35 * HEIGHT_SCALE)
            make.height.equalTo(85 * WIDTH_SCALE)
            make.width.equalTo(85 * WIDTH_SCALE)
        }
        
        
        // 图标
        let iconImageView : UIImageView = UIImageView()
        iconImageView.layer.cornerRadius = 81 * WIDTH_SCALE / 2
        iconImageView.layer.masksToBounds = true
        iconImageView.kf.setImage(with:URL (string: (self.organModel?.logo)!), placeholder: UIImage (named: "defaultWait.png"), options: nil, progressBlock: nil, completionHandler: nil)
        self.iconView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view.snp.top).offset(37 * HEIGHT_SCALE)
            make.height.equalTo(81 * WIDTH_SCALE)
            make.width.equalTo(81 * WIDTH_SCALE)
        }
    }
    
    
    // 创建账号View
    func createAccountView() -> Void {
        self.view.addSubview(self.accountView)
        self.accountView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.iconView.snp.bottom)
            make.height.equalTo(90 * HEIGHT_SCALE)
        }
        
        // 手机账号
        let mobileIcon : UIImageView = UIImageView()
        mobileIcon.image = UIImage (named: "channelMobile.png")
        mobileIcon.contentMode = UIViewContentMode.center
        self.accountView.addSubview(mobileIcon)
        mobileIcon.snp.makeConstraints { (make) in
            make.top.equalTo(self.accountView)
            make.height.equalTo(44 * HEIGHT_SCALE)
            make.width.equalTo(35 * WIDTH_SCALE)
            make.left.equalTo(self.accountView.snp.left).offset(15 * WIDTH_SCALE)
        }
        
        let verticalLine1 : UIView = UIView()
        verticalLine1.backgroundColor = UIColor().colorWithHexString(hex: "AAAAAA")
        self.accountView.addSubview(verticalLine1)
        verticalLine1.snp.makeConstraints { (make) in
            make.top.equalTo(self.accountView.snp.top).offset(12 * HEIGHT_SCALE)
            make.height.equalTo(25 * HEIGHT_SCALE)
            make.width.equalTo(1 * WIDTH_SCALE)
            make.left.equalTo(mobileIcon.snp.right).offset(10 * WIDTH_SCALE)
        }
        
        self.mobileField.placeholder = String (format: "请输入%@的登录账号",(self.organModel?.name)!)
        self.mobileField.textColor = TEXT_SECOND_COLOR
        self.mobileField.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.mobileField.clearButtonMode = UITextFieldViewMode.whileEditing
        self.accountView.addSubview(self.mobileField)
        self.mobileField.snp.makeConstraints { (make) in
            make.top.equalTo(self.accountView.snp.top).offset(7 * HEIGHT_SCALE)
            make.left.equalTo(verticalLine1.snp.right).offset(10 * WIDTH_SCALE)
            make.height.equalTo(35 * HEIGHT_SCALE)
            make.right.equalTo(self.accountView.snp.right).offset(-15 * WIDTH_SCALE)
        }
        if (self.organModel?.account.isEmpty)! {
            self.mobileField.isUserInteractionEnabled = true
        } else {
            self.mobileField.text = self.organModel?.account
            self.mobileField.isUserInteractionEnabled = false
        }
        
        let lineView1 : UIView = UIView()
        lineView1.backgroundColor = LINE_COLOR2
        self.accountView.addSubview(lineView1)
        lineView1.snp.makeConstraints { (make) in
            make.left.equalTo(self.accountView.snp.left).offset(15 * WIDTH_SCALE)
            make.right.equalTo(self.accountView.snp.right).offset(-15 * WIDTH_SCALE)
            make.top.equalTo(self.accountView.snp.top).offset(44 * HEIGHT_SCALE)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        
        // 登录密码
        let pswIcon : UIImageView = UIImageView()
        pswIcon.image = UIImage (named: "channelPsw.png")
        pswIcon.contentMode = UIViewContentMode.center
        self.accountView.addSubview(pswIcon)
        pswIcon.snp.makeConstraints { (make) in
            make.top.equalTo(lineView1)
            make.height.equalTo(44 * HEIGHT_SCALE)
            make.width.equalTo(35 * WIDTH_SCALE)
            make.left.equalTo(self.accountView.snp.left).offset(15 * WIDTH_SCALE)
        }
        
        
        let verticalLine2 : UIView = UIView()
        verticalLine2.backgroundColor = UIColor().colorWithHexString(hex: "AAAAAA")
        self.accountView.addSubview(verticalLine2)
        verticalLine2.snp.makeConstraints { (make) in
            make.top.equalTo(lineView1.snp.top).offset(12 * HEIGHT_SCALE)
            make.height.equalTo(25 * HEIGHT_SCALE)
            make.width.equalTo(1 * WIDTH_SCALE)
            make.left.equalTo(pswIcon.snp.right).offset(10 * WIDTH_SCALE)
        }
        
        self.pswField.placeholder = String (format: "请输入%@的登录密码",(self.organModel?.name)!)
        self.pswField.textColor = TEXT_SECOND_COLOR
        self.pswField.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.pswField.clearButtonMode = UITextFieldViewMode.whileEditing
        self.accountView.addSubview(self.pswField)
        self.pswField.snp.makeConstraints { (make) in
            make.top.equalTo(lineView1.snp.top).offset(7 * HEIGHT_SCALE)
            make.left.equalTo(verticalLine2.snp.right).offset(10 * WIDTH_SCALE)
            make.height.equalTo(35 * HEIGHT_SCALE)
            make.right.equalTo(self.accountView.snp.right).offset(-15 * WIDTH_SCALE)
        }
        
        
        let lineView2 : UIView = UIView()
        lineView2.backgroundColor = LINE_COLOR2
        self.accountView.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.left.equalTo(self.accountView.snp.left).offset(15 * WIDTH_SCALE)
            make.right.equalTo(self.accountView.snp.right).offset(-15 * WIDTH_SCALE)
            make.bottom.equalTo(self.accountView)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
    }
    
    
    // 创建登录View
    func createLoginView() -> Void {
//        self.loginView.backgroundColor = UIColor.red
        self.view.addSubview(self.loginView)
        self.loginView.snp.makeConstraints { (make) in
            make.top.equalTo(self.accountView.snp.bottom)
            make.left.right.equalTo(self.view)
            make.height.equalTo(90 * HEIGHT_SCALE)
        }
        
        let reimportBtn : UIButton = UIButton (type: UIButtonType.custom)
        reimportBtn.setTitle("一键导入", for: UIControlState.normal)
        reimportBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17 * WIDTH_SCALE)
        reimportBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        reimportBtn.backgroundColor = NAVIGATION_COLOR
        reimportBtn.layer.cornerRadius = 5 * WIDTH_SCALE
        reimportBtn.layer.masksToBounds = true
        reimportBtn.addTarget(self, action: #selector(reimportClick), for: UIControlEvents.touchUpInside)
        self.loginView.addSubview(reimportBtn)
        reimportBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.loginView.snp.left).offset(15 * WIDTH_SCALE)
            make.right.equalTo(self.loginView.snp.right).offset(-15 * WIDTH_SCALE)
            make.height.equalTo(40 * HEIGHT_SCALE)
            make.top.equalTo(self.loginView.snp.top).offset(30 * HEIGHT_SCALE)
        }
        
        // 协议
        let termStr : NSMutableAttributedString = NSMutableAttributedString(string: "我同意授权 借点钱解析网站数据协议")
        let termFirstDict = [NSForegroundColorAttributeName : UIColor().colorWithHexString(hex: "807F7F")]
        termStr.addAttributes(termFirstDict, range: NSMakeRange(0, 6))
        let termSecondDict = [NSForegroundColorAttributeName : UIColor().colorWithHexString(hex: "009CFF")]
        termStr.addAttributes(termSecondDict, range: NSMakeRange(6, 11))
        self.promptBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.promptBtn.setAttributedTitle(termStr, for: UIControlState.normal)
        self.promptBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.promptBtn.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        self.promptBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8 * WIDTH_SCALE)
        self.promptBtn.setImage(UIImage (named: "organSelected.png"), for: UIControlState.selected)
        self.promptBtn.setImage(UIImage (named: "organNormal.png"), for: UIControlState.normal)
        self.promptBtn.isSelected = true
        self.promptBtn.addTarget(self, action: #selector(protocolClick), for: UIControlEvents.touchUpInside)
        self.loginView.addSubview(self.promptBtn)
        self.promptBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.loginView.snp.left).offset(15 * WIDTH_SCALE)
            make.right.equalTo(self.loginView.snp.right).offset(-15 * WIDTH_SCALE)
            make.height.equalTo(30 * HEIGHT_SCALE)
            make.top.equalTo(reimportBtn.snp.bottom).offset(10 * HEIGHT_SCALE)
        }
    }
    
    
    // 创建底部View
    func createBottomView() -> Void {
        self.view.addSubview(self.footerView)
        self.footerView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self.view)
            make.height.equalTo(50 * HEIGHT_SCALE)
        }
        
        let safeBtn : UIButton = UIButton (type: UIButtonType.custom)
        safeBtn.setTitle("采用RSA、AES/DES加密算法，确保安全", for: UIControlState.normal)
        safeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        safeBtn.setTitleColor(LINE_COLOR3, for: UIControlState.normal)
        safeBtn.setImage(UIImage (named: "safe.png"), for: UIControlState.normal)
        safeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10 * WIDTH_SCALE)
        self.footerView.addSubview(safeBtn)
        safeBtn.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.footerView)
            make.bottom.equalTo(self.footerView.snp.bottom).offset(-15 * HEIGHT_SCALE)
        }
    }
    
    
    override func setUpNavigationView() {
        super.setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: NSString (format: "从%@导入", (self.organModel?.name)!) as String)
    }
    
    
    // 一键导入的点击事件
    func reimportClick() -> Void {
        weak var weakSelf = self
        if self.mobileField.text?.count == 0 {
            let alertView : UIAlertView = UIAlertView.init(title:self.channelModel.nameTip , message: "", delegate: nil, cancelButtonTitle: "确定")
            alertView.showWithAlertBlock(alertBlock: { (btnIndex, btnTitle) in
                weakSelf?.mobileField.becomeFirstResponder()
            })
            return
        }
        
        if self.pswField.text?.count == 0 {
            let alertView : UIAlertView = UIAlertView.init(title:self.channelModel.pwdTip , message: "", delegate: nil, cancelButtonTitle: "确定")
            alertView.showWithAlertBlock(alertBlock: { (btnIndex, btnTitle) in
                weakSelf?.pswField.becomeFirstResponder()
            })
            return
        }
        
        
        if self.promptBtn.isSelected {
            if (self.organModel?.account.isEmpty)! {
                UserCenterService.userInstance.requestAddChannelState(channelId: (self.organModel?.channelId)!, loanUserName: self.mobileField.text!, loanPassword: self.pswField.text!, success: { (responseObject) in
                    // 登录成功后的操作
                    self.loginSuccessOperation()
                }, failure: { (error) in
                })
            } else {
                UserCenterService.userInstance.requestUpdateChannelState(channelId: (self.organModel?.channelId)!, loanUserName: self.mobileField.text!, loanPassword: self.pswField.text!, delFlag: "0", success: { (responseObject) in
                    // 登录成功后的操作
                    self.loginSuccessOperation()
                }) { (error) in
                }
            }
        } else {
            SVProgressHUD.showError(withStatus: "请先阅读服务条款")
        }
    }
    
    
    // 登录成功后的操作
    func loginSuccessOperation() -> Void {
        if self.organModel?.entryType == "1" {
            weak var weakSelf = self
            let alertView : UIAlertView = UIAlertView.init(title:"添加账户成功，您可在“个人中心”轻松管理还款，查看订单状态" , message: "", delegate: nil, cancelButtonTitle: "确定")
            alertView.showWithAlertBlock(alertBlock: { (btnIndex, btnTitle) in
                weakSelf?.navigationController?.popToRootViewController(animated: true)
            })
        } else if self.organModel?.entryType == "2" {
            let alertView : UIAlertView = UIAlertView.init(title: "", message: "添加账户成功，您可在“个人中心”轻松管理还款，查看订单状态", delegate: nil, cancelButtonTitle: "继续贷款", otherButtonTitles: "个人中心")
            alertView.showWithAlertBlock(alertBlock: { (btnIndex, btnTitle) in
                if btnIndex == 0 {
                    APPDELEGATE.tabBarControllerSelectedIndex(index: 1)
                } else {
                    APPDELEGATE.tabBarControllerSelectedIndex(index: 2)
                }
                self.navigationController?.popToRootViewController(animated: true)
            })
        } else if self.organModel?.entryType == "3" {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    // 协议的点击事件
    func protocolClick() -> Void {
        self.promptBtn.isSelected = !self.promptBtn.isSelected
    }
    
    
    // 获取用户登录的提示信息
    func requestChannelLoginPlaceholder() -> Void {
        UserCenterService.userInstance.requestChannelLoginPlaceholder(channelId: (self.organModel?.channelId)!, success: { (responseObject) in
            self.channelModel = ChannelModel.objectWithKeyValues(dict: responseObject as! NSDictionary) as! ChannelModel
            
            // 更新UI
            self.mobileField.placeholder = self.channelModel.nameTip
            self.pswField.placeholder = self.channelModel.pwdTip
        }) { (error) in
        }
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
