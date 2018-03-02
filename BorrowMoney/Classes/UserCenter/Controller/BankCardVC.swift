//
//  BankCardVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/2/27.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

enum BankCardStep : Int {
    case BankCardStep1
    case BankCardStep2
    case BankCardStep3
}
class BankCardVC: BasicVC, UITextFieldDelegate {
    var headerView : UIView = UIView()// 头部View
    var writeStep1 : UIView = UIView()// 创建输入信息第一步
    var writeStep2 : UIView = UIView()// 创建输入信息第二步
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
    var bankArray : [BankNameModel]?// 银行名称列表
    var bankSelected : BankNameModel?// 已选中的银行
    var currentStep : BankCardStep = BankCardStep.BankCardStep1// 默认第一步
    var verifiBtn : UIButton = UIButton()// 验证码按钮
    var verifiField : UITextField = UITextField()// 验证码输入
    var graphicCode : String = ""// 图形弹框码
    var countdownTimer: Timer?// 验证码定时器
    var second : Int = 60// 60秒倒计时
    var requestId : String = ""// 银行卡code
    

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
        // 输入卡信息
        createInputStep1()
        
        // 手机验证
        createInputStep2()
    }
    
    // 输入卡信息
    func createInputStep1() -> Void {
        self.writeStep1.isHidden = false
        self.writeStep1.backgroundColor = UIColor.white
        self.view.addSubview(self.writeStep1)
        self.writeStep1.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom)
            make.left.right.equalTo(self.view)
            make.height.equalTo(186 * HEIGHT_SCALE)
        }
        
        let lineView1 : UIView = UIView()
        lineView1.backgroundColor = LINE_COLOR1
        self.writeStep1.addSubview(lineView1)
        lineView1.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.writeStep1)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        // 输入银行卡号
        self.bankCardNum.placeholder = "请输入银行卡卡号"
        self.bankCardNum.keyboardType = UIKeyboardType.numberPad
        self.bankCardNum.textColor = UIColor().colorWithHexString(hex: "333333")
        self.bankCardNum.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.bankCardNum.delegate = self
        self.writeStep1.addSubview(self.bankCardNum)
        self.bankCardNum.snp.makeConstraints { (make) in
            make.top.equalTo(lineView1.snp.bottom)
            make.height.equalTo(43 * HEIGHT_SCALE)
            make.left.equalTo(self.writeStep1.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.writeStep1.snp.right).offset(-10 * WIDTH_SCALE)
        }
        
        let lineView2 : UIView = UIView()
        lineView2.backgroundColor = LINE_COLOR1
        self.writeStep1.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.writeStep1)
            make.top.equalTo(self.bankCardNum.snp.bottom)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        // 选择银行
        let imageView : UIImageView = UIImageView()
        imageView.contentMode = UIViewContentMode.center
        imageView.image = UIImage (named: "downArrow.PNG")
        self.writeStep1.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(lineView2.snp.bottom)
            make.right.equalTo(self.writeStep1.snp.right).offset(-10 * WIDTH_SCALE)
            make.width.equalTo(30 * WIDTH_SCALE)
            make.height.equalTo(43 * HEIGHT_SCALE)
        }
        
        self.bankSelect.setTitle("请选择银行", for: UIControlState.normal)
        self.bankSelect.setTitleColor(LINE_COLOR1, for: UIControlState.normal)
        self.bankSelect.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        self.bankSelect.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13 * WIDTH_SCALE)
        self.bankSelect.addTarget(self, action: #selector(bankClick), for: UIControlEvents.touchUpInside)
        self.writeStep1.addSubview(self.bankSelect)
        self.bankSelect.snp.makeConstraints { (make) in
            make.top.equalTo(lineView2.snp.bottom)
            make.height.equalTo(43 * HEIGHT_SCALE)
            make.left.equalTo(self.writeStep1.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.writeStep1.snp.right).offset(-10 * WIDTH_SCALE)
        }
        
        let lineView3 : UIView = UIView()
        lineView3.backgroundColor = LINE_COLOR1
        self.writeStep1.addSubview(lineView3)
        lineView3.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.writeStep1)
            make.top.equalTo(self.bankSelect.snp.bottom)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        let view : UIView = UIView()
        view.backgroundColor = MAIN_COLOR
        self.writeStep1.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.writeStep1)
            make.top.equalTo(lineView3.snp.bottom)
            make.height.equalTo(8 * HEIGHT_SCALE)
        }
        
        let lineView4 : UIView = UIView()
        lineView4.backgroundColor = LINE_COLOR1
        self.writeStep1.addSubview(lineView4)
        lineView4.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.writeStep1)
            make.top.equalTo(view.snp.bottom)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        // 持卡人姓名
        self.bankCardName.placeholder = "请输入持卡人姓名"
        self.bankCardName.textColor = UIColor().colorWithHexString(hex: "333333")
        self.bankCardName.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.bankCardName.delegate = self
        self.writeStep1.addSubview(self.bankCardName)
        self.bankCardName.snp.makeConstraints { (make) in
            make.top.equalTo(lineView4.snp.bottom)
            make.height.equalTo(43 * HEIGHT_SCALE)
            make.left.equalTo(self.writeStep1.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.writeStep1.snp.right).offset(-10 * WIDTH_SCALE)
        }
        
        let lineView5 : UIView = UIView()
        lineView5.backgroundColor = LINE_COLOR1
        self.writeStep1.addSubview(lineView5)
        lineView5.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.writeStep1)
            make.top.equalTo(self.bankCardName.snp.bottom)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        // 身份证持卡人
        self.personCard.placeholder = "请输入持卡人身份证号码"
        self.personCard.textColor = UIColor().colorWithHexString(hex: "333333")
        self.personCard.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.personCard.delegate = self
        self.writeStep1.addSubview(self.personCard)
        self.personCard.snp.makeConstraints { (make) in
            make.top.equalTo(lineView5.snp.bottom)
            make.height.equalTo(43 * HEIGHT_SCALE)
            make.left.equalTo(self.writeStep1.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.writeStep1.snp.right).offset(-10 * WIDTH_SCALE)
        }
        
        let lineView6 : UIView = UIView()
        lineView6.backgroundColor = LINE_COLOR1
        self.writeStep1.addSubview(lineView6)
        lineView6.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self.writeStep1)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
    }
    
    
    // 手机验证
    func createInputStep2() -> Void {
        self.writeStep2.isHidden = true
        self.writeStep2.backgroundColor = UIColor.white
        self.view.addSubview(self.writeStep2)
        self.writeStep2.snp.makeConstraints { (make) in
            make.right.left.equalTo(self.view)
            make.top.equalTo(self.headerView.snp.bottom)
            make.height.equalTo(88 * HEIGHT_SCALE)
        }
        
        let lineView1 : UIView = UIView()
        lineView1.backgroundColor = LINE_COLOR1
        self.writeStep2.addSubview(lineView1)
        lineView1.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.writeStep2)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        // 手机号码
        let phoneLabel : UILabel = UILabel()
        phoneLabel.textColor = UIColor().colorWithHexString(hex: "333333")
        phoneLabel.font = UIFont.systemFont(ofSize: 13 * HEIGHT_SCALE)
        phoneLabel.text = USERINFO?.mobile
        self.writeStep2.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lineView1.snp.bottom)
            make.height.equalTo(43 * HEIGHT_SCALE)
            make.left.equalTo(self.writeStep2.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.writeStep2.snp.right).offset(-10 * WIDTH_SCALE)
        }

        let lineView2 : UIView = UIView()
        lineView2.backgroundColor = LINE_COLOR1
        self.writeStep2.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.top.equalTo(phoneLabel.snp.bottom)
            make.left.right.equalTo(self.writeStep2)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        // 获取验证码按钮
        self.verifiBtn.setTitle("获取验证码", for: UIControlState.normal)
        self.verifiBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.verifiBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.verifiBtn.backgroundColor = NAVIGATION_COLOR
        self.verifiBtn.layer.cornerRadius = 1.5 * WIDTH_SCALE
        self.verifiBtn.layer.masksToBounds = true
        self.verifiBtn.addTarget(self, action: #selector(verifiClick), for: UIControlEvents.touchUpInside)
        self.writeStep2.addSubview(self.verifiBtn)
        self.verifiBtn.snp.makeConstraints { (make) in
            make.top.equalTo(lineView2.snp.bottom).offset(5 * HEIGHT_SCALE)
            make.right.equalTo(self.writeStep2.snp.right).offset(-10 * WIDTH_SCALE)
            make.width.equalTo(100 * WIDTH_SCALE)
            make.height.equalTo(32 * HEIGHT_SCALE)
        }
        
        // 输入验证码
        self.verifiField.placeholder = "请输入验证码"
        self.verifiField.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.verifiField.textColor = UIColor().colorWithHexString(hex: "333333")
        self.writeStep2.addSubview(self.verifiField)
        self.verifiField.snp.makeConstraints { (make) in
            make.top.equalTo(lineView2.snp.bottom)
            make.left.equalTo(self.writeStep2.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.verifiBtn.snp.left)
            make.height.equalTo(42 * HEIGHT_SCALE)
        }

        let lineView3 : UIView = UIView()
        lineView3.backgroundColor = LINE_COLOR1
        self.writeStep2.addSubview(lineView3)
        lineView3.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self.writeStep2)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
    }
    
    
    // 创建底部
    func createFooterView() -> Void {
        self.view.addSubview(self.footerView)
        self.footerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.writeStep1.snp.bottom)
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
    
    
    // MARK: UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.bankCardNum {
            if self.bankCardNum.text == "" {
                SVProgressHUD.showError(withStatus: "请输入正确的银行卡号")
                return
            }
            requestVerifyBankCardNo(cardNo: self.bankCardNum.text!)
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
            weakSelf?.shadeClick()
        }
        self.sheetView.bankPickBlock = {(model) in
            weakSelf?.bankSelected = model
            weakSelf?.bankSelect.setTitle(model.bankName as String, for: UIControlState.normal)
            weakSelf?.bankSelect.setTitleColor(UIColor().colorWithHexString(hex: "333333"), for: UIControlState.normal)
        }
    }

    
    // 选择银行的点击事件
    func bankClick() -> Void {
        self.view.endEditing(true)
        self.shadeBtn.isHidden = false
        if self.bankArray == nil {
            // 获取银行列表
            requestBankNameList()
        } else {
            UIView.animate(withDuration: 0.3) {
                self.sheetView.frame = CGRect (x:0 , y: SCREEN_HEIGHT - 64 - 200 * HEIGHT_SCALE, width: SCREEN_WIDTH, height: 200 * HEIGHT_SCALE)
            }
        }
    }
    
    
    // 下一步的点击事件
    func nextClick() -> Void {
        if BankCardStep.BankCardStep1 == self.currentStep {
//            if self.bankCardNum.text == "" {
//                SVProgressHUD.showError(withStatus: "请输入正确的银行卡号")
//                return
//            }
//
//            if self.bankSelected == nil {
//                SVProgressHUD.showError(withStatus: "请选中银行")
//                return
//            }
//            
//            if self.bankCardName.text == "" {
//                SVProgressHUD.showError(withStatus: "请输入正确的持卡人姓名")
//                return
//            }
//
//            if self.personCard.text == "" || !XNumRule().cardRule(cardNum: self.personCard.text!) {
//                SVProgressHUD.showError(withStatus: "请输入正确的身份证号码")
//                return
//            }
            
            self.currentStep = BankCardStep.BankCardStep2
        } else if BankCardStep.BankCardStep2 == self.currentStep {
            if self.verifiField.text == "" {
                SVProgressHUD.showError(withStatus: "请输入正确的验证码")
                return
            }
            self.currentStep = BankCardStep.BankCardStep3
        }
        
        // 界面改变
        changeBankViewStyle()
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
    
    
    
    // 改变页面的样式
    func changeBankViewStyle() -> Void {
        if BankCardStep.BankCardStep1 == self.currentStep {
            self.footerView.snp.removeConstraints()
            self.stepImageView.image = UIImage (named: "bankCard1.png")
            self.step2Label.textColor = LINE_COLOR3
            self.step3Label.textColor = LINE_COLOR3
            self.promptLabel.text = "为保证账户资金安全，只可认证用户本人的银行卡。"
            self.writeStep1.isHidden = false
            self.writeStep2.isHidden = true
            self.footerView.isHidden = false
            self.footerView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.writeStep1.snp.bottom)
                make.left.right.equalTo(self.view)
                make.height.equalTo(100 * HEIGHT_SCALE)
            })
        } else if BankCardStep.BankCardStep2 == self.currentStep {
            self.footerView.snp.removeConstraints()
            self.stepImageView.image = UIImage (named: "bankCard2.png")
            self.step2Label.textColor = NAVIGATION_COLOR
            self.promptLabel.text = "银行预留手机号码是办理银行卡时所填写的手机号码。没有预留、忘记手机号码或者已停用，请联系银行客服更新处理。"
            self.writeStep1.isHidden = true
            self.writeStep2.isHidden = false
            self.footerView.isHidden = false
            self.footerView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.writeStep2.snp.bottom)
                make.left.right.equalTo(self.view)
                make.height.equalTo(100 * HEIGHT_SCALE)
            })
        } else if BankCardStep.BankCardStep3 == self.currentStep {
            self.stepImageView.image = UIImage (named: "bankCard3.png")
            self.step2Label.textColor = NAVIGATION_COLOR
            self.step3Label.textColor = NAVIGATION_COLOR
            self.writeStep1.isHidden = true
            self.writeStep2.isHidden = true
            self.footerView.isHidden = true
        }
    }

    
    // 获取验证码的点击事件
    func verifiClick() -> Void {
        if USERINFO?.mobile?.count != 11 {
            SVProgressHUD.showError(withStatus: "手机号码错误")
            return
        }
        
        self.view.endEditing(true)
        
        // 获取验证码
        requestPhoneVerifyCode()
        
        // 获取银行卡认证的Code
        requestSendBindCardVerifyCode()
    }
    
    
    // 验证码定时器
    func updateTime() -> Void {
        self.second -= 1;
        if self.second > 0 {
            self.verifiBtn.setTitle(String (format: "%i'后重新获取", second), for: UIControlState.normal)
        } else {
            countdownTimer?.invalidate()
            countdownTimer = nil
            self.verifiBtn .setTitle("重发验证码", for: UIControlState.normal)
            self.verifiBtn.isEnabled = true
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
    
    override func comeBack() {
        if BankCardStep.BankCardStep1 == self.currentStep || BankCardStep.BankCardStep3 == self.currentStep {
            super.comeBack()
        } else if BankCardStep.BankCardStep2 == self.currentStep {
            self.currentStep = BankCardStep.BankCardStep1
        } else if BankCardStep.BankCardStep3 == self.currentStep {
            self.currentStep = BankCardStep.BankCardStep2
        }
        // 改变页面的样式
        changeBankViewStyle()
    }
    
    
    
    // 获取银行列表
    func requestBankNameList() -> Void {
        UserCenterService.userInstance.requestBankListData(success: { (responseObject) in
            let tempArray : NSArray = responseObject as! NSArray
            // 银行名称列表
            self.bankArray = BankNameModel.objectArrayWithKeyValuesArray(array: tempArray) as? [BankNameModel]
            self.sheetView.bankArray = self.bankArray!
            
            // 显示View
            UIView.animate(withDuration: 0.3) {
                self.sheetView.frame = CGRect (x:0 , y: SCREEN_HEIGHT - 64 - 200 * HEIGHT_SCALE, width: SCREEN_WIDTH, height: 200 * HEIGHT_SCALE)
            }
        }) { (errorInfo) in
        }
    }
    
    
    // 银行卡号的验证
    func requestVerifyBankCardNo(cardNo : String) -> Void {
        UserCenterService.userInstance.requestBankCardVerify(cardNo: cardNo, success: { (responseObject) in
            let tempDict : NSDictionary = responseObject as! NSDictionary
            let bankModel : BankNameModel = BankNameModel()
            bankModel.bankCode = tempDict["bankcode"] as! String
            bankModel.bankName = tempDict["bankname"] as! String
        }) { (errorInfo) in
        }
    }
    
    
    // 获取验证码
    func requestPhoneVerifyCode() -> Void {
        PublicService.publicServiceInstance.requestVerificationCode(mobile: (USERINFO?.mobile)!, code: self.graphicCode, success: { (responseObject) in
            let resultDict = responseObject as! NSDictionary
            if resultDict["code"] as! String == "0" {
                SVProgressHUD .showSuccess(withStatus: "验证码已发送")
                self.countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
                self.verifiBtn.isEnabled = false
                self.second = 60;
            } else if resultDict["code"] as! String == "-69" {
                let dataDict : NSDictionary = resultDict["data"] as! NSDictionary
                let graphicView : GraphicView = GraphicView()
                graphicView.showInRect(rect: CGRect (x: 15 * WIDTH_SCALE, y: (SCREEN_HEIGHT - 180 * HEIGHT_SCALE) / 2, width: SCREEN_WIDTH - 30 * WIDTH_SCALE, height: 180 * HEIGHT_SCALE))
                graphicView.imageCode = dataDict["captchaCode"] as? String;
                
                graphicView.submitClickBlock = { (code : String) in
                    self.graphicCode = code
                    self.requestPhoneVerifyCode()
                }
            }
        }) { (error) in
        }
    }
    
    
    // 获取银行卡认证的Code
    func requestSendBindCardVerifyCode() -> Void {
        UserCenterService.userInstance.requestBankCardRequestId(mobilePhone: (USERINFO?.mobile)!, cardNo:self.bankCardNum.text! , name: self.bankCardName.text!, idCard: self.personCard.text!, success: { (responseObject) in
            let resultDict = responseObject as! NSDictionary
            self.requestId = resultDict["requestId"] as! String
        }) { (error) in
        }
    }
    
    
    // 银行卡认证
    func requestCompleteBankCardVerify() -> Void {
        UserCenterService.userInstance.requestCompeleBankCardVerify(verifyCode: self.verifiField.text!, mobilePhone: (USERINFO?.mobile)!, requestId: self.requestId, bankName: (self.bankSelected?.bankName)!, cardNo: self.bankCardNum.text!, name: self.bankCardName.text!, idCard: self.personCard.text!, success: { (responseObject) in
            let userInfo : UserModel = USERINFO!
            userInfo.bankCard = self.bankCardNum.text!
            USERDEFAULT.saveCustomObject(customObject: userInfo, key: "userInfo")
            self.navigationController?.popToRootViewController(animated: true)
        }) { (error) in
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
