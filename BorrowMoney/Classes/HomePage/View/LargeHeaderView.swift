//
//  LargeHeaderView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/3.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias LargeChangeCity = () -> Void
typealias LargeSubmitBlock = (NSDictionary) -> Void
class LargeHeaderView: UICollectionReusableView, UITextFieldDelegate {
    var topView : UIView = UIView()// 顶部View
    var midView : UIView = UIView()// 中间View
    var bottomView : UIView = UIView()// 底部View
    var cityText : UIButton = UIButton()// 城市信息
    var changeBtn : UIButton = UIButton()// 更换城市
    var largeChangeCity : LargeChangeCity?// 更换城市的回调
    var largeSubmitBlock : LargeSubmitBlock?// 提交申请回调
    var amountField : UITextField = UITextField()// 金额
    var termField : UITextField = UITextField()// 申请期限
    var nameField : UITextField = UITextField()// 姓名
    var cardField : UITextField = UITextField()// 身份证
    var submitBtn : UIButton = UIButton()// 提交申请
    var promptLabel : UILabel = UILabel()// 提示信息
    var largeInfoModel : LargeInfoModel = LargeInfoModel()// 头部信息Model
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 创建UI
        createUI()
    }
    
    
    // 创建UI
    func createUI() -> Void {
        // 创建顶部View
        createTopView()
        
        // 创建中间View
        createMidView()
        
        // 创建底部View
        createBottomView()
    }
    
    
    // 创建顶部View
    func createTopView() -> Void {
        self.topView.backgroundColor = UIColor.white
        self.addSubview(self.topView)
        self.topView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(105 * HEIGHT_SCALE)
        }
        
        // 右边图片
        let backImage : UIImageView = UIImageView()
        backImage.image = UIImage (named: "largeLoanBg")
        self.addSubview(backImage)
        backImage.snp.makeConstraints { (make) in
            make.right.centerY.equalTo(self.topView)
            make.height.equalTo(75 * HEIGHT_SCALE)
            make.left.equalTo(self.topView.snp.centerX)
        }
        
        
        // 递交
        let textLabel1 : UILabel = UILabel()
        textLabel1.text = "递交"
        textLabel1.font = UIFont.systemFont(ofSize: 19 * WIDTH_SCALE)
        textLabel1.textColor = TEXT_BLACK_COLOR
        self.topView.addSubview(textLabel1)
        textLabel1.snp.makeConstraints { (make) in
            make.left.equalTo(self.topView.snp.left).offset(18 * WIDTH_SCALE)
            make.top.equalTo(self.topView.snp.top).offset(18 * HEIGHT_SCALE)
        }

        // 大额贷款申请
        let textLabel2 : UILabel = UILabel()
        textLabel2.text = "大额贷款申请"
        textLabel2.font = UIFont.systemFont(ofSize: 19 * WIDTH_SCALE)
        textLabel2.textColor = UIColor().colorWithHexString(hex: "FF9000")
        self.topView.addSubview(textLabel2)
        textLabel2.snp.makeConstraints { (make) in
            make.left.equalTo(textLabel1.snp.right)
            make.top.equalTo(textLabel1)
        }
        
        // 预约专属信贷经理服务
        let textLabel3 : UILabel = UILabel()
        textLabel3.text = "预约专属信贷经理服务"
        textLabel3.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        textLabel3.textColor = LINE_COLOR3
        self.topView.addSubview(textLabel3)
        textLabel3.snp.makeConstraints { (make) in
            make.left.equalTo(self.topView.snp.left).offset(18 * WIDTH_SCALE)
            make.top.equalTo(textLabel2.snp.bottom).offset(5 * HEIGHT_SCALE)
        }
        
        
         if (BASICINFO?.cityName?.isEmpty)! {
            self.cityText.setTitle("", for: UIControlState.normal)
            self.cityText.setImage(UIImage (named: ""), for: UIControlState.normal)
        } else {
            self.cityText.setTitle(BASICINFO?.cityName, for: UIControlState.normal)
            self.cityText.setImage(UIImage (named: "cityPosition"), for: UIControlState.normal)
        }
        // 城市信息
        self.cityText.titleLabel?.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.cityText.setTitleColor(LINE_COLOR3, for: UIControlState.normal)
        self.cityText.imageEdgeInsets = UIEdgeInsetsMake(0, -3 * WIDTH_SCALE, 0, 0)
        self.topView.addSubview(self.cityText)
        self.cityText.snp.makeConstraints { (make) in
            make.left.equalTo(self.topView.snp.left).offset(18 * WIDTH_SCALE)
            make.top.equalTo(textLabel3.snp.bottom).offset(8 * HEIGHT_SCALE)
        }
        
        // 更换城市
        self.changeBtn.setTitle("更换城市", for: UIControlState.normal)
        self.changeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.changeBtn.setTitleColor(UIColor().colorWithHexString(hex: "009CFF"), for: UIControlState.normal)
        self.changeBtn.addTarget(self, action: #selector(changeClick), for: UIControlEvents.touchUpInside)
        self.topView.addSubview(self.changeBtn)
        self.changeBtn.snp.makeConstraints { (make) in
            if (BASICINFO?.cityName?.isEmpty)! {
                make.left.equalTo(self.topView.snp.left).offset(18 * WIDTH_SCALE)
            } else {
                make.left.equalTo(self.cityText.snp.right).offset(8 * WIDTH_SCALE)
            }
            make.top.equalTo(textLabel3.snp.bottom).offset(3 * HEIGHT_SCALE)
        }
        

        let lineView : UIView = UIView()
        lineView.backgroundColor = UIColor().colorWithHexString(hex: "009CFF")
        self.topView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.changeBtn)
            make.top.equalTo(self.changeBtn.snp.centerY).offset(5 * HEIGHT_SCALE)
            make.height.equalTo(0.5 * HEIGHT_SCALE)
        }
        
        
        let view : UIView = UIView()
        view.backgroundColor = UIColor().colorWithHexString(hex: "f9f9f9")
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.init(width: 0, height: 4 * HEIGHT_SCALE);
        view.layer.shadowColor = UIColor().colorWithHexString(hex: "f9f9f9").cgColor
        view.layer.shadowRadius = 4 * WIDTH_SCALE
        self.topView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.topView)
            make.height.equalTo(2 * HEIGHT_SCALE)
            make.bottom.equalTo(self.topView.snp.bottom).offset(-4 * HEIGHT_SCALE)
        }
    }
    
    
    // 创建中间View
    func createMidView() -> Void {
        self.midView.backgroundColor = UIColor.white
        self.addSubview(self.midView)
        self.midView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.topView.snp.bottom)
            make.height.equalTo(210 * HEIGHT_SCALE)
        }
        
        // 金额
        let amountView : UIView = UIView()
        self.midView.addSubview(amountView)
        amountView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.midView)
            make.height.equalTo(50 * HEIGHT_SCALE)
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
        self.midView.addSubview(termView)
        termView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.midView)
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
        
        
        let view : UIView = UIView()
        view.backgroundColor = MAIN_COLOR
        self.midView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.right.left.equalTo(self.midView)
            make.top.equalTo(termView.snp.bottom)
            make.height.equalTo(10 * HEIGHT_SCALE)
        }
        
        // 姓名
        let nameView : UIView = UIView()
        self.midView.addSubview(nameView)
        nameView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.bottom)
            make.left.right.equalTo(self.midView)
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
        self.midView.addSubview(cardView)
        cardView.snp.makeConstraints { (make) in
            make.top.equalTo(nameView.snp.bottom)
            make.left.right.equalTo(self.midView)
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
    }
    
    
    // 创建底部View
    func createBottomView() -> Void {
        self.bottomView.backgroundColor = UIColor.white
        self.addSubview(self.bottomView)
        self.bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(self.midView.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(120 * HEIGHT_SCALE)
        }
        
        self.submitBtn.setTitle("提交申请", for: UIControlState.normal)
        self.submitBtn.backgroundColor = NAVIGATION_COLOR
        self.submitBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17 * WIDTH_SCALE)
        self.submitBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.submitBtn.layer.cornerRadius = 6 * WIDTH_SCALE
        self.submitBtn.layer.masksToBounds = true
        self.submitBtn.addTarget(self, action: #selector(submitClick), for: UIControlEvents.touchUpInside)
        self.bottomView.addSubview(self.submitBtn)
        self.submitBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.bottomView.snp.top).offset(10 * HEIGHT_SCALE)
            make.left.equalTo(self.bottomView.snp.left).offset(15 * WIDTH_SCALE)
            make.right.equalTo(self.bottomView.snp.right).offset(-15 * WIDTH_SCALE)
            make.height.equalTo(45 * HEIGHT_SCALE)
        }
        
        // 显示边框
        let borderView : UIView = UIView()
        borderView.layer.borderColor = LINE_COLOR2.cgColor
        borderView.layer.borderWidth = 1 * WIDTH_SCALE
        borderView.layer.cornerRadius = 33 * HEIGHT_SCALE / 2
        borderView.layer.masksToBounds = true
        self.bottomView.addSubview(borderView)
        borderView.snp.makeConstraints { (make) in
            make.top.equalTo(self.submitBtn.snp.bottom).offset(17 * HEIGHT_SCALE)
            make.left.equalTo(self.bottomView.snp.left).offset(15 * WIDTH_SCALE)
            make.right.equalTo(self.bottomView.snp.right).offset(-15 * WIDTH_SCALE)
            make.height.equalTo(33 * HEIGHT_SCALE)
        }
        
        // 立即咨询
        let label : UILabel = UILabel()
        label.text = "立即咨询"
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        label.textColor = TEXT_BLACK_COLOR
        self.bottomView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.bottomView)
            make.top.equalTo(self.submitBtn.snp.bottom).offset(10 * HEIGHT_SCALE)
            make.width.equalTo(100 * WIDTH_SCALE)
            make.height.equalTo(15 * WIDTH_SCALE)
        }
        
        
        self.promptLabel.text = "上海市当前有100位信贷经理在线为您办理"
        self.promptLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.promptLabel.backgroundColor = UIColor.white
        self.promptLabel.textAlignment = .center
        self.bottomView.addSubview(self.promptLabel)
        self.promptLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.bottomView)
            make.bottom.equalTo(self.bottomView.snp.bottom).offset(-10 * HEIGHT_SCALE)
            make.width.equalTo(270 * WIDTH_SCALE)
            make.height.equalTo(13 * HEIGHT_SCALE)
        }
    }
    
    
    //MARK: UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.submitBtn.isEnabled = false
        if textField == self.amountField {
            let amount : Int = Int(textField.text!)!
            if amount < 10000 || amount > 10000000 || amount % 10000 != 0 {
                SVProgressHUD.showError(withStatus: "申请金额需在1万元至1000万元，且为1万元的整数倍")
                textField.text = "50000"
                return
            }
        } else if textField == self.termField {
            let term : Int = Int(textField.text!)!
            if term < 1 {
                SVProgressHUD.showError(withStatus: "申请期限大于等于1个月")
                textField.text = "12"
                return
            }
        } else if textField == self.nameField {
            if self.largeInfoModel.verify != "1" {
                if textField.text?.count == 0 {
                    SVProgressHUD.showError(withStatus: "请输入姓名")
                    return
                } else {
                    // 上传服务器
                    requestUserName(attributeName: textField.text!, value: "name")
                }
            }
        } else if textField == self.cardField {
            if self.largeInfoModel.verify != "1" {
                if !XNumRule().cardRule(cardNum: textField.text!) {
                    SVProgressHUD.showError(withStatus: "请输入正确的身份证号码")
                    return
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
        self.submitBtn.isEnabled = true
    }
    
    
    // 更新头部信息
    func updateLargeHeaderData(largeInfo : LargeInfoModel) -> Void {
        self.largeInfoModel = largeInfo
        // 金额
        self.amountField.text = largeInfo.amountText

        // 申请期限
        self.termField.text = largeInfo.termText

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
        
        
        // 提示信息
        let promptText : String = String (format: "%@当前有%@位信贷经理在线为您办理", largeInfo.cityName!,largeInfo.loanNumText!)
        let termStr : NSMutableAttributedString = NSMutableAttributedString(string: promptText)
        let termFirstDict = [NSForegroundColorAttributeName : UIColor().colorWithHexString(hex: "009CFF")]
        termStr.addAttributes(termFirstDict, range: NSMakeRange(0, (largeInfo.cityName?.count)!))
        let termSecondDict = [NSForegroundColorAttributeName : LINE_COLOR3]
        termStr.addAttributes(termSecondDict, range: NSMakeRange((largeInfo.cityName?.count)!, promptText.count - (largeInfo.cityName?.count)!))
        self.promptLabel.attributedText = termStr
    }
    
    
    // 更换城市的点击事件
    func changeClick() -> Void {
        if self.largeChangeCity != nil {
            self.largeChangeCity!()
        }
    }
    
    
    // 提交申请的点击事件
    func submitClick() -> Void {
        if !(self.amountField.text?.isEmpty)! && !(self.termField.text?.isEmpty)! && !(self.nameField.text?.isEmpty)! && !(self.cardField.text?.isEmpty)! {
            HomePageService.homeInstance.requestCreditManager(applyAmount: self.amountField.text!, applyTerm: self.termField.text!, idCard: self.cardField.text!, success: { (responseObject) in
                let dataDict : NSDictionary = ["amount":self.amountField.text!,"term":self.termField.text!,"card":self.cardField.text!]
                if self.largeSubmitBlock != nil{
                    self.largeSubmitBlock!(dataDict)
                }
            }, failure: { (errorInfo) in
            })
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
