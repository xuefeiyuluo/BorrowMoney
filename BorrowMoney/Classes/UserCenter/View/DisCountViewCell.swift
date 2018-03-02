//
//  DisCountViewCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/2.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class DisCountViewCell: BasicViewCell {
    var backImage : UIImageView = UIImageView()// 背景图片
    var iconImage : UIImageView = UIImageView()// icon图标
    var nameLabel : UILabel = UILabel()// 红包来源
    var mechanismLabel : UILabel = UILabel()// 发红包机构
    var dateLabel : UILabel = UILabel()// 时间
    var amountLabel : UILabel = UILabel()// 红包金额
    var stateLabel : UILabel = UILabel()// 红包状态
    var useImage : UIImageView = UIImageView()// 箭头>图标
    var openBtn : UIButton = UIButton()// 红包未拆的点击事件
    var openImageView : UIImageView = UIImageView()// 已拆红包的图片
    var discountModel : DiscountModel? {
        didSet{
            
        }
    }
    

    // 创建界面
    override func createUI() {
        super.createUI()
        
        // 背景图片
        self.backImage.image = UIImage (named: "discountUnopened.png")
        self.backImage.isUserInteractionEnabled = true
        self.contentView.addSubview(self.backImage)
        self.backImage.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.contentView)
        }
        
        // icon图片
        self.iconImage.backgroundColor = UIColor.purple
        self.iconImage.contentMode = UIViewContentMode.center
        self.iconImage.layer.cornerRadius = (70 * WIDTH_SCALE) / 2
        self.iconImage.layer.masksToBounds = true
        self.contentView.addSubview(self.iconImage)
        self.iconImage.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(10 * WIDTH_SCALE)
            make.width.equalTo(70 * WIDTH_SCALE)
            make.top.equalTo(self.contentView.snp.top).offset(15 * WIDTH_SCALE)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-15 * WIDTH_SCALE)
        }
        
        // 红包来源
        self.nameLabel.text = "通用免息卷"
        self.nameLabel.textColor = UIColor.black
        self.nameLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.contentView.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(20 * HEIGHT_SCALE)
            make.left.equalTo(self.iconImage.snp.right).offset(12 * WIDTH_SCALE)
        }
        
        // 发红包机构
        self.mechanismLabel.text = "fdhsvf"
        self.mechanismLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.contentView.addSubview(self.mechanismLabel)
        self.mechanismLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconImage.snp.right).offset(10 * WIDTH_SCALE)
            make.top.equalTo(self.nameLabel.snp.bottom).offset(10 * HEIGHT_SCALE)
        }
        
        // 时间
        self.dateLabel.text = "2018-01-23"
        self.dateLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.contentView.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconImage.snp.right).offset(10 * WIDTH_SCALE)
            make.top.equalTo(self.mechanismLabel.snp.bottom).offset(10 * HEIGHT_SCALE)
        }
        
        let rightView : UIView = UIView()
        self.contentView.addSubview(rightView)
        rightView.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self.contentView)
            make.width.equalTo(90 * WIDTH_SCALE)
        }
        
        // 红包金额
        self.amountLabel.text = "10.00"
        self.amountLabel.textColor = UIColor().colorWithHexString(hex: "FF583A")
        self.amountLabel.font = UIFont.systemFont(ofSize: 23 * WIDTH_SCALE)
        self.contentView.addSubview(self.amountLabel)
        self.amountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(rightView.snp.top).offset(22 * HEIGHT_SCALE)
            make.left.equalTo(rightView.snp.left).offset(10 * WIDTH_SCALE)
        }
        
        // 红包状态
        self.stateLabel.text = "去使用"
        self.stateLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.contentView.addSubview(self.stateLabel)
        self.stateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(rightView.snp.left).offset(10 * WIDTH_SCALE)
            make.top.equalTo(self.amountLabel.snp.bottom).offset(10 * HEIGHT_SCALE)
        }
        
        // 箭头>图标
        self.useImage.contentMode = UIViewContentMode.center
        self.useImage.image = UIImage (named: "promptArrow.png")
        self.contentView.addSubview(self.useImage)
        self.useImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.stateLabel.snp.centerY)
            make.right.equalTo(rightView.snp.right).offset(-8 * WIDTH_SCALE)
            make.height.equalTo(30 * HEIGHT_SCALE)
            make.width.equalTo(25 * WIDTH_SCALE)
        }
        
        self.openBtn.tag = 888
        self.contentView.addSubview(self.openBtn)
        self.openBtn.snp.makeConstraints { (make) in
            make.right.left.top.bottom.equalTo(rightView)
        }
        
        self.contentView.addSubview(self.openImageView)
        self.openImageView.snp.makeConstraints { (make) in
            make.right.left.top.bottom.equalTo(rightView)
        }
        
    }
}
