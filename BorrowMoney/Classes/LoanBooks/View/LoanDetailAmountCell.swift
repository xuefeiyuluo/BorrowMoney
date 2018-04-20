//
//  LoanDetailAmountView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/11.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class LoanDetailAmountCell: BasicViewCell, UITextFieldDelegate {
    let upperView : UIView = UIView()// 上半部分View
    let lowerView : UIView = UIView()// 下半部分View
    let sheetBackView : UIView = UIView()// 弹框背景View
    var sheetView : BankSheetView = BankSheetView()// 弹框
    var loanAmount : UITextField = UITextField()// 贷款金额
    var loanTerm : UITextField = UITextField()// 贷款期限
    var termHeaderLabel : UILabel = UILabel()// 贷款期限 月/天
    var amountFooterLabel : UILabel = UILabel()// 金额范围
    var termFooterLabel : UILabel = UILabel()// 期限范围
    let tremBtn : UIButton = UIButton ()// 期限选择
    var interestRateView : UIView = UIView()// 参考利率View
    var rateLabel : UILabel = UILabel()// 利率
    var rateTextLabel : UILabel = UILabel()// 利率文案
    var lenderDaterView : UIView = UIView()// 时间View
    var dateImageView : UIImageView = UIImageView()
    var dateBtn : UIButton = UIButton ()// ?号弹框
    var dateLabel : UILabel = UILabel()// 时间
    var repayAmountView : UIView = UIView()// 还款金额View
    var amountBtn : UIButton = UIButton ()// ?号弹框
    var amountLabel : UILabel = UILabel()// 金额
    var amountTextLabel : UILabel = UILabel()// 金额文案
    var termArray : [String] = [String]()// 期限列表
    var loanDetail : LoanDetailModel? {
        didSet{
            var loanTermType : Int = 0;// 1或30
            
            if loanDetail?.interestUnit == "1" {
                self.termHeaderLabel.text = "借款期限/月"
                loanTermType = 30
            } else {
                self.termHeaderLabel.text = "借款期限/天"
                loanTermType = 1
            }
            
            // 借款期限/月  天
            if (loanDetail?.allowTerms.isEmpty)! {
                self.tremBtn.isHidden = true
                self.loanTerm.isEnabled = true
            } else {
                self.tremBtn.isHidden = false
                self.loanTerm.isEnabled = false
                
                self.termArray = (loanDetail?.allowTerms.components(separatedBy: ","))!
                
                var termBool : Bool = true
                for str : String in self.termArray {
                    if str == loanDetail?.inputTerms {
                        termBool = false
                        return
                    }
                }
                
                if termBool {
                    loanDetail?.inputTerms = self.termArray.first!
                }
                self.loanTerm.text = String (format: "%ld", (loanDetail?.inputTerms.intValue())! / loanTermType)
            }
        
            // 贷款金额  贷款期限
            if !(loanDetail?.inputAmount.isEmpty)! && !(self.loanDetail?.inputTerms.isEmpty)! {
                self.loanAmount.text = loanDetail?.inputAmount
                if self.termArray.count == 0 {
                    self.loanTerm.text = String (format: "%ld", (loanDetail?.inputTerms.intValue())!  / loanTermType)
                }
            } else {
                // 贷款金额
                if (loanDetail?.max_amount.intValue())! < 10000 {
                    self.loanAmount.text = loanDetail?.max_amount
                } else if (loanDetail?.min_amount.intValue())! > 10000 {
                    self.loanAmount.text = loanDetail?.min_amount
                } else {
                    self.loanAmount.text = "10000"
                }
                
                // 贷款期限
                if self.termArray.count == 0 {
                    if (loanDetail?.max_terms.intValue())! < 360 {
                        self.loanTerm.text = String (format: "%ld", (loanDetail?.max_terms.intValue())!  / loanTermType)
                    } else if (loanDetail?.min_terms.intValue())! > 360 {
                        self.loanTerm.text = String (format: "%ld", (loanDetail?.min_terms.intValue())!  / loanTermType)
                    } else {
                        self.loanTerm.text = String (format: "%ld", 360  / loanTermType)
                    }
                }
            }
            loanDetail?.inputAmount = self.loanAmount.text!
            loanDetail?.inputTerms = self.loanTerm.text!
            
            // 金额范围
            if (loanDetail?.max_amount.intValue())! < 10000 {
                self.amountFooterLabel.text = String (format: "额度范围%@~%@元",(loanDetail?.min_amount)!,(loanDetail?.max_amount)!)
            } else {
                self.amountFooterLabel.text = String (format: "额度范围%.2f~%.2f万元",(loanDetail?.min_amount.floatValue())! / 10000,(loanDetail?.max_amount.floatValue())! / 10000)
            }
            
            // 期限范围
            if loanDetail?.interestUnit == "1" {
                self.termFooterLabel.text = String (format: "期限范围%ld~%ld个月", (loanDetail?.min_terms.intValue())! / loanTermType,(loanDetail?.max_terms.intValue())! / loanTermType)
            } else {
                self.termFooterLabel.text = String (format: "期限范围%ld~%ld个天", (loanDetail?.min_terms.intValue())! / loanTermType,(loanDetail?.max_terms.intValue())! / loanTermType)
            }
            
            // 更新下半部分的View
            updateLowerViewDate()
        }
    }
    
    
    override func initializationData() {
        super.initializationData()
        
        // 注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(loanDetailAmountTextFieldChange(notification:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    
    // 创建UI
    override func createUI() {
        super.createUI()
        
        // 上半部分View
        createUpperView()
        
        // 下半部分View
        createLowerView()
    }
    
    
    // 上半部分View
    func createUpperView() -> Void {
        self.addSubview(self.upperView)
        self.upperView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(110 * HEIGHT_SCALE)
        }
        
        let lineView1 : UIView = UIView()
        lineView1.backgroundColor = LINE_COLOR2
        self.upperView.addSubview(lineView1)
        lineView1.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.upperView)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        let leftView : UIView = UIView()
        self.upperView.addSubview(leftView)
        leftView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self.upperView)
            make.width.equalTo(SCREEN_WIDTH / 2)
        }

        // 贷款金额
        self.loanAmount.textColor = NAVIGATION_COLOR
        self.loanAmount.font = UIFont.systemFont(ofSize: 25 * WIDTH_SCALE)
        self.loanAmount.textAlignment = .center
        self.loanAmount.delegate = self
        self.loanAmount.borderStyle = .roundedRect
        self.loanAmount.keyboardType = .numberPad
        leftView.addSubview(self.loanAmount)
        self.loanAmount.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(leftView)
            make.height.equalTo(35 * HEIGHT_SCALE)
            make.width.equalTo(110 * WIDTH_SCALE)
        }

        let amountHeaderLabel : UILabel = UILabel()
        amountHeaderLabel.text = "借款金额/元"
        amountHeaderLabel.textAlignment = .center
        amountHeaderLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        amountHeaderLabel.textColor = LINE_COLOR3
        leftView.addSubview(amountHeaderLabel)
        amountHeaderLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.loanAmount.snp.top).offset(-8 * HEIGHT_SCALE)
            make.left.right.equalTo(leftView)
        }

        // 金额范围
        self.amountFooterLabel.textAlignment = .center
        self.amountFooterLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.amountFooterLabel.textColor = LINE_COLOR3
        leftView.addSubview(self.amountFooterLabel)
        self.amountFooterLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.loanAmount.snp.bottom).offset(8 * HEIGHT_SCALE)
            make.left.right.equalTo(leftView)
        }
        
        
        let rightView : UIView = UIView()
        self.upperView.addSubview(rightView)
        rightView.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(self.upperView)
            make.width.equalTo(SCREEN_WIDTH / 2)
        }
        
        // 贷款期限
        self.loanTerm.textColor = NAVIGATION_COLOR
        self.loanTerm.keyboardType = .numberPad
        self.loanTerm.delegate = self
        self.loanTerm.font = UIFont.systemFont(ofSize: 25 * WIDTH_SCALE)
        self.loanTerm.textAlignment = .center
        self.loanTerm.borderStyle = .roundedRect
        rightView.addSubview(self.loanTerm)
        self.loanTerm.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(rightView)
            make.height.equalTo(35 * HEIGHT_SCALE)
            make.width.equalTo(110 * WIDTH_SCALE)
        }
        
        // 期限选择按钮
        self.tremBtn.setImage(UIImage (named: "tremsIcon"), for: UIControlState.normal)
        self.tremBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10 * WIDTH_SCALE)
        self.tremBtn.contentHorizontalAlignment = .right
        self.tremBtn.addTarget(self, action: #selector(termClick), for: UIControlEvents.touchUpInside)
        rightView.addSubview(self.tremBtn)
        rightView.addSubview(self.tremBtn)
        self.tremBtn.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(self.loanTerm)
            make.right.equalTo(rightView)
        }
        
        
        self.termHeaderLabel.textAlignment = .center
        self.termHeaderLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.termHeaderLabel.textColor = LINE_COLOR3
        rightView.addSubview(self.termHeaderLabel)
        self.termHeaderLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.loanTerm.snp.top).offset(-8 * HEIGHT_SCALE)
            make.left.right.equalTo(rightView)
        }
        
        // 期限范围
        self.termFooterLabel.textAlignment = .center
        self.termFooterLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.termFooterLabel.textColor = LINE_COLOR3
        rightView.addSubview(self.termFooterLabel)
        self.termFooterLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.loanTerm.snp.bottom).offset(8 * HEIGHT_SCALE)
            make.left.right.equalTo(rightView)
        }
        
        
        let lineView2 : UIView = UIView()
        lineView2.backgroundColor = LINE_COLOR2
        self.upperView.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.upperView)
            make.left.equalTo(self.upperView.snp.left).offset(15 * WIDTH_SCALE)
            make.right.equalTo(self.upperView.snp.right).offset(-15 * WIDTH_SCALE)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
    }
    
    
    // 下半部分View
    func createLowerView() -> Void {
        self.addSubview(self.lowerView)
        self.lowerView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.upperView.snp.bottom)
            make.height.equalTo(60 * HEIGHT_SCALE)
        }
        
        let viewWidth : CGFloat = SCREEN_WIDTH / 3
        // 参考利率View
        self.lowerView.addSubview(self.interestRateView)
        self.interestRateView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.lowerView)
            make.width.equalTo(viewWidth)
            make.left.equalTo(self.lowerView)
        }

        let rateImageView : UIImageView = UIImageView()
        rateImageView.contentMode = .center
        rateImageView.image = UIImage (named: "greenLine")
        self.interestRateView.addSubview(rateImageView)
        rateImageView.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self.interestRateView)
            make.width.equalTo(2 * WIDTH_SCALE)
        }

        // 利率
        self.rateLabel.textColor = UIColor().colorWithHexString(hex: "777777")
        self.rateLabel.font = UIFont.boldSystemFont(ofSize: 15 * WIDTH_SCALE)
        self.rateLabel.textAlignment = .center
        self.interestRateView.addSubview(self.rateLabel)
        self.rateLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.interestRateView)
            make.top.equalTo(self.interestRateView.snp.top).offset(10 * HEIGHT_SCALE)
        }

        // 利率文案
        self.rateTextLabel.textColor = UIColor().colorWithHexString(hex: "777777")
        self.rateTextLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.rateTextLabel.textAlignment = .center
        self.interestRateView.addSubview(self.rateTextLabel)
        self.rateTextLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.interestRateView)
            make.bottom.equalTo(self.interestRateView.snp.bottom).offset(-10 * HEIGHT_SCALE)
        }
        
        // 时间View
        self.lowerView.addSubview(self.lenderDaterView)
        self.lenderDaterView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.lowerView)
            make.width.equalTo(viewWidth)
            make.left.equalTo(self.interestRateView.snp.right)
        }
        
        self.dateImageView.contentMode = .center
        self.dateImageView.image = UIImage (named: "greenLine")
        self.lenderDaterView.addSubview(self.dateImageView)
        self.dateImageView.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self.lenderDaterView)
            make.width.equalTo(2 * WIDTH_SCALE)
        }

        self.dateBtn.setImage(UIImage (named: "questionmark"), for: UIControlState.normal)
        self.dateBtn.addTarget(self, action: #selector(questionClick), for: UIControlEvents.touchUpInside)
        self.lenderDaterView.addSubview(self.dateBtn)
        self.dateBtn.snp.makeConstraints { (make) in
            make.top.right.equalTo(self.lenderDaterView)
            make.width.equalTo(30 * WIDTH_SCALE)
            make.height.equalTo(30 * WIDTH_SCALE)
        }

        // 时间
        self.dateLabel.textColor = UIColor().colorWithHexString(hex: "777777")
        self.dateLabel.font = UIFont.boldSystemFont(ofSize: 15 * WIDTH_SCALE)
        self.dateLabel.textAlignment = .center
        self.lenderDaterView.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.lenderDaterView)
            make.top.equalTo(self.lenderDaterView.snp.top).offset(10 * HEIGHT_SCALE)
        }

        // 时间文案
        let dateTextLabel : UILabel = UILabel()// 时间文案
        dateTextLabel.text = "最快放款时间"
        dateTextLabel.textColor = UIColor().colorWithHexString(hex: "777777")
        dateTextLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        dateTextLabel.textAlignment = .center
        lenderDaterView.addSubview(dateTextLabel)
        dateTextLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.lenderDaterView)
            make.bottom.equalTo(self.lenderDaterView.snp.bottom).offset(-10 * HEIGHT_SCALE)
        }
        
        
        // 还款金额View
        self.lowerView.addSubview(self.repayAmountView)
        self.repayAmountView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.lowerView)
            make.width.equalTo(viewWidth)
            make.left.equalTo(self.lenderDaterView.snp.right)
        }
        
        self.amountBtn.setImage(UIImage (named: "questionmark"), for: UIControlState.normal)
        self.amountBtn.addTarget(self, action: #selector(questionClick), for: UIControlEvents.touchUpInside)
        self.repayAmountView.addSubview(self.amountBtn)
        self.amountBtn.snp.makeConstraints { (make) in
            make.top.right.equalTo(self.repayAmountView)
            make.width.equalTo(30 * WIDTH_SCALE)
            make.height.equalTo(30 * WIDTH_SCALE)
        }

        // 还款金额
        self.amountLabel.textColor = UIColor().colorWithHexString(hex: "777777")
        self.amountLabel.font = UIFont.boldSystemFont(ofSize: 15 * WIDTH_SCALE)
        self.amountLabel.textAlignment = .center
        self.repayAmountView.addSubview(self.amountLabel)
        self.amountLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.repayAmountView)
            make.top.equalTo(self.repayAmountView.snp.top).offset(10 * HEIGHT_SCALE)
        }
        
        // 还款金额文案
        self.amountTextLabel.textColor = UIColor().colorWithHexString(hex: "777777")
        self.amountTextLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.amountTextLabel.textAlignment = .center
        self.repayAmountView.addSubview(self.amountTextLabel)
        self.amountTextLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.repayAmountView)
            make.bottom.equalTo(self.repayAmountView.snp.bottom).offset(-10 * HEIGHT_SCALE)
        }
        
        
        
        let lineView : UIView = UIView()
        lineView.backgroundColor = LINE_COLOR2
        self.lowerView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.lowerView)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
    }
    
    
    // 创建弹框View
    func createSheetView() -> Void {
        weak var weakSelf = self
        let window : UIWindow = UIApplication.shared.keyWindow!
        self.sheetBackView.backgroundColor = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
        self.sheetBackView.frame = window.bounds
        window.addSubview(self.sheetBackView)
        
        self.sheetView.backgroundColor = UIColor.white
        self.sheetView.sheetBool = false
        self.sheetView.frame = CGRect (x:0 , y: SCREEN_HEIGHT + 200 * HEIGHT_SCALE, width: SCREEN_WIDTH, height: 200 * HEIGHT_SCALE)
        self.sheetBackView.addSubview(self.sheetView)
        self.sheetView.bankSheetBlock = { (tag) in
            weakSelf?.removeSheetView()
        }
        self.sheetView.bankPickBlock = { (model : BankNameModel) in
            let trems : String = model.bankName.substringInRange(0...model.bankName.count - 2)
            weakSelf?.loanDetail?.inputTerms = trems
            weakSelf?.loanTerm.text = trems
            // 更新下半部分的View的数据
            weakSelf?.updateLowerViewDate()
        }
    }
    
    
    //MARK:UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.loanAmount {
            if (textField.text?.intValue())! % 100 != 0  || (textField.text?.intValue())! < (self.loanDetail?.min_amount.intValue())! {
                SVProgressHUD.showInfo(withStatus: String (format: "贷款额度为%@元~%@元且必须为100的整数倍",(self.loanDetail?.min_amount)!,(self.loanDetail?.max_amount)!))
                textField.text = self.loanDetail?.inputAmount
            }
            return;
        } else if textField == self.loanTerm {
            if (textField.text?.intValue())! < (self.loanDetail?.min_terms.intValue())! || (textField.text?.intValue())! > (self.loanDetail?.max_terms.intValue())! {
                // "1"以月为单位
                if self.loanDetail?.interestUnit == "1" {
                    SVProgressHUD.showInfo(withStatus: String (format: "贷款期限为%ld~%ld个月",(self.loanDetail?.min_terms.intValue())! / 30,(self.loanDetail?.max_terms.intValue())! / 30))
                } else {
                    SVProgressHUD.showInfo(withStatus: String (format: "贷款期限为%@~%@个天",(self.loanDetail?.min_terms)!,(self.loanDetail?.max_terms)!))
                }
                textField.text = self.loanDetail?.inputTerms
            }
            return;
        }
        
        
        self.loanDetail?.inputAmount = self.loanAmount.text!
        self.loanDetail?.inputTerms = self.loanTerm.text!
        // 更新下半部分的View的数据
//        updateLowerViewDate()
    }
    
    
    // text改变时调用
    func loanDetailAmountTextFieldChange(notification:Notification) -> Void {
        let textField : UITextField! = notification.object as! UITextField
        
        // 期限
        if textField == self.loanTerm {
            if (loanDetail?.allowTerms.isEmpty)! {
                if  (textField.text?.intValue())! > (self.loanDetail?.max_terms.intValue())! {
                    if self.loanDetail?.interestUnit == "1" {
                        SVProgressHUD.showInfo(withStatus: String (format: "贷款期限最长为%ld月",(self.loanDetail?.max_terms.intValue())! / 30))
                    } else {
                        SVProgressHUD.showInfo(withStatus: String (format: "贷款期限最长为%@天",(self.loanDetail?.max_terms)!))
                    }
                }
            }
        } else if textField == self.loanAmount {
            if  (textField.text?.intValue())! > (self.loanDetail?.max_amount.intValue())! {
                textField.text =  self.loanDetail?.max_amount
                SVProgressHUD.showInfo(withStatus: String (format: "贷款额度最大为%@元",(self.loanDetail?.max_amount)!))
            }
        }
    }

    
    // 更新下半部分的View的数据
    func updateLowerViewDate() -> Void {
        // 改变页面的布局
        changeLowerView()
        
        // 利率 金额
        self.rateLabel.text = String (format: "%.2f%%",(loanDetail?.interestValue.floatValue())! / 100)
        if loanDetail?.interestUnit == "1" {
            self.amountTextLabel.text = "每月还款金额"
            self.rateTextLabel.text = "参考月利率"
            self.amountLabel.text = String (format: "%.0f", (self.loanAmount.text?.floatValue())! / (self.loanTerm.text?.floatValue())! + (self.loanAmount.text?.floatValue())! * (self.loanDetail?.month_fee_rate.floatValue())! / 10000)
        } else {
            self.amountTextLabel.text = "每日还款金额"
            self.rateTextLabel.text = "参考日利率"
            self.amountLabel.text = String (format: "%.0f", (self.loanAmount.text?.floatValue())! / (self.loanTerm.text?.floatValue())! + (self.loanAmount.text?.floatValue())! * (self.loanDetail?.dbInterest.floatValue())! / 10000)
        }
        
        // 时间
        self.dateLabel.text = String (format: "%@%@", (loanDetail?.min_duration_value)!,(loanDetail?.min_duration_unit)!)
    }
    
    
    // 改变页面的布局
    func changeLowerView() -> Void {
        if self.loanDetail?.interestDisplay == "1" {
            let viewWidth : CGFloat = SCREEN_WIDTH / 3
            
            self.interestRateView.snp.updateConstraints { (make) in
                make.width.equalTo(viewWidth)
            }
            
            self.lenderDaterView.snp.updateConstraints { (make) in
                make.width.equalTo(viewWidth)
                make.left.equalTo(self.interestRateView.snp.right)
            }
            self.dateBtn.isHidden = true
            self.dateImageView.isHidden = false
            
            self.repayAmountView.snp.updateConstraints { (make) in
                make.width.equalTo(viewWidth)
                make.left.equalTo(self.lenderDaterView.snp.right)
            }
        } else {
            let viewWidth : CGFloat = SCREEN_WIDTH / 2
            
            self.interestRateView.snp.updateConstraints { (make) in
                make.width.equalTo(viewWidth)
            }
            
            self.lenderDaterView.snp.updateConstraints { (make) in
                make.width.equalTo(viewWidth)
                make.left.equalTo(self.interestRateView.snp.right)
            }
            self.dateBtn.isHidden = false
            self.dateImageView.isHidden = true
            
            self.repayAmountView.snp.updateConstraints { (make) in
                make.width.equalTo(0)
            }
        }
    }
    
    
    // 期限选择框
    func termClick() -> Void {
        // 创建弹框View
        createSheetView()
        
        // 更新期限选择View
        if self.termArray.count > 0 {
            var bankArray : [BankNameModel] = [BankNameModel]()
            for trem : String in self.termArray {
                let model : BankNameModel = BankNameModel()
                if self.loanDetail?.interestUnit == "1" {
                    model.bankName = String (format: "%i月", trem.intValue() / 30)
                } else {
                    model.bankName = String (format: "%@日", trem)
                }
                bankArray.append(model)
            }
            self.sheetView.bankArray = bankArray
        }
        
        UIView.animate(withDuration: 0.3) {
            self.sheetView.frame = CGRect (x:0 , y: SCREEN_HEIGHT - 200 * HEIGHT_SCALE, width: SCREEN_WIDTH, height: 200 * HEIGHT_SCALE)
        }
    }
    
    
    // 移除弹框
    func removeSheetView() -> Void {
        UIView.animate(withDuration: 0.3, animations: {
            self.sheetView.frame = CGRect (x:0 , y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 200 * HEIGHT_SCALE)
        }) { (finished : Bool) in
            self.sheetBackView.removeFromSuperview()
        }
    }
    
    
    // 问号的点击事件
    func questionClick() -> Void {
        let alertView : UIAlertView = UIAlertView.init(title: "实际利率等受个人材料影响，以放款机构为准", message: "", delegate: self, cancelButtonTitle: "知道了")
        alertView.show()
    }
}
