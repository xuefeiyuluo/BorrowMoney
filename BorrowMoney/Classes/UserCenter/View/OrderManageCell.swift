//
//  OrderManageCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/6.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class OrderManageCell: BasicViewCell {
    var iconImageView : UIImageView = UIImageView()// icon图标
    var channelLabel : UILabel = UILabel()// 机构名称
    var stateLabel : UILabel = UILabel()// 订单状态
    var amountLabel : UILabel = UILabel()// 金额
    var termsLabel : UILabel = UILabel()// 期限
    var timeLabel : UILabel = UILabel()// 申请时间
    var copyLabel : UILabel = UILabel()// 文案信息
    var operationBtn : UIButton = UIButton()// 操作按钮
    var orderModel : OrderManageModel? {
        didSet {
            // icon图标
            self.iconImageView.kf.setImage(with: URL (string: (orderModel?.loanChannelLogo)!), placeholder: UIImage (named: "defaultWait.png"), options: nil, progressBlock: nil, completionHandler: nil)
            
            // 机构名称
            if (!(orderModel?.loanChannelName.isEmpty)! && !(orderModel?.loanName.isEmpty)!) {
                self.channelLabel.text = String (format:"%@-%@", (orderModel?.loanChannelName)!,(orderModel?.loanName)!)
            } else {
                if (!(orderModel?.loanChannelName.isEmpty)!){
                    self.channelLabel.text = (orderModel?.loanChannelName)!
                } else if (!(orderModel?.loanName.isEmpty)!) {
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
            self.amountLabel.text = String (format: "金额:%@元", (orderModel?.loanAmount)!)
            
            // 期限
            self.termsLabel.text = String (format: "期限:%@", (orderModel?.loanTerms)!)
            // 申请时间
            self.timeLabel.text = String (format: "申请时间：%@", (orderModel?.orderTime)!)
            
            // 文案信息  操作按钮
            if orderModel?.status == "3" {
                self.copyLabel.isHidden = false
                self.operationBtn.isHidden = true
            } else if (orderModel?.status == "6" || orderModel?.status == "7"){
                self.copyLabel.isHidden = true
                if orderModel?.canRepay == "1" {
                    self.operationBtn.isHidden = false
                    self.operationBtn.setTitle("去还款", for: UIControlState.normal)
                    self.operationBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
                    self.operationBtn.backgroundColor = NAVIGATION_COLOR
                } else {
                    self.operationBtn.isHidden = true
                }
            } else if (orderModel?.status == "8" && orderModel?.loanType == "API"){
                self.copyLabel.isHidden = true
                self.operationBtn.isHidden = false
                self.operationBtn.setTitle("再贷一笔", for: UIControlState.normal)
                self.operationBtn.setTitleColor(NAVIGATION_COLOR, for: UIControlState.normal)
                self.operationBtn.backgroundColor = UIColor.white
            } else if orderModel?.status == "4" {
                self.copyLabel.isHidden = true
                self.operationBtn.isHidden = true
            } else {
                if orderModel?.withdraw == "1" {
                    self.copyLabel.isHidden = true
                    self.operationBtn.isHidden = false
                    self.operationBtn.setTitle("签约提现", for: UIControlState.normal)
                    self.operationBtn.setTitleColor(NAVIGATION_COLOR, for: UIControlState.normal)
                    self.operationBtn.backgroundColor = UIColor.white
                } else {
                    self.copyLabel.isHidden = true
                    if (orderModel?.loanType == "API" || orderModel?.loanType == "DATA_PUSH") {
                        self.operationBtn.isHidden = false
                        self.operationBtn.setTitle("查看其它产品", for: UIControlState.normal)
                        self.operationBtn.setTitleColor(NAVIGATION_COLOR, for: UIControlState.normal)
                        self.operationBtn.backgroundColor = UIColor.white
                    } else {
                        self.operationBtn.isHidden = true
                    }
                }
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
        
        let lineView1 : UIView = UIView()
        lineView1.backgroundColor = UIColor().colorWithHexString(hex: "d0d0d0")
        self.contentView.addSubview(lineView1)
        lineView1.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
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
        
        // 金额
        self.amountLabel.textColor = TEXT_SECOND_COLOR
        self.amountLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.contentView.addSubview(self.amountLabel)
        self.amountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15 * WIDTH_SCALE)
            make.top.equalTo(lineView1.snp.bottom).offset(8 * HEIGHT_SCALE)
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
            make.top.equalTo(self.amountLabel.snp.bottom).offset(8 * HEIGHT_SCALE)
            
        }
        
        // 文案信息
        self.copyLabel.text = "资料不符合"
        self.copyLabel.textColor = NAVIGATION_COLOR
        self.copyLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.contentView.addSubview(self.copyLabel)
        self.copyLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-15 * WIDTH_SCALE)
            make.top.equalTo(lineView1.snp.bottom)
            make.bottom.equalTo(lineView2.snp.top)
        }
        
        // 操作按钮
        self.operationBtn.layer.borderColor = NAVIGATION_COLOR.cgColor
        self.operationBtn.layer.borderWidth = 1.5 * WIDTH_SCALE
        self.operationBtn.layer.cornerRadius = 1.5 * WIDTH_SCALE
        self.operationBtn.layer.masksToBounds = true
        self.operationBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.contentView.addSubview(self.operationBtn)
        self.operationBtn.snp.makeConstraints { (make) in
            make.top.equalTo(lineView1.snp.bottom).offset(13 * HEIGHT_SCALE)
            make.bottom.equalTo(lineView2.snp.top).offset(-13 * HEIGHT_SCALE)
            make.right.equalTo(self.contentView.snp.right).offset(-15 * WIDTH_SCALE)
            make.width.equalTo(90 * WIDTH_SCALE)
        }
    }
}
