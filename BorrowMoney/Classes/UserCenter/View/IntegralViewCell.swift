//
//  IntegralViewCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/4.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class IntegralViewCell: BasicViewCell {
    var titleLabel : UILabel = UILabel()// 标题
    var subLabel : UILabel = UILabel()// 副标题
    var stateLabel : UILabel = UILabel()// 状态
    var intergralModel : IntergralModel? {
        didSet{
            if intergralModel != nil {
                let times : Int = Int((intergralModel?.haveTimes)!)!
                if intergralModel?.taskType == "0" {
                    if times > 0 {
                        // 标题
                        self.titleLabel.text = intergralModel?.taskName
                        // 副标题
                        self.subLabel.isHidden = true
                        // 状态
                        self.stateLabel.text = String (format: "+%@", (intergralModel?.giveGold)!)
                        self.stateLabel.textColor = UIColor().colorWithHexString(hex: "ff5a30")
                    } else {
                        // 标题
                        self.titleLabel.text = intergralModel?.taskName
                        // 副标题
                        self.subLabel.isHidden = false
                        self.subLabel.text = String (format: "+%@", (intergralModel?.giveGold)!)
                        self.subLabel.textColor = UIColor().colorWithHexString(hex: "ff5a30")
                        // 状态
                        self.stateLabel.text = "已完成"
                        self.stateLabel.textColor = LINE_COLOR3
                    }
                } else {
                    if times > 0 {
                        // 标题
                        self.titleLabel.text = intergralModel?.taskName
                        // 副标题
                        self.subLabel.isHidden = false
                        self.subLabel.text = String (format: "还可完成%@", (intergralModel?.haveTimes)!)
                        self.subLabel.textColor = LINE_COLOR3
                        
                        // 状态
                        self.stateLabel.text = String (format: "+%@", (intergralModel?.giveGold)!)
                        self.stateLabel.textColor = UIColor().colorWithHexString(hex: "ff5a30")
                    } else {
                        // 标题
                        self.titleLabel.text = intergralModel?.taskName
                        // 副标题
                        self.subLabel.isHidden = false
                        self.subLabel.text = String (format: "+%@", (intergralModel?.giveGold)!)
                        self.subLabel.textColor = UIColor().colorWithHexString(hex: "ff5a30")
                        // 状态
                        self.stateLabel.text = "已完成"
                        self.stateLabel.textColor = LINE_COLOR3
                    }
                }
            }
        }
    }
    

    // 创建界面
    override func createUI() {
        super.createUI()
        
        // 标题
        self.titleLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.left.equalTo(self.contentView.snp.left).offset(15 * WIDTH_SCALE)
            make.width.greaterThanOrEqualTo(60 * WIDTH_SCALE)
            
        }
        
        // 副标题
        self.subLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.subLabel.textColor = UIColor().colorWithHexString(hex: "FF5240")
        self.contentView.addSubview(self.subLabel)
        self.subLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.left.equalTo(self.titleLabel.snp.right)
        }
        
        let imageView : UIImageView = UIImageView()
        imageView.contentMode = UIViewContentMode.center
        imageView.image = UIImage (named: "promptArrow.png")
        self.contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.width.equalTo(25 * WIDTH_SCALE)
            make.right.equalTo(self.contentView.snp.right).offset(-5 * WIDTH_SCALE)
        }
        
        // 状态
        self.stateLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.stateLabel.textColor = UIColor().colorWithHexString(hex: "FF5240")
        self.contentView.addSubview(self.stateLabel)
        self.stateLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.right.equalTo(imageView.snp.left)
        }
        
        // 横线
        let lineView : UIView = UIView()
        lineView.backgroundColor = LINE_COLOR2
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(self.contentView)
            make.left.equalTo(self.contentView.snp.left).offset(15 * WIDTH_SCALE)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
    }

}
