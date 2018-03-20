//
//  AccountManageCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/20.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class AccountManageCell: BasicViewCell {
    var iconImageView : UIImageView = UIImageView()// 图标
    var accountLabel : UILabel = UILabel()// 账号
    var channelLabel : UILabel = UILabel()// 贷款名称
    
    // 图标
    // 账号
    // 贷款名称

    // 创建界面
    override func createUI() {
        super.createUI()
        
        // 图标
        self.iconImageView.backgroundColor = UIColor.purple
        self.contentView.addSubview(self.iconImageView)
        self.iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(6 * WIDTH_SCALE)
            make.centerY.equalTo(self.contentView)
            make.height.equalTo(50 * WIDTH_SCALE)
            make.width.equalTo(50 * WIDTH_SCALE)
        }
        
        // 账号
        self.accountLabel.text = "1221432432"
        self.accountLabel.textColor = TEXT_SECOND_COLOR
        self.accountLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.contentView.addSubview(self.accountLabel)
        self.accountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(10 * HEIGHT_SCALE)
            make.left.equalTo(self.iconImageView.snp.right).offset(15 * WIDTH_SCALE)
        }
        
        // 贷款名称
        self.channelLabel.text = "前站"
        self.channelLabel.textColor = UIColor().colorWithHexString(hex: "A7A7A7")
        self.channelLabel.backgroundColor = UIColor().colorWithHexString(hex: "FFFBF5")
        self.channelLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.contentView.addSubview(self.channelLabel)
        self.channelLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.accountLabel.snp.bottom).offset(10 * HEIGHT_SCALE)
            make.left.equalTo(self.accountLabel)
            make.height.equalTo(11 * HEIGHT_SCALE)
        }
        
        // 箭头
        let enterImage : UIImageView = UIImageView()
        enterImage.contentMode = UIViewContentMode.center
        enterImage.image = UIImage (named: "promptArrow.png")
        self.contentView.addSubview(enterImage)
        enterImage.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.right.equalTo(self.contentView.snp.right).offset(-10 * WIDTH_SCALE)
        }
        
        // 横线
        let lineView : UIView = UIView()
        lineView.backgroundColor = LINE_COLOR2
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self.contentView)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
    }
}
