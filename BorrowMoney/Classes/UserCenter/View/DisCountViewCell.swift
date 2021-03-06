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
    var nameLabel : UILabel = UILabel()// 红包名称
    var mechanismLabel : UILabel = UILabel()// 发红包机构
    var dateLabel : UILabel = UILabel()// 时间
    var amountLabel : UILabel = UILabel()// 红包金额
    var stateLabel : UILabel = UILabel()// 红包状态
    var useImage : UIImageView = UIImageView()// 箭头>图标
    var openBtn : UIButton = UIButton()// 红包未拆的点击事件
    var openImageView : UIImageView = UIImageView()// 已拆红包的图片
    var discountModel : DiscountModel? {
        didSet{
            weak var weakSelf = self
            // logo
            self.iconImage.kf.setImage(with: URL (string: (discountModel?.url)!), placeholder: UIImage (named: ""), options: nil, progressBlock: nil) { (image, error, typr, imageUrl) in
                if weakSelf?.discountModel?.statusCode == "1" {
                    weakSelf?.iconImage.image = image
                }
            }
        
            // 红包名称
            self.nameLabel.text = discountModel?.name
            
            // 发红包机构
            self.mechanismLabel.text = discountModel?.content
            
            // 时间
            self.dateLabel.text = String (format: "有效期至%@", (discountModel?.endTime)!)
            
            // 红包金额
            self.amountLabel.text = String (format: "%@.00", (discountModel?.packetAmount)!)
            
            // 背景图片   "0"未打开  “1”已打开  “2”已过期
            if discountModel?.statusCode == "0" {
                self.backImage.image = UIImage (named: "discountUnopened.png")
                self.nameLabel.textColor = TEXT_SECOND_COLOR
                self.mechanismLabel.textColor = LINE_COLOR3
                self.dateLabel.textColor = LINE_COLOR3
                self.amountLabel.textColor = UIColor().colorWithHexString(hex: "ff5a30")
                self.stateLabel.text = "去使用"
                self.stateLabel.textColor = LINE_COLOR3
                self.useImage.isHidden = false
                self.openBtn.isHidden = false
                self.openImageView.image = UIImage (named: "")
                self.openImageView.isHidden = true
            } else if discountModel?.statusCode == "1" {
                self.backImage.image = UIImage (named: "DiscountOpen.png")
                self.nameLabel.textColor = TEXT_SECOND_COLOR
                self.mechanismLabel.textColor = LINE_COLOR3
                self.dateLabel.textColor = LINE_COLOR3
                self.amountLabel.textColor = LINE_COLOR3
                self.stateLabel.text = "已使用"
                self.stateLabel.textColor = LINE_COLOR3
                self.useImage.isHidden = true
                self.openBtn.isHidden = true
                self.openImageView.image = UIImage (named: "")
                self.openImageView.isHidden = true
            } else {
                self.backImage.image = UIImage (named: "discountOverdue.png")
                self.nameLabel.textColor = LINE_COLOR2
                self.mechanismLabel.textColor = LINE_COLOR2
                self.dateLabel.textColor = LINE_COLOR2
                self.amountLabel.textColor = LINE_COLOR2
                self.stateLabel.text = ""
                self.stateLabel.textColor = LINE_COLOR2
                self.useImage.isHidden = true
                self.openBtn.isHidden = true
                self.openImageView.image = UIImage (named: "overdueIcon.png")
                self.openImageView.isHidden = false
            }
        }
    }
    

    // 创建界面
    override func createUI() {
        super.createUI()
        
        // 背景图片
        self.backImage.isUserInteractionEnabled = true
        self.contentView.addSubview(self.backImage)
        self.backImage.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.contentView)
        }
        
        // icon图片
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
        
        // 红包名称
        self.nameLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.contentView.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(20 * HEIGHT_SCALE)
            make.left.equalTo(self.iconImage.snp.right).offset(12 * WIDTH_SCALE)
        }
        
        // 发红包机构
        self.mechanismLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.contentView.addSubview(self.mechanismLabel)
        self.mechanismLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconImage.snp.right).offset(10 * WIDTH_SCALE)
            make.top.equalTo(self.nameLabel.snp.bottom).offset(10 * HEIGHT_SCALE)
        }
        
        // 时间
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
        self.amountLabel.font = UIFont.systemFont(ofSize: 23 * WIDTH_SCALE)
        self.contentView.addSubview(self.amountLabel)
        self.amountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(rightView.snp.top).offset(22 * HEIGHT_SCALE)
            make.left.equalTo(rightView.snp.left).offset(10 * WIDTH_SCALE)
        }
        
        // 红包状态
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
