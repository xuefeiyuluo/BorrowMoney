//
//  OrderDetailTitleCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/8.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class OrderDetailTitleCell: BasicViewCell {
    var iconImage : UIImageView = UIImageView()// 机构LOGO
    var titleLabel : UILabel = UILabel()// 机构名称
    var orderDetail : OrderDetailModel?{
        didSet{
            if orderDetail != nil {
                // 机构LOGO
                self.iconImage.kf.setImage(with: URL (string: (orderDetail?.loanChannelLogo)!), placeholder: UIImage (named: "defaultWait"), options: nil, progressBlock: nil, completionHandler: nil)
                
                // 机构名称
                if !(orderDetail?.loanChannelName.isEmpty)! && !(orderDetail?.loanName.isEmpty)! {
                    self.titleLabel.text = String (format: "%@-%@",(self.orderDetail?.loanChannelName)!,(self.orderDetail?.loanName)!)
                } else {
                    if !(orderDetail?.loanChannelName.isEmpty)! {
                        self.titleLabel.text = self.orderDetail?.loanChannelName
                    } else if !(orderDetail?.loanName.isEmpty)! {
                        self.titleLabel.text = self.orderDetail?.loanName
                    }
                }
            }
        }
    }
    

    // 创建界面
    override func createUI() {
        super.createUI()
        
        // 机构LOGO
        self.contentView.addSubview(self.iconImage)
        self.iconImage.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15 * WIDTH_SCALE)
            make.width.equalTo(40 * WIDTH_SCALE)
            make.centerY.equalTo(self.contentView)
            make.height.equalTo(40 * HEIGHT_SCALE)
        }
        
        // 机构名称
        self.titleLabel.textColor = TEXT_SECOND_COLOR
        self.titleLabel.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconImage.snp.right).offset(10 * WIDTH_SCALE)
            make.top.bottom.equalTo(self.contentView)
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
