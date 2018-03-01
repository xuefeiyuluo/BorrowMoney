//
//  CapitalViewCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/2/27.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class CapitalViewCell: BasicViewCell {
    var sourceLabel : UILabel = UILabel()// 奖励来源
    var typeLabel : UILabel = UILabel()// 奖励类型
    var timeLabel : UILabel = UILabel()// 时间
    var amountLabel : UILabel = UILabel()// 金额
    var captialModel : CapitalModel? {
        didSet {
            // 奖励来源
            self.sourceLabel.text = captialModel?.title as String?
            
            // 奖励类型
            self.typeLabel.text = captialModel?.operatorType as String?
            
            // 时间
            self.timeLabel.text = captialModel?.createTime as String?
            
            // 金额
            if captialModel?.recordType == "收入" {
                self.amountLabel.text = NSString (format: "+%@", (captialModel?.amount)!) as String
                self.amountLabel.textColor = UIColor().colorWithHexString(hex: "ff5447")
            } else {
                self.amountLabel.text = NSString (format: "-%@", (captialModel?.amount)!) as String
                self.amountLabel.textColor = UIColor().colorWithHexString(hex: "00c4ac")
            }
        }
    }
    
    
    // 创建界面
    override func createUI() {
        // 奖励来源
        self.sourceLabel.textColor = TEXT_SECOND_COLOR
        self.sourceLabel.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        self.contentView.addSubview(self.sourceLabel)
        self.sourceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(12 * WIDTH_SCALE)
            make.top.equalTo(self.contentView.snp.top).offset(8 * HEIGHT_SCALE)
        }
        
        // 奖励类型
        self.typeLabel.textColor = LINE_COLOR3
        self.typeLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.contentView.addSubview(self.typeLabel)
        self.typeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(12 * WIDTH_SCALE)
            make.top.equalTo(self.sourceLabel.snp.bottom).offset(6 * HEIGHT_SCALE)
        }
        
        // 时间
        self.timeLabel.textColor = LINE_COLOR3
        self.timeLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.contentView.addSubview(self.timeLabel)
        self.timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(12 * WIDTH_SCALE)
            make.top.equalTo(self.typeLabel.snp.bottom).offset(6 * HEIGHT_SCALE)
        }
        
        // 金额单位
        let unitLabel : UILabel = UILabel()
        unitLabel.text = "元"
        unitLabel.textColor = TEXT_SECOND_COLOR
        unitLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.contentView.addSubview(unitLabel)
        unitLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-12 * WIDTH_SCALE)
            make.centerY.equalTo(self.contentView.snp.centerY).offset(3 * HEIGHT_SCALE)
        }
        
        
        // 金额
        self.amountLabel.textColor = LINE_COLOR3
        self.amountLabel.font = UIFont.systemFont(ofSize: 24 * WIDTH_SCALE)
        self.contentView.addSubview(self.amountLabel)
        self.amountLabel.snp.makeConstraints { (make) in
            make.right.equalTo(unitLabel.snp.left)
            make.centerY.equalTo(self.contentView.snp.centerY)
        }
        
        
        // 横线
        let lineView : UIView = UIView()
        lineView.backgroundColor = LINE_COLOR1
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
    }
}
