//
//  ConsultAlertView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/9.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias ConsultBlock = (LargeInfoModel) -> Void
class ConsultAlertView: BasicView, UITextFieldDelegate {
    var loanView : UIView = UIView()// 弹框显示View
    var headerView : UIView = UIView()// 头部View
    var infoView : UIView = UIView()// 中间休息View
    var footerView : UIView = UIView()// 底部View
    var headerImage : UIImageView = UIImageView()// 头像
    var promptLabel : UILabel = UILabel()// 提示信息
    var amountField : UITextField = UITextField()// 金额
    var termField : UITextField = UITextField()// 申请期限
    var nameField : UITextField = UITextField()// 姓名
    var cardField : UITextField = UITextField()// 身份证
    var consultBtn : UIButton = UIButton()// 立即咨询
    var largeInfoModel : LargeInfoModel = LargeInfoModel()// 头部信息Model
    var consultBlock : ConsultBlock?// 立即咨询回调
    
    
    // 创建UI
    override func createUI() {
        super.createUI()
        
        self.backgroundColor = UIColor.init(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 0.9)
        
        self.loanView.backgroundColor = UIColor.white
        self.loanView.layer.cornerRadius = 10 * WIDTH_SCALE
        self.loanView.layer.masksToBounds = true
        self.addSubview(self.loanView)
        self.loanView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(30 * WIDTH_SCALE)
            make.right.equalTo(self.snp.right).offset(-30 * WIDTH_SCALE)
            make.centerY.equalTo(self)
            make.height.equalTo(400 * HEIGHT_SCALE)
        }
        
        // 创建头部View
        createHeaderUI()
        
        // 创建贷款信息View
        createLoanUI()
        
        // 创建底部View
        createBottomUI()
    }
    
    
    // 创建头部View
    func createHeaderUI() -> Void {
        self.loanView.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.loanView)
            make.height.equalTo(105 * HEIGHT_SCALE)
        }
        
        
        // 取消按钮
        let closeBtn : UIButton = UIButton()
        closeBtn.setImage(UIImage (named: "consultClose"), for: UIControlState.normal)
        closeBtn.addTarget(self, action: #selector(closeClick), for: UIControlEvents.touchUpInside)
        self.headerView.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { (make) in
            make.top.left.equalTo(self.headerView)
            make.width.equalTo(50 * WIDTH_SCALE)
            make.height.equalTo(50 * WIDTH_SCALE)
        }
        
        // 头像
        self.headerImage.backgroundColor = UIColor.purple
        self.headerImage.layer.cornerRadius = 60 * WIDTH_SCALE / 2
        self.headerImage.layer.masksToBounds = true
        self.headerView.addSubview(self.headerImage)
        self.headerImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.headerView)
            make.width.equalTo(60 * WIDTH_SCALE)
            make.height.equalTo(60 * WIDTH_SCALE)
            make.top.equalTo(self.headerView.snp.top).offset(10 * HEIGHT_SCALE)
        }
        
        // 提示信息
        self.promptLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.promptLabel.textColor = TEXT_BLACK_COLOR
        self.promptLabel.textAlignment = .center
        self.headerView.addSubview(self.promptLabel)
        self.promptLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.headerView)
            make.bottom.equalTo(self.headerView.snp.bottom).offset(-10 * HEIGHT_SCALE)
        }
    }
    
    // 创建贷款信息View
    func createLoanUI() -> Void {
        self.loanView.addSubview(self.infoView)
        self.infoView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom)
            make.left.right.equalTo(self.loanView)
            make.height.equalTo(200 * HEIGHT_SCALE)
        }
        
        // 姓名
        let nameView : UIView = UIView()
        self.infoView.addSubview(nameView)
        nameView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.infoView)
            make.height.equalTo(50 * HEIGHT_SCALE)
        }
        
        let nameLabel : UILabel = UILabel()
        nameLabel.text = "姓名"
        nameLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        nameLabel.textColor = TEXT_SECOND_COLOR
        nameView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(nameView)
            make.left.equalTo(nameView.snp.left).offset(15 * WIDTH_SCALE)
            make.width.equalTo(110 * WIDTH_SCALE)
        }
        
        self.nameField.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.nameField.placeholder = "请输入"
        self.nameField.textAlignment = .right
        self.nameField.delegate = self
        self.nameField.textColor = TEXT_SECOND_COLOR
        nameView.addSubview(self.nameField)
        self.nameField.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(nameView)
            make.left.equalTo(nameLabel.snp.right).offset(15 * WIDTH_SCALE)
            make.right.equalTo(nameView.snp.right).offset(-15 * WIDTH_SCALE)
        }
        
        let nameLine : UIView = UIView()
        nameLine.backgroundColor = LINE_COLOR2
        nameView.addSubview(nameLine)
        nameLine.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(nameView)
            make.left.equalTo(nameView.snp.left).offset(15 * WIDTH_SCALE)
            make.height.equalTo(0.5 * HEIGHT_SCALE)
        }
        
        // 身份证
        let cardView : UIView = UIView()
        self.infoView.addSubview(cardView)
        cardView.snp.makeConstraints { (make) in
            make.top.equalTo(nameView.snp.bottom)
            make.left.right.equalTo(self.infoView)
            make.height.equalTo(50 * HEIGHT_SCALE)
        }
        
        let cardLabel : UILabel = UILabel()
        cardLabel.text = "身份证"
        cardLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        cardLabel.textColor = TEXT_SECOND_COLOR
        cardView.addSubview(cardLabel)
        cardLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(cardView)
            make.left.equalTo(cardView.snp.left).offset(15 * WIDTH_SCALE)
            make.width.equalTo(110 * WIDTH_SCALE)
        }
        
        self.cardField.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.cardField.placeholder = "请输入"
        self.cardField.textAlignment = .right
        self.cardField.delegate = self
        self.cardField.textColor = TEXT_SECOND_COLOR
        cardView.addSubview(self.cardField)
        self.cardField.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(cardView)
            make.left.equalTo(cardLabel.snp.right).offset(15 * WIDTH_SCALE)
            make.right.equalTo(cardView.snp.right).offset(-15 * WIDTH_SCALE)
        }
        
        let cardLine : UIView = UIView()
        cardLine.backgroundColor = LINE_COLOR2
        cardView.addSubview(cardLine)
        cardLine.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(cardView)
            make.left.equalTo(cardView.snp.left).offset(5 * WIDTH_SCALE)
            make.height.equalTo(0.5 * HEIGHT_SCALE)
        }
        
        // 金额
        let amountView : UIView = UIView()
        self.infoView.addSubview(amountView)
        amountView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.infoView)
            make.height.equalTo(50 * HEIGHT_SCALE)
            make.top.equalTo(cardView.snp.bottom)
        }
        
        let amountLabel : UILabel = UILabel()
        amountLabel.text = "申请金额（元）"
        amountLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        amountLabel.textColor = TEXT_SECOND_COLOR
        amountView.addSubview(amountLabel)
        amountLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(amountView)
            make.left.equalTo(amountView.snp.left).offset(15 * WIDTH_SCALE)
            make.width.equalTo(110 * WIDTH_SCALE)
        }
        
        self.amountField.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.amountField.placeholder = "请输入"
        self.amountField.text = "50000"
        self.amountField.keyboardType = .numberPad
        self.amountField.textAlignment = .right
        self.amountField.delegate = self
        self.amountField.textColor = TEXT_SECOND_COLOR
        amountView.addSubview(self.amountField)
        self.amountField.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(amountView)
            make.left.equalTo(amountLabel.snp.right).offset(15 * WIDTH_SCALE)
            make.right.equalTo(amountView.snp.right).offset(-15 * WIDTH_SCALE)
        }
        
        let amountLine : UIView = UIView()
        amountLine.backgroundColor = LINE_COLOR2
        amountView.addSubview(amountLine)
        amountLine.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(amountView)
            make.left.equalTo(amountView.snp.left).offset(15 * WIDTH_SCALE)
            make.height.equalTo(0.5 * HEIGHT_SCALE)
        }
        
        // 申请期限
        let termView : UIView = UIView()
        self.infoView.addSubview(termView)
        termView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.infoView)
            make.top.equalTo(amountView.snp.bottom)
            make.height.equalTo(50 * HEIGHT_SCALE)
        }
        
        let termLabel : UILabel = UILabel()
        termLabel.text = "申请期限（月）"
        termLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        termLabel.textColor = TEXT_SECOND_COLOR
        termView.addSubview(termLabel)
        termLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(termView)
            make.left.equalTo(termView.snp.left).offset(15 * WIDTH_SCALE)
            make.width.equalTo(110 * WIDTH_SCALE)
        }
        
        self.termField.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.termField.placeholder = "请输入"
        self.termField.text = "12"
        self.termField.keyboardType = .numberPad
        self.termField.textAlignment = .right
        self.termField.delegate = self
        self.termField.textColor = TEXT_SECOND_COLOR
        termView.addSubview(self.termField)
        self.termField.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(termView)
            make.left.equalTo(termLabel.snp.right).offset(15 * WIDTH_SCALE)
            make.right.equalTo(termView.snp.right).offset(-15 * WIDTH_SCALE)
        }
        
        let termLine : UIView = UIView()
        termLine.backgroundColor = LINE_COLOR2
        termView.addSubview(termLine)
        termLine.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(termView)
            make.left.equalTo(termView.snp.left).offset(15 * WIDTH_SCALE)
            make.height.equalTo(0.5 * HEIGHT_SCALE)
        }
    }
    
    
    // 创建底部View
    func createBottomUI() -> Void {
        self.loanView.addSubview(self.footerView)
        self.footerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.infoView.snp.bottom)
            make.left.right.equalTo(self.loanView)
            make.height.equalTo(95 * HEIGHT_SCALE)
        }
        
        let textLabel : UILabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        textLabel.textAlignment = .center
        textLabel.text = "戳这里，即可通过转接电话联系我～"
        textLabel.textColor = LINE_COLOR3
        self.footerView.addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.footerView)
            make.top.equalTo(15 * HEIGHT_SCALE)
        }
        
        self.consultBtn.setTitle("立即咨询", for: UIControlState.normal)
        self.consultBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17 * WIDTH_SCALE)
        self.consultBtn.setImage(UIImage (named: "phoneConsult"), for: UIControlState.normal)
        self.consultBtn.setImage(UIImage (named: "phoneConsult"), for: UIControlState.highlighted)
        self.consultBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10 * WIDTH_SCALE, 0, 0);
        self.consultBtn.addTarget(self, action: #selector(consultClick), for: UIControlEvents.touchUpInside)
        self.consultBtn.backgroundColor = NAVIGATION_COLOR
        self.consultBtn.layer.cornerRadius = 3 * WIDTH_SCALE
        self.consultBtn.layer.masksToBounds = true
        self.footerView.addSubview(self.consultBtn)
        self.consultBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.footerView.snp.left).offset(20 * WIDTH_SCALE)
            make.right.equalTo(self.footerView.snp.right).offset(-20 * WIDTH_SCALE)
            make.bottom.equalTo(self.footerView.snp.bottom).offset(-15 * HEIGHT_SCALE)
            make.height.equalTo(40 * HEIGHT_SCALE)
        }
        
    }
    
    
    //MARK: UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.amountField {
            let amount : Int = Int(textField.text!)!
            if amount < 10000 || amount > 10000000 || amount % 10000 != 0 {
                SVProgressHUD.showError(withStatus: "申请金额需在1万元至1000万元，且为1万元的整数倍")
                textField.text = "50000"
            }
        } else if textField == self.termField {
            let term : Int = Int(textField.text!)!
            if term < 1 {
                SVProgressHUD.showError(withStatus: "申请期限大于等于1个月")
                textField.text = "12"
            }
        } else if textField == self.nameField {
            if self.largeInfoModel.verify != "1" {
                if textField.text?.count == 0 {
                    SVProgressHUD.showError(withStatus: "请输入姓名")
                } else {
                    // 上传服务器
                    requestUserName(attributeName: textField.text!, value: "name")
                }
            }
        } else if textField == self.cardField {
            if self.largeInfoModel.verify != "1" {
                if !XNumRule().cardRule(cardNum: textField.text!) {
                    SVProgressHUD.showError(withStatus: "请输入正确的身份证号码")
                } else {
                    // 上传服务器
                    requestUserIdCard(attributeName: textField.text!, value: "IdCard")
                }
            }
        }
        
        self.largeInfoModel.amountText = self.amountField.text
        self.largeInfoModel.termText = self.termField.text
        if self.largeInfoModel.verify != "1" {
            self.largeInfoModel.nameText = self.nameField.text
            self.largeInfoModel.cardText = self.cardField.text
        }
        
        // 改变立即咨询的状态
        updateConsultBtnState()
    }
    
    
    // 更新数据
    func updateAlertViewData(largeInfo : LargeInfoModel) -> Void {
        self.largeInfoModel = largeInfo
        // 头像
        self.headerImage.kf.setImage(with: URL (string: largeInfo.url), placeholder: UIImage (named: "loanDefault.png"), options: nil, progressBlock: nil, completionHandler: nil)
        
        // 提示信息
        let promptText : String = String (format: "%@：请确认你的借款需求哦", largeInfo.nameText!)
        let termStr : NSMutableAttributedString = NSMutableAttributedString(string: promptText)
        let termFirstDict = [NSForegroundColorAttributeName : LINE_COLOR3]
        termStr.addAttributes(termFirstDict, range: NSMakeRange(0, (largeInfo.nameText?.count)!))
        let termSecondDict = [NSForegroundColorAttributeName : TEXT_SECOND_COLOR]
        termStr.addAttributes(termSecondDict, range: NSMakeRange((largeInfo.nameText?.count)!, 11))
        self.promptLabel.attributedText = termStr
        
        // 姓名 身份证
        if largeInfo.verify == "1" {
            self.nameField.textColor = LINE_COLOR3
            self.cardField.textColor = LINE_COLOR3
            self.nameField.isEnabled = false
            self.cardField.isEnabled = false
        } else {
            self.nameField.textColor = TEXT_SECOND_COLOR
            self.cardField.textColor = TEXT_SECOND_COLOR
        }
        self.nameField.text = largeInfo.nameText
        self.cardField.text = largeInfo.cardText
        
        // 金额
        self.amountField.text = largeInfo.amountText
        
        // 申请期限
        self.termField.text = largeInfo.termText
        
        // 改变立即咨询的状态
        updateConsultBtnState()
    }
    
    
    // 改变立即咨询的状态
    func updateConsultBtnState() -> Void {
        if (self.amountField.text?.isEmpty)! && (self.termField.text?.isEmpty)! && (self.nameField.text?.isEmpty)! && (self.cardField.text?.isEmpty)! {
            self.consultBtn.backgroundColor = UIColor().colorWithHexString(hex: "DAEFED")
            self.consultBtn.isEnabled = false
        } else {
            self.consultBtn.backgroundColor = NAVIGATION_COLOR
            self.consultBtn.isEnabled = true
        }
    }
    
    
    // 取消点击事件
    func closeClick() -> Void {
        self.isHidden = true
    }
    
    
    // 立即咨询的点击事件
    func consultClick() -> Void {
        if self.consultBlock != nil {
            self.consultBlock!(self.largeInfoModel)
        }
    }
    
    
    // 提交身份证信息
    func requestUserIdCard(attributeName : String, value : String) -> Void {
        HomePageService.homeInstance.requestUserInfo(attributeName: attributeName, value: value, success: { (responseObject) in
            let tempDict : NSDictionary = responseObject as! NSDictionary
            let verify : String = tempDict.stringForKey(key: "verify") as String
            let userModel : UserModel = USERINFO!
            userModel.verify = Int(verify)
            userModel.idCard = self.cardField.text
            USERDEFAULT.saveCustomObject(customObject: userModel, key: "userInfo")
        }) { (errorInfo) in
        }
    }
    
    
    // 提交姓名信息
    func requestUserName(attributeName : String, value : String) -> Void {
        HomePageService.homeInstance.requestUserInfo(attributeName: attributeName, value: value, success: { (responseObject) in
            USERINFO?.name = self.nameField.text
        }) { (errorInfo) in
        }
    }
}
