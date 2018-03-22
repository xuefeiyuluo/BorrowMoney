//
//  IntegralDetailCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/22.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class IntegralDetailCell: BasicViewCell {
    var typeLabel : UILabel = UILabel()// 积分类型
    var timeLabel : UILabel = UILabel()// 时间
    var amonutLabel : UILabel = UILabel()// 积分数量
    var integralModel : IntergralListModel?{
        didSet {
//            [cell updateWithPointWay:signRecordEntity.operatorType date:signRecordEntity.createTime pointChanges:signRecordEntity.goldValue];
            // 积分类型
            self.typeLabel.text = integralModel?.operatorType
            
            // 时间
            self.timeLabel.text = integralModel?.createTime
            
            // 积分数量
            let amount : Int = Int((integralModel?.goldValue)!)!
            if amount > 0 {
                self.amonutLabel.text = String (format: "+%@", (integralModel?.goldValue)!)
                self.amonutLabel.textColor = UIColor().colorWithHexString(hex: "ff5240")
            } else {
                self.amonutLabel.text = String (format: "-%@", (integralModel?.goldValue)!)
                self.amonutLabel.textColor = UIColor().colorWithHexString(hex: "00c4ac")
            }
        }
    }
    
    
    // 创建界面
    override func createUI() {
        super.createUI()
        
        // 积分类型
        self.typeLabel.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        self.typeLabel.textColor = UIColor().colorWithHexString(hex: "2A2A2A")
        self.contentView.addSubview(self.typeLabel)
        self.typeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15 * WIDTH_SCALE)
            make.top.equalTo(self.contentView.snp.top).offset(5 * HEIGHT_SCALE)
        }
        
        // 时间
        self.timeLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.timeLabel.textColor = UIColor().colorWithHexString(hex: "878787")
        self.contentView.addSubview(self.timeLabel)
        self.timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15 * WIDTH_SCALE)
            make.top.equalTo(self.typeLabel.snp.bottom).offset(5 * HEIGHT_SCALE)
        }


        // 积分数量
        self.amonutLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.contentView.addSubview(self.amonutLabel)
        self.amonutLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-15 * WIDTH_SCALE)
            make.top.bottom.equalTo(self.contentView)
        }
        
        let lineView : UIView = UIView()
        lineView.backgroundColor = LINE_COLOR2
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
    }
}
