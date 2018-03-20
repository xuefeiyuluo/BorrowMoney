//
//  PlanViewCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/17.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class PlanViewCell: BasicViewCell {
    var termLabel : UILabel = UILabel()// 期数/总期数
    var amountLabel : UILabel = UILabel()// 还款金额
    var dateLabel : UILabel = UILabel()// 还款日
    var stateLabel : UILabel = UILabel()// 还款情况
    var planModel : PlanModel? {
        didSet {
            // 期数/总期数
            self.termLabel.text = planModel?.period
            
            // 还款金额
            self.amountLabel.text = planModel?.repayAmount
            
            // 还款日
            self.dateLabel.text = planModel?.repayDate
            
            // 还款情况
            self.stateLabel.text = planModel?.statusStr
            
            if planModel?.status == "4" {
                self.stateLabel.textColor = UIColor().colorWithHexString(hex: "ff5b3a")
                updateStateColor(color: TEXT_SECOND_COLOR)
            } else if planModel?.status == "1" {
                self.stateLabel.textColor = TEXT_SECOND_COLOR
                updateStateColor(color: TEXT_SECOND_COLOR)
            } else if planModel?.status == "2" || planModel?.status == "3" {
                self.stateLabel.textColor = LINE_COLOR3
                updateStateColor(color: LINE_COLOR3)
            } else {
                self.stateLabel.textColor = TEXT_SECOND_COLOR
                updateStateColor(color: TEXT_SECOND_COLOR)
            }
        }
    }
    
    
    // 根据状态改变每条贷款的颜色
    func updateStateColor(color : UIColor) -> Void {
        // 期数/总期数
        self.termLabel.textColor = color
        
        // 还款金额
        self.amountLabel.textColor = color
        
        // 还款日
        self.dateLabel.textColor = color
    }
    
    
    // 创建界面
    override func createUI() {
        super.createUI()
        
        // 期数/总期数
        self.termLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.termLabel.textColor = LINE_COLOR3
        self.contentView.addSubview(self.termLabel)
        self.termLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.left.equalTo(self.contentView.snp.left).offset(15 * WIDTH_SCALE)
            make.width.equalTo((SCREEN_WIDTH - 30 * WIDTH_SCALE) / 4)
        }
        
        // 还款金额
        self.amountLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.amountLabel.textColor = LINE_COLOR3
        self.contentView.addSubview(self.amountLabel)
        self.amountLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.left.equalTo(self.termLabel.snp.right)
            make.width.equalTo((SCREEN_WIDTH - 30 * WIDTH_SCALE) / 4)
        }
        
        // 还款日
        self.dateLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.dateLabel.textColor = LINE_COLOR3
        self.dateLabel.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.left.equalTo(self.amountLabel.snp.right)
            make.width.equalTo(((SCREEN_WIDTH - 30 * WIDTH_SCALE) / 2) / 5 * 3)
        }
        
        // 还款情况
        self.stateLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.stateLabel.textColor = LINE_COLOR3
        self.stateLabel.textAlignment = NSTextAlignment.right
        self.contentView.addSubview(self.stateLabel)
        self.stateLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.right.equalTo(self.contentView.snp.right).offset(-15 * WIDTH_SCALE)
            make.width.equalTo(((SCREEN_WIDTH - 30 * WIDTH_SCALE) / 2) / 5 * 2)
        }
    }
}
