//
//  CaptialNullDataView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/2/28.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class CaptialNullDataView: BasicView {

    // 创建UI
    override func createUI() {
        let imageView : UIImageView = UIImageView()
        imageView.contentMode = UIViewContentMode.center
        imageView.image = UIImage (named: "capitalNone.png")
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.right.left.equalTo(self)
            make.height.equalTo(150 * HEIGHT_SCALE)
            make.top.equalTo(80 * HEIGHT_SCALE)
        }
        
        let label : UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 17 * WIDTH_SCALE)
        label.textColor = UIColor().colorWithHexString(hex: "777777")
        label.text = "暂无资金明细"
        label.textAlignment = NSTextAlignment.center
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(imageView.snp.bottom).offset(25 * HEIGHT_SCALE)
        }
    }
}
