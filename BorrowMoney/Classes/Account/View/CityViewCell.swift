//
//  CityViewCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/2.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class CityViewCell: BasicViewCell {
    var nameLabel : UILabel = UILabel()// 城市名称
    var cityModel : CityModel?{
        didSet{
            self.nameLabel.text = cityModel?.zone_name
        }
    }
    
    
    // 创建界面
    override func createUI() {
        super.createUI()
        
        self.nameLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.nameLabel.textColor = TEXT_SECOND_COLOR
        self.contentView.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.left.equalTo(self.contentView.snp.left).offset(15 * WIDTH_SCALE)
        }
        
        let lineView : UIView = UIView()
        lineView.backgroundColor = LINE_COLOR2
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(0.5 * HEIGHT_SCALE)
        }
        
    }

}
