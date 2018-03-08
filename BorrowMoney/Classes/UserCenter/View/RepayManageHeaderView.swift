//
//  RepayManageHeaderView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/29.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class RepayManageHeaderView: BasicView {
    var amountLabel : UILabel?// 逾期金额
    var dateLabel : UILabel?// 逾期天数
    var amountInfo : UILabel?//
    var dateInfo : UILabel?//
    var infoLabel : UILabel?// 具体信息
    
    // 创建UI
    override func createUI() -> Void {
        // 背景
        let backImage : UIImageView = UIImageView()
        backImage.backgroundColor = NAVIGATION_COLOR
        self.addSubview(backImage)
        backImage.snp.makeConstraints { (make) in
            make.left.bottom.right.top.equalTo(self)
        }
        
        
        // 逾期金额
        let amoutName : UILabel = UILabel()
        amoutName.textColor = UIColor.white
        amoutName.font = UIFont .systemFont(ofSize: 13 * WIDTH_SCALE)
        self.amountInfo = amoutName
        backImage .addSubview(amoutName)
        amoutName.snp.makeConstraints { (make) in
            make.left.equalTo(backImage.snp.left).offset(15 * WIDTH_SCALE)
            make.top.equalTo(backImage.snp.top).offset(35 * HEIGHT_SCALE)
        }
        
        // 金额
        let amountLabel : UILabel = UILabel()
        amountLabel.textColor = UIColor.white
        amountLabel.font = UIFont .systemFont(ofSize: 30 * WIDTH_SCALE)
        self.amountLabel = amountLabel
        backImage .addSubview(amountLabel)
        amountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(amoutName.snp.right).offset(3 * WIDTH_SCALE)
            make.bottom.equalTo(amoutName.snp.bottom).offset(5 * HEIGHT_SCALE)
        }

        // 金额
        let amoutUnit : UILabel = UILabel()
        amoutUnit.text = "元"
        amoutUnit.textColor = UIColor.white
        amoutUnit.font = UIFont .systemFont(ofSize: 13 * WIDTH_SCALE)
        backImage .addSubview(amoutUnit)
        amoutUnit.snp.makeConstraints { (make) in
            make.left.equalTo((self.amountLabel?.snp.right)!)
            make.bottom.equalTo(amoutName.snp.bottom)
        }
        
        
        // 已逾期天
        let dateUnit : UILabel = UILabel()
        dateUnit.text = "天"
        dateUnit.textColor = UIColor.white
        dateUnit.font = UIFont .systemFont(ofSize: 13 * WIDTH_SCALE)
        backImage .addSubview(dateUnit)
        dateUnit.snp.makeConstraints { (make) in
            make.right.equalTo(backImage.snp.right).offset(-15 * WIDTH_SCALE)
            make.bottom.equalTo(amoutName.snp.bottom)
        }
        
        // 天数
        let dateLabel : UILabel = UILabel()
        dateLabel.textColor = UIColor.white
        dateLabel.font = UIFont .systemFont(ofSize: 30 * WIDTH_SCALE)
        self.dateLabel = dateLabel
        backImage .addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.right.equalTo(dateUnit.snp.left)
            make.bottom.equalTo(amoutName.snp.bottom).offset(5 * HEIGHT_SCALE)
        }
        
        // 已逾期
        let dateName : UILabel = UILabel()
        
        dateName.textColor = UIColor.white
        dateName.font = UIFont .systemFont(ofSize: 13 * WIDTH_SCALE)
        self.dateInfo = dateName
        backImage .addSubview(dateName)
        dateName.snp.makeConstraints { (make) in
            make.right.equalTo((self.dateLabel?.snp.left)!)
            make.bottom.equalTo(amoutName.snp.bottom)
        }
        // 已逾期
        let infoLabel : UILabel = UILabel()
        
        infoLabel.textColor = UIColor.white
        infoLabel.textAlignment = NSTextAlignment.center
        infoLabel.font = UIFont .systemFont(ofSize: 12 * WIDTH_SCALE)
        self.infoLabel = infoLabel
        backImage .addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.right.left.equalTo(backImage)
            make.bottom.equalTo(backImage.snp.bottom).offset(-15 * HEIGHT_SCALE)
        }
    }
    
    
    // 更新界面
    func updateHeaderView(loanManage : LoanManageModel) -> Void {
        if loanManage.status == "HAD_OVERDUED" {
            self.amountLabel?.text = "逾期金额:"
            self.dateLabel?.text = "已逾期:"
        } else {
            self.amountLabel?.text = "应还金额:"
            self.dateLabel?.text = "距还款日:"
        }
        
        // 金额
        self.amountLabel?.text = loanManage.currentRepayAmount
        
        // 天数
        let absTemp : Int = abs(Int(loanManage.currentRepayDays!)!)
        self.dateLabel?.text = String(absTemp)
        self.infoLabel?.text = String (format: "欠款总额为%@元，共计%@笔", loanManage.totalRepayAmount!,loanManage.totalCount!)
    }
}
