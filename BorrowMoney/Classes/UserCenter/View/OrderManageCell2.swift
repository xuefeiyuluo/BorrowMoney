//
//  OrderManageCell2.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/8.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class OrderManageCell2: BasicViewCell {
    var iconImageView : UIImageView = UIImageView()// icon图标
    var channelLabel : UILabel = UILabel()// 机构名称
    var stateLabel : UILabel = UILabel()// 订单状态
    var amountLabel : UILabel = UILabel()// 金额
    var termsLabel : UILabel = UILabel()// 期限
    var timeLabel : UILabel = UILabel()// 申请时间
    var operationBtn : UIButton = UIButton()// 操作按钮
    var repayAmountLabel : UILabel = UILabel()// 还款金额
    var repayTermLabel : UILabel = UILabel()// 还款期限时间
    
    var orderModel : OrderManageModel? {
        didSet {
            // icon图标
            self.iconImageView.kf.setImage(with: URL (string: (orderModel?.loanChannelLogo)!), placeholder: UIImage (named: "defaultWait.png"), options: nil, progressBlock: nil, completionHandler: nil)
            
            // 机构名称
            if (!self.isEmptyAndNil(str: (orderModel?.loanChannelName)!) && !self.isEmptyAndNil(str: (orderModel?.loanName)!)) {
                self.channelLabel.text = String (format:"%@-%@", (orderModel?.loanChannelName)!,(orderModel?.loanName)!)
            } else {
                if (!self.isEmptyAndNil(str: (orderModel?.loanChannelName)!)){
                    self.channelLabel.text = (orderModel?.loanChannelName)!
                } else if (!self.isEmptyAndNil(str: (orderModel?.loanName)!)) {
                    self.channelLabel.text = (orderModel?.loanName)!
                } else {
                    self.channelLabel.text = ""
                }
            }
            
            // 订单状态
            if orderModel?.status == "7" {
                self.stateLabel.textColor = NAVIGATION_COLOR
            } else {
                self.stateLabel.textColor = TEXT_BLACK_COLOR
            }
            self.stateLabel.text = orderModel?.statusDesc
            
            // 金额
            self.amountLabel.text = String (format: "金额:%@.00元", (orderModel?.loanAmount)!)
            
            // 期限
            self.termsLabel.text = String (format: "期限:%@", (orderModel?.loanTerms)!)
            // 申请时间
            self.timeLabel.text = String (format: "申请时间：%@", (orderModel?.orderTime)!)
        
            if orderModel?.canRepay == "1" {
                self.operationBtn.isHidden = false
                if self.isEmptyAndNil(str: (orderModel?.loanApplyUrl)!) {
                    self.operationBtn.setTitle("去还款", for: UIControlState.normal)
                } else {
                    if orderModel?.loanApplyUrl == "hryh" {
                        self.operationBtn.setTitle("一键还款", for: UIControlState.normal)
                    } else {
                        self.operationBtn.setTitle("去还款", for: UIControlState.normal)
                    }
                }
            } else {
                self.operationBtn.isHidden = true
            }
            
            // 逾期金额 逾期天数
            if orderModel?.status == "6" {
                let needAmountStr : String = String (format: "本期应还:%@元", (orderModel?.needRepayAmount)!)
                let amountStr : NSMutableAttributedString = NSMutableAttributedString(string: needAmountStr)
                let amountFirstDict = [NSForegroundColorAttributeName : LINE_COLOR3]
                amountStr.addAttributes(amountFirstDict, range: NSMakeRange(0, 5))
                let amountSecondDict = [NSForegroundColorAttributeName : UIColor().colorWithHexString(hex: "ff5a30")]
                amountStr.addAttributes(amountSecondDict, range: NSMakeRange(5, (orderModel?.needRepayAmount.count)!))
                let amountThirdDict = [NSForegroundColorAttributeName : LINE_COLOR3]
                amountStr.addAttributes(amountThirdDict, range: NSMakeRange(needAmountStr.count - 1, 1))
                self.repayAmountLabel.attributedText = amountStr

                // 逾期天数
                if orderModel?.needRepayTime == "0" {
                    let termStr : NSMutableAttributedString = NSMutableAttributedString(string: "需今日还款")
                    let termFirstDict = [NSForegroundColorAttributeName : LINE_COLOR3]
                    termStr.addAttributes(termFirstDict, range: NSMakeRange(0, 1))
                    let termSecondDict = [NSForegroundColorAttributeName : UIColor().colorWithHexString(hex: "ff5a30")]
                    termStr.addAttributes(termSecondDict, range: NSMakeRange(1, 2))
                    let termThirdDict = [NSForegroundColorAttributeName : LINE_COLOR3]
                    termStr.addAttributes(termThirdDict, range: NSMakeRange(3, 2))
                    self.repayTermLabel.attributedText = termStr
                } else {
                    let term : String = String (format: "距还款日%@天", (orderModel?.needRepayTime)!)
                    let termStr : NSMutableAttributedString = NSMutableAttributedString(string: term)
                    let termFirstDict = [NSForegroundColorAttributeName : LINE_COLOR3]
                    termStr.addAttributes(termFirstDict, range: NSMakeRange(0, 4))
                    let termSecondDict = [NSForegroundColorAttributeName : UIColor().colorWithHexString(hex: "ff5a30")]
                    termStr.addAttributes(termSecondDict, range: NSMakeRange(4, (orderModel?.needRepayTime.count)!))
                    let termThirdDict = [NSForegroundColorAttributeName : LINE_COLOR3]
                    termStr.addAttributes(termThirdDict, range: NSMakeRange(term.count - 1, 1))
                    self.repayTermLabel.attributedText = termStr
                }
            } else if orderModel?.status == "7" {
                let needAmountStr : String = String (format: "逾期金额:%@元", (orderModel?.overdueAmount)!)
                let amountStr : NSMutableAttributedString = NSMutableAttributedString(string: needAmountStr)
                let amountFirstDict = [NSForegroundColorAttributeName : LINE_COLOR3]
                amountStr.addAttributes(amountFirstDict, range: NSMakeRange(0, 5))
                let amountSecondDict = [NSForegroundColorAttributeName : UIColor().colorWithHexString(hex: "ff5a30")]
                amountStr.addAttributes(amountSecondDict, range: NSMakeRange(5, (orderModel?.overdueAmount.count)!))
                let amountThirdDict = [NSForegroundColorAttributeName : LINE_COLOR3]
                amountStr.addAttributes(amountThirdDict, range: NSMakeRange(needAmountStr.count - 1, 1))
                self.repayAmountLabel.attributedText = amountStr
                
                let term : String = String (format: "已逾期%@天", (orderModel?.overdueTime)!)
                let termStr : NSMutableAttributedString = NSMutableAttributedString(string: term)
                let termFirstDict = [NSForegroundColorAttributeName : LINE_COLOR3]
                termStr.addAttributes(termFirstDict, range: NSMakeRange(0, 3))
                let termSecondDict = [NSForegroundColorAttributeName : UIColor().colorWithHexString(hex: "ff5a30")]
                termStr.addAttributes(termSecondDict, range: NSMakeRange(3, (orderModel?.overdueTime.count)!))
                let termThirdDict = [NSForegroundColorAttributeName : LINE_COLOR3]
                termStr.addAttributes(termThirdDict, range: NSMakeRange(term.count - 1, 1))
                self.repayTermLabel.attributedText = termStr
            } else {
                self.repayAmountLabel.text = ""
                self.repayTermLabel.text = ""
            }
        }
    }
    

    // 创建界面
    override func createUI() {
        super.createUI()
        
        let topView : UIView = UIView()
        self.contentView.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.contentView)
            make.height.equalTo(44 * HEIGHT_SCALE)
        }
        
        // icon图标
        topView.addSubview(self.iconImageView)
        self.iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(topView.snp.left).offset(15 * WIDTH_SCALE)
            make.width.equalTo(28 * WIDTH_SCALE)
            make.height.equalTo(28 * HEIGHT_SCALE)
            make.centerY.equalTo(topView)
        }
        
        // 机构名称
        self.channelLabel.textColor = LINE_COLOR3
        self.channelLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        topView.addSubview(self.channelLabel)
        self.channelLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconImageView.snp.right).offset(8 * WIDTH_SCALE)
            make.top.bottom.equalTo(topView)
        }
        
        // 订单状态
        self.stateLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.stateLabel.textAlignment = NSTextAlignment.right
        self.contentView.addSubview(self.stateLabel)
        self.stateLabel.snp.makeConstraints { (make) in
            make.right.equalTo(topView.snp.right).offset(-15 * WIDTH_SCALE)
            make.top.bottom.equalTo(topView)
        }
        
        // 金额
        self.amountLabel.textColor = TEXT_SECOND_COLOR
        self.amountLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.contentView.addSubview(self.amountLabel)
        self.amountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15 * WIDTH_SCALE)
            make.top.equalTo(topView.snp.bottom).offset(4 * HEIGHT_SCALE)
            make.width.greaterThanOrEqualTo(120 * WIDTH_SCALE)
        }

        // 期限
        self.termsLabel.textColor = TEXT_SECOND_COLOR
        self.termsLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.contentView.addSubview(self.termsLabel)
        self.termsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.amountLabel.snp.right).offset(10 * WIDTH_SCALE)
            make.top.equalTo(self.amountLabel)
        }

        // 申请时间
        self.timeLabel.textColor = TEXT_SECOND_COLOR
        self.timeLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.contentView.addSubview(self.timeLabel)
        self.timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15 * WIDTH_SCALE)
            make.top.equalTo(self.amountLabel.snp.bottom).offset(6 * HEIGHT_SCALE)
        }

        // 操作按钮
        self.operationBtn.layer.borderColor = NAVIGATION_COLOR.cgColor
        self.operationBtn.layer.borderWidth = 1.5 * WIDTH_SCALE
        self.operationBtn.layer.cornerRadius = 1.5 * WIDTH_SCALE
        self.operationBtn.layer.masksToBounds = true
        self.operationBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.operationBtn.backgroundColor = NAVIGATION_COLOR
        self.operationBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.contentView.addSubview(self.operationBtn)
        self.operationBtn.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(11 * HEIGHT_SCALE)
            make.height.equalTo(28 * HEIGHT_SCALE)
            make.right.equalTo(self.contentView.snp.right).offset(-15 * WIDTH_SCALE)
            make.width.equalTo(90 * WIDTH_SCALE)
        }
        
        let lineView1 : UIView = UIView()
        lineView1.backgroundColor = UIColor().colorWithHexString(hex: "d0d0d0")
        self.contentView.addSubview(lineView1)
        lineView1.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-35 * HEIGHT_SCALE)
            make.left.equalTo(self.contentView.snp.left).offset(15 * WIDTH_SCALE)
            make.right.equalTo(self.contentView.snp.right).offset(-15 * WIDTH_SCALE)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        let lineView2 : UIView = UIView()
        lineView2.backgroundColor = UIColor().colorWithHexString(hex: "d0d0d0")
        self.contentView.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.bottom.right.left.equalTo(self.contentView)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        let bottomView : UIView = UIView()
        self.contentView.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(lineView1.snp.bottom)
            make.bottom.equalTo(lineView2.snp.top)
            make.left.right.equalTo(self.contentView)
        }
        
        let imageView : UIImageView = UIImageView()
        imageView.image = UIImage (named: "orderLine.png")
        bottomView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(bottomView.snp.top).offset(5 * HEIGHT_SCALE)
            make.bottom.equalTo(bottomView.snp.bottom).offset(-5 * HEIGHT_SCALE)
            make.centerX.equalTo(bottomView)
            make.width.equalTo(2 * WIDTH_SCALE)
        }
        
        // 还款金额
        self.repayAmountLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        bottomView.addSubview(self.repayAmountLabel)
        self.repayAmountLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(bottomView)
            make.left.equalTo(bottomView.snp.left).offset(15 * WIDTH_SCALE)
            make.right.equalTo(imageView.snp.left)
        }
        
        
        // 还款期限时间
        self.repayTermLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        bottomView.addSubview(self.repayTermLabel)
        self.repayTermLabel.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(bottomView)
            make.left.equalTo(imageView.snp.right).offset(15 * WIDTH_SCALE)
        }
    }
}
