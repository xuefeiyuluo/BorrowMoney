//
//  OrderDetailSateCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/8.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit


class OrderDetailSateCell: BasicViewCell {
    let stateLabel : UILabel = UILabel()// 订单状态
    let timeLabel : UILabel = UILabel()// 时间
    let operationBtn : UIButton = UIButton()// 操作按钮
    
    var orderDetail : OrderDetailModel?{
        didSet{
            if orderDetail != nil {
                // 订单状态
                self.stateLabel.text = orderDetail?.statusDesc
                if orderDetail?.status == "7" {
                    self.stateLabel.textColor = UIColor().colorWithHexString(hex: "ff5a30")
                } else {
                    self.stateLabel.textColor = NAVIGATION_COLOR
                }
                
                // 时间
                self.timeLabel.text = orderDetail?.updateTime
                
                // 操作按钮
                // 1订单取消，2审核中，3审核失败，4审核成功，5放款失败， 6正常还款中，7逾期待还，8已还清
                if orderDetail?.status == "3" {
                    self.operationBtn.isHidden = false
                    self.operationBtn.setTitle("查看其它产品", for: UIControlState.normal)
                } else if orderDetail?.status == "6" || orderDetail?.status == "7" {
                    if orderDetail?.canRepay == "1" {
                        self.operationBtn.isHidden = false
                        if (orderDetail?.loanApplyUrl.isEmpty)! {
                            self.operationBtn.setTitle("去还款", for: UIControlState.normal)
                        } else {
                            if orderDetail?.loanApplyUrl == "hryh" {
                                self.operationBtn.setTitle("一键还款", for: UIControlState.normal)
                            } else {
                                self.operationBtn.setTitle("去还款", for: UIControlState.normal)
                            }
                        }
                    } else {
                        self.operationBtn.isHidden = true
                    }
                } else if orderDetail?.status == "8" && orderDetail?.loanType == "API" {
                    self.operationBtn.isHidden = false
                    self.operationBtn.setTitle("再贷一笔", for: UIControlState.normal)
                } else if orderDetail?.status == "4" {
                    self.operationBtn.isHidden = true
                } else {
                    if orderDetail?.withdraw == "1" {
                        self.operationBtn.isHidden = false
                        self.operationBtn.setTitle("签约提现", for: UIControlState.normal)
                    } else {
                        if orderDetail?.loanType == "API" || orderDetail?.loanType == "DATA_PUSH" {
                            self.operationBtn.isHidden = false
                            self.operationBtn.setTitle("查看其它产品", for: UIControlState.normal)
                        } else {
                            self.operationBtn.isHidden = true
                        }
                    }
                }
            }
        }
    }

    
    // 创建界面
    override func createUI() {
        super.createUI()
        
        // 订单状态
        self.stateLabel.font = UIFont.systemFont(ofSize: 19 * WIDTH_SCALE)
        self.contentView.addSubview(self.stateLabel)
        self.stateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15 * WIDTH_SCALE)
            make.top.equalTo(self.contentView.snp.top).offset(12 * WIDTH_SCALE)
        }
        
        // 时间
        self.timeLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.timeLabel.textColor = LINE_COLOR3
        self.contentView.addSubview(self.timeLabel)
        self.timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15 * WIDTH_SCALE)
            make.top.equalTo(self.stateLabel.snp.bottom).offset(5 * WIDTH_SCALE)
        }
        
        // 操作按钮
        self.operationBtn.setTitle("查看其它产品", for: UIControlState.normal)
        self.operationBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.operationBtn.setTitleColor(NAVIGATION_COLOR, for: UIControlState.normal)
        self.operationBtn.layer.cornerRadius = 1.5
        self.operationBtn.layer.borderColor = NAVIGATION_COLOR.cgColor
        self.operationBtn.layer.borderWidth = 1.0
        self.contentView.addSubview(self.operationBtn)
        self.operationBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.width.equalTo(110 * WIDTH_SCALE)
            make.right.equalTo(self.contentView.snp.right).offset(-15 * WIDTH_SCALE)
            make.height.equalTo(30 * HEIGHT_SCALE)
        }
        
        let lineView : UIView = UIView()
        lineView.backgroundColor = UIColor().colorWithHexString(hex: "d0d0d0")
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self.contentView)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
    }
}
