//
//  MyCashVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/2/27.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class MyCashVC: BasicVC, UIAlertViewDelegate {
    var unitLabel : UILabel = UILabel()// 金额的单位
    var amountLabel : UILabel = UILabel()// 金额
    var ruleLabel : UILabel = UILabel()// 提示信息
    var cardLabel : UILabel = UILabel()// 银行卡
    var cardBtn : UIButton = UIButton()// 银行卡认证
    var bankInfo : CashModel?// 数据
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 获取我的现金信息
        requestBankCard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
    }

    
    // 创建UI
    func createUI() -> Void {
        // 头部背景
        let backImage : UIImageView = UIImageView()
        backImage.image = UIImage (named: "bindBankHeaderBg.png")
        self.view.addSubview(backImage)
        backImage.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(110 * HEIGHT_SCALE)
        }
        
        // 黄色圆圈
        let infoBackImage : UIImageView = UIImageView()
        infoBackImage.image = UIImage (named: "bindBankHeaderIcon.png")
        infoBackImage.contentMode = UIViewContentMode.center
        infoBackImage.layer.masksToBounds = true
        backImage.addSubview(infoBackImage)
        infoBackImage.snp.makeConstraints { (make) in
            make.top.bottom.centerX.equalTo(backImage)
            make.width.equalTo(180 * WIDTH_SCALE)
        }
        
        // 金额及单位
        self.amountLabel.font = UIFont.systemFont(ofSize: 26 * WIDTH_SCALE)
        self.amountLabel.textAlignment = NSTextAlignment.center
        self.amountLabel.textColor = UIColor.white
        infoBackImage.addSubview(self.amountLabel)
        self.amountLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(infoBackImage.snp.centerX).offset(-8 * WIDTH_SCALE)
            make.centerY.equalTo(infoBackImage.snp.centerY).offset(-10 * WIDTH_SCALE)
            make.height.equalTo(27 * WIDTH_SCALE)
        }
        
        self.unitLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.unitLabel.textAlignment = NSTextAlignment.left
        self.unitLabel.text = "元"
        self.unitLabel.textColor = UIColor.white
        infoBackImage.addSubview(self.unitLabel)
        self.unitLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.amountLabel.snp.bottom).offset(-1 * WIDTH_SCALE)
            make.left.equalTo(self.amountLabel.snp.right)
        }
        
        // 满多少钱可以提现
        self.ruleLabel.font = UIFont.systemFont(ofSize: 11 * WIDTH_SCALE)
        self.ruleLabel.textAlignment = NSTextAlignment.center
        self.ruleLabel.textColor = UIColor.white
        infoBackImage.addSubview(self.ruleLabel)
        self.ruleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(infoBackImage.snp.bottom).offset(-17 * HEIGHT_SCALE)
            make.left.right.equalTo(infoBackImage)
        }
        
        // 银行卡
        let bankView : UIView = UIView()
        bankView.backgroundColor = UIColor.white
        self.view.addSubview(bankView)
        bankView.snp.makeConstraints { (make) in
            make.right.left.equalTo(self.view)
            make.height.equalTo(44 * HEIGHT_SCALE)
            make.top.equalTo(backImage.snp.bottom).offset(10 * HEIGHT_SCALE)
        }
        
        let titleLabel : UILabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        titleLabel.text = "提现至"
        titleLabel.textColor = TEXT_SECOND_COLOR
        bankView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(bankView)
            make.left.equalTo(bankView.snp.left).offset(15 * WIDTH_SCALE)
        }
        
        self.cardLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.cardLabel.textColor = TEXT_SECOND_COLOR
        bankView.addSubview(self.cardLabel)
        self.cardLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(bankView)
            make.left.equalTo(titleLabel.snp.right).offset(5 * WIDTH_SCALE)
        }
        
        self.cardBtn.setTitleColor(UIColor().colorWithHexString(hex: "009CFF"), for: UIControlState.normal)
        self.cardBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.cardBtn.addTarget(self, action: #selector(bankClick), for: UIControlEvents.touchUpInside)
        bankView.addSubview(self.cardBtn)
        self.cardBtn.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(bankView)
            make.right.equalTo(bankView.snp.right).offset(-15 * WIDTH_SCALE)
        }
        
        
        // 我要提现
        let withdrawalBtn = UIButton (type: UIButtonType.custom)
        withdrawalBtn.backgroundColor = NAVIGATION_COLOR
        withdrawalBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        withdrawalBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18 * WIDTH_SCALE)
        withdrawalBtn.setTitle("我要提现", for: UIControlState.normal)
        withdrawalBtn.layer.cornerRadius = 2
        withdrawalBtn.layer.masksToBounds = true
        withdrawalBtn.addTarget(self, action: #selector(withdrawalClick), for: UIControlEvents.touchUpInside)
        self.view.addSubview(withdrawalBtn)
        withdrawalBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(15 * WIDTH_SCALE)
            make.right.equalTo(self.view.snp.right).offset(-15 * WIDTH_SCALE)
            make.top.equalTo(bankView.snp.bottom).offset(20 * HEIGHT_SCALE)
            make.height.equalTo(40 * HEIGHT_SCALE)
        }
        
        // 邀好友拿现金
        let invitationBtn = UIButton (type: UIButtonType.custom)
        invitationBtn.backgroundColor = UIColor.clear
        invitationBtn.setTitleColor(NAVIGATION_COLOR, for: UIControlState.normal)
        invitationBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18 * WIDTH_SCALE)
        invitationBtn.setTitle("邀好友拿现金", for: UIControlState.normal)
        invitationBtn.layer.borderColor = NAVIGATION_COLOR.cgColor
        invitationBtn.layer.borderWidth = 1
        invitationBtn.layer.cornerRadius = 2
        invitationBtn.layer.masksToBounds = true
        invitationBtn.addTarget(self, action: #selector(invitationClick), for: UIControlEvents.touchUpInside)
        self.view.addSubview(invitationBtn)
        invitationBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(15 * WIDTH_SCALE)
            make.right.equalTo(self.view.snp.right).offset(-15 * WIDTH_SCALE)
            make.top.equalTo(withdrawalBtn.snp.bottom).offset(10 * HEIGHT_SCALE)
            make.height.equalTo(40 * HEIGHT_SCALE)
        }
        
    }
    
    
    // 银行卡认证
    func bankClick() -> Void {
        self.navigationController?.pushViewController(bankCard(), animated: true)
    }
    
    
    // 我要提现点击事件
    func withdrawalClick() -> Void {
        if self.bankInfo?.hasCard == "1" {
            XPrint("提现流程。。。")
        } else {
            let alertView : UIAlertView = UIAlertView (title: "提现之前请认证您的银行卡", message: "", delegate: self as UIAlertViewDelegate, cancelButtonTitle: "取消", otherButtonTitles: "立即认证")
            alertView.show()
        }
    }
    
    // 邀好友拿现金
    func invitationClick() -> Void {
        self.navigationController?.pushViewController(userCenterWebViewWithUrl(url: InvitingFriends), animated: true)
    }
    
    
    // MARK: UIAlertViewDelegate
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if buttonIndex == 0 {
        } else {
            // 银行卡认证
            bankClick()
        }
    }
    
    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "我的现金");
        
        let rightBtn = UIButton (type: UIButtonType.custom)
        rightBtn.frame = CGRect (x: 0, y: 0, width: 60 * WIDTH_SCALE, height: 30)
        rightBtn.addTarget(self, action: #selector(cashDetail), for: UIControlEvents.touchUpInside)
        rightBtn.setTitle("资金明细", for: UIControlState.normal)
        rightBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15 * WIDTH_SCALE)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (customView: rightBtn)
    }
    
    
    // 资金明细
    func cashDetail() -> Void {
        self.navigationController?.pushViewController(capitalDetails(), animated: true)
    }

    
    // 获取我的现金信息
    func requestBankCard() -> Void {
        UserCenterService.userInstance.requestMyCash(success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            self.bankInfo = CashModel.objectWithKeyValues(dict: dataDict) as? CashModel
            
            // 更新界面
            self.amountLabel.text = NSString (format: "%@.00", (self.bankInfo?.balance)!) as String
            self.ruleLabel.text = NSString (format: "满%@元可提现啦！", (self.bankInfo?.auditAmount)!) as String
            if self.bankInfo?.hasCard == "0" {
                self.cardLabel.text = "- -"
                self.cardBtn.setTitle("银行卡认证", for: UIControlState.normal)
            } else {
                self.cardLabel.text = self.bankInfo?.cardInfo as String?
                self.cardBtn.setTitle("变更", for: UIControlState.normal)
            }
        }) { (errorInfo) in
        }
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
