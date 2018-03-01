//
//  BankCardVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/2/27.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class BankCardVC: BasicVC, UITextFieldDelegate {
    var headerView : UIView = UIView()// 头部View
    var writeView : UIView = UIView()// 创建输入信息View
    var footerView : UIView = UIView()// 底部View
    var stepImageView : UIImageView = UIImageView()// 步骤图片
    var step1Label : UILabel = UILabel()// 输入卡信息
    var step2Label : UILabel = UILabel()// 手机验证
    var step3Label : UILabel = UILabel()// 完成
    var bankSelect : UIButton = UIButton()// 选择银行
    var promptLabel : UILabel = UILabel()// "下一步"下的提示信息
    var bankCardNum : UITextField = UITextField()// 银行卡号
    var bankCardName : UITextField = UITextField()// 持卡人姓名
    var personCard : UITextField = UITextField()// 身份证持卡人
    var shadeBtn : UIButton = UIButton()// 遮挡界面
    var sheetView : BankSheetView = BankSheetView()// 弹框

    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建UI
        createUI()
    }

    
    // 创建UI
    func createUI() -> Void {
        
        // 创建头部
        createHeaderView()
        
        // 创建输入信息View
        createInputView()
        
        // 创建底部
        createFooterView()
        
        // 遮盖及弹框
        createOtherView()
    }
    
    
    // 创建头部
    func createHeaderView() -> Void {
        self.view.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(80 * HEIGHT_SCALE)
        }
        
        // 步骤图片
        self.stepImageView.contentMode = UIViewContentMode.center
        self.stepImageView.image = UIImage (named: "bankCard1.png")
        self.headerView.addSubview(self.stepImageView)
        self.stepImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.headerView.snp.centerX)
            make.height.equalTo(35 * HEIGHT_SCALE)
            make.width.equalTo(200 * WIDTH_SCALE)
            make.bottom.equalTo(self.headerView.snp.bottom).offset(-10 * HEIGHT_SCALE)
        }
        
        // 输入卡信息
        self.step1Label.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        self.step1Label.textColor = NAVIGATION_COLOR
        self.step1Label.text = "输入卡信息"
        self.headerView.addSubview(self.step1Label)
        self.step1Label.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.stepImageView.snp.left)
            make.bottom.equalTo(self.stepImageView.snp.top)
        }
        
        // 手机验证
        self.step2Label.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        self.step2Label.textColor = LINE_COLOR3
        self.step2Label.text = "手机验证"
        self.headerView.addSubview(self.step2Label)
        self.step2Label.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.headerView.snp.centerX)
            make.bottom.equalTo(self.stepImageView.snp.top)
        }
        
        // 完成
        self.step3Label.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        self.step3Label.textColor = LINE_COLOR3
        self.step3Label.text = "完成"
        self.headerView.addSubview(self.step3Label)
        self.step3Label.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.stepImageView.snp.right).offset(-5 * WIDTH_SCALE)
            make.bottom.equalTo(self.stepImageView.snp.top)
        }
    }
    
    
    // 创建输入信息View
    func createInputView() -> Void {
        self.writeView.backgroundColor = UIColor.white
        self.view.addSubview(self.writeView)
        self.writeView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom)
            make.left.right.equalTo(self.view)
            make.height.equalTo(186 * HEIGHT_SCALE)
        }
        
        let lineView1 : UIView = UIView()
        lineView1.backgroundColor = LINE_COLOR1
        self.writeView.addSubview(lineView1)
        lineView1.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.writeView)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        // 输入银行卡号
        self.bankCardNum.placeholder = "请输入银行卡卡号"
        self.bankCardNum.keyboardType = UIKeyboardType.numberPad
        self.bankCardNum.textColor = UIColor().colorWithHexString(hex: "333333")
        self.bankCardNum.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.bankCardNum.delegate = self
        self.writeView.addSubview(self.bankCardNum)
        self.bankCardNum.snp.makeConstraints { (make) in
            make.top.equalTo(lineView1.snp.bottom)
            make.height.equalTo(43 * HEIGHT_SCALE)
            make.left.equalTo(self.writeView.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.writeView.snp.right).offset(-10 * WIDTH_SCALE)
        }
        
        let lineView2 : UIView = UIView()
        lineView2.backgroundColor = LINE_COLOR1
        self.writeView.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.writeView)
            make.top.equalTo(self.bankCardNum.snp.bottom)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        // 选择银行
        let imageView : UIImageView = UIImageView()
        imageView.contentMode = UIViewContentMode.center
        imageView.image = UIImage (named: "downArrow.PNG")
        self.writeView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(lineView2.snp.bottom)
            make.right.equalTo(self.writeView.snp.right).offset(-10 * WIDTH_SCALE)
            make.width.equalTo(30 * WIDTH_SCALE)
            make.height.equalTo(43 * HEIGHT_SCALE)
        }
        
        self.bankSelect.setTitle("请选择银行", for: UIControlState.normal)
        self.bankSelect.setTitleColor(LINE_COLOR1, for: UIControlState.normal)
        self.bankSelect.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        self.bankSelect.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13 * WIDTH_SCALE)
        self.bankSelect.addTarget(self, action: #selector(bankClick), for: UIControlEvents.touchUpInside)
        self.writeView.addSubview(self.bankSelect)
        self.bankSelect.snp.makeConstraints { (make) in
            make.top.equalTo(lineView2.snp.bottom)
            make.height.equalTo(43 * HEIGHT_SCALE)
            make.left.equalTo(self.writeView.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.writeView.snp.right).offset(-10 * WIDTH_SCALE)
        }
        
        let lineView3 : UIView = UIView()
        lineView3.backgroundColor = LINE_COLOR1
        self.writeView.addSubview(lineView3)
        lineView3.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.writeView)
            make.top.equalTo(self.bankSelect.snp.bottom)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        let view : UIView = UIView()
        view.backgroundColor = MAIN_COLOR
        self.writeView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.writeView)
            make.top.equalTo(lineView3.snp.bottom)
            make.height.equalTo(8 * HEIGHT_SCALE)
        }
        
        let lineView4 : UIView = UIView()
        lineView4.backgroundColor = LINE_COLOR1
        self.writeView.addSubview(lineView4)
        lineView4.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.writeView)
            make.top.equalTo(view.snp.bottom)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        // 持卡人姓名
        self.bankCardName.placeholder = "请输入持卡人姓名"
        self.bankCardName.textColor = UIColor().colorWithHexString(hex: "333333")
        self.bankCardName.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.bankCardName.delegate = self
        self.writeView.addSubview(self.bankCardName)
        self.bankCardName.snp.makeConstraints { (make) in
            make.top.equalTo(lineView4.snp.bottom)
            make.height.equalTo(43 * HEIGHT_SCALE)
            make.left.equalTo(self.writeView.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.writeView.snp.right).offset(-10 * WIDTH_SCALE)
        }
        
        let lineView5 : UIView = UIView()
        lineView5.backgroundColor = LINE_COLOR1
        self.writeView.addSubview(lineView5)
        lineView5.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.writeView)
            make.top.equalTo(self.bankCardName.snp.bottom)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        // 身份证持卡人
        self.personCard.placeholder = "请输入持卡人身份证号码"
        self.personCard.textColor = UIColor().colorWithHexString(hex: "333333")
        self.personCard.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.personCard.delegate = self
        self.writeView.addSubview(self.personCard)
        self.personCard.snp.makeConstraints { (make) in
            make.top.equalTo(lineView5.snp.bottom)
            make.height.equalTo(43 * HEIGHT_SCALE)
            make.left.equalTo(self.writeView.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.writeView.snp.right).offset(-10 * WIDTH_SCALE)
        }
        
        let lineView6 : UIView = UIView()
        lineView6.backgroundColor = LINE_COLOR1
        self.writeView.addSubview(lineView6)
        lineView6.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self.writeView)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
    }
    
    
    // 创建底部
    func createFooterView() -> Void {
        self.view.addSubview(self.footerView)
        self.footerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.writeView.snp.bottom)
            make.left.right.equalTo(self.view)
            make.height.equalTo(100 * HEIGHT_SCALE)
        }
        
        let nextBtn : UIButton = UIButton (type: UIButtonType.custom)
        nextBtn.setTitle("下一步", for: UIControlState.normal)
        nextBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18 * WIDTH_SCALE)
        nextBtn.backgroundColor = NAVIGATION_COLOR
        nextBtn.layer.cornerRadius = 2
        nextBtn.layer.masksToBounds = true
        nextBtn.addTarget(self, action: #selector(nextClick), for: UIControlEvents.touchUpInside)
        self.footerView.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.footerView.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.footerView.snp.right).offset(-10 * WIDTH_SCALE)
            make.height.equalTo(44 * HEIGHT_SCALE)
            make.top.equalTo(self.footerView.snp.top).offset(20 * HEIGHT_SCALE)
        }
        
        self.promptLabel.text = "为保证账户资金安全，只可认证用户本人的银行卡。"
        self.promptLabel.textColor = UIColor().colorWithHexString(hex: "5f5f5f")
        self.promptLabel.font = UIFont.systemFont(ofSize: 13 * HEIGHT_SCALE)
        self.promptLabel.numberOfLines = 0
        self.footerView.addSubview(self.promptLabel)
        self.promptLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.footerView.snp.centerX).offset(15 * WIDTH_SCALE)
            make.top.equalTo(nextBtn.snp.bottom).offset(15 * HEIGHT_SCALE)
            make.width.lessThanOrEqualTo(SCREEN_WIDTH - 50 * WIDTH_SCALE)//.offset(30 * WIDTH_SCALE)
        }
        
        let imageView : UIImageView = UIImageView()
        imageView.contentMode = UIViewContentMode.center
        imageView.image = UIImage (named: "sighIcon.png")
        self.footerView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(30 * WIDTH_SCALE)
            make.top.bottom.equalTo(self.promptLabel)
            make.right.equalTo(self.promptLabel.snp.left)
        }
    }
    
    
    // 遮盖及弹框
    func createOtherView() -> Void {
        weak var weakSelf = self
        self.shadeBtn.isHidden = true
        self.shadeBtn.backgroundColor = UIColor.init(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 0.5)
        self.shadeBtn.addTarget(self, action: #selector(shadeClick), for: UIControlEvents.touchUpInside)
        self.view.addSubview(self.shadeBtn)
        self.shadeBtn.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.view)
        }
        
        // 弹框
        self.sheetView.backgroundColor = UIColor.white
        self.sheetView.frame = CGRect (x:0 , y: SCREEN_HEIGHT - 64, width: SCREEN_WIDTH, height: 200 * HEIGHT_SCALE)
        self.view.addSubview(self.sheetView)
        self.sheetView.bankSheetBlock = { (tag) in
            if tag == 501 {
                
            }
            weakSelf?.shadeClick()
        }
    }

    
    // 选择银行的点击事件
    func bankClick() -> Void {
        self.view.endEditing(true)
        self.shadeBtn.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.sheetView.frame = CGRect (x:0 , y: SCREEN_HEIGHT - 64 - 200 * HEIGHT_SCALE, width: SCREEN_WIDTH, height: 200 * HEIGHT_SCALE)
        }
    }
    
    
    // 下一步的点击事件
    func nextClick() -> Void {
        if self.bankCardNum.text == "" {
            SVProgressHUD.showError(withStatus: "请输入正确的银行卡号")
            return
        }
        
        if self.bankCardName.text == "" {
            SVProgressHUD.showError(withStatus: "请输入正确的持卡人姓名")
            return
        }
        
        if self.personCard.text == "" || !XNumRule().cardRule(cardNum: self.personCard.text!) {
            SVProgressHUD.showError(withStatus: "请输入正确的身份证号码")
            return
        }
        
        
        
    }
    
    
    // 遮挡背景的点击事件
    func shadeClick() -> Void {
        self.shadeBtn.isHidden = !self.shadeBtn.isHidden
        UIView.animate(withDuration: 0.3) {
            self.sheetView.frame = CGRect (x:0 , y: SCREEN_HEIGHT - 64, width: SCREEN_WIDTH, height: 200 * HEIGHT_SCALE)
        }
    }
    
    // text改变时调用
    func bankTextFieldChange(notification:Notification) -> Void {
        let textField:UITextField! = notification.object as! UITextField
        if textField == self.bankCardNum {
            if (textField.text?.count)! > 25 {
                self.bankCardNum.text = textField.text?.substringInRange(0...24)
            }
        } else if textField == self.bankCardName {
            
        } else if textField == self.personCard {
            if (textField.text?.count)! > 18 {
                self.bankCardNum.text = textField.text?.substringInRange(0...17)
            }
        }
    }
    
    
    
    
    
    
    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "添加银行卡");
    }
    
    
    override func initializationData() {
        super.initializationData()
        
        // 注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(bankTextFieldChange(notification:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
