//
//  PersonFooterView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/29.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class PersonFooterView: BasicView {
    var recommendBtn : UIButton = UIButton()// 推荐按钮
    
    // 创建UI
    override func createUI() {
        super.createUI()
        self.backgroundColor = UIColor.white
        
        // 为我精准推荐
        self.recommendBtn.setTitle("为我精准推荐", for: UIControlState.normal)
        self.recommendBtn.backgroundColor = UIColor.lightGray
        self.recommendBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18 * WIDTH_SCALE)
        self.recommendBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.recommendBtn.backgroundColor = NAVIGATION_COLOR
        self.recommendBtn.layer.cornerRadius = 45 * HEIGHT_SCALE / 2
        self.recommendBtn.layer.shadowOffset = CGSize.zero
        self.recommendBtn.layer.shadowOpacity = 0.8
        self.recommendBtn.layer.shadowRadius = 15
        self.recommendBtn.layer.shadowColor = NAVIGATION_COLOR.cgColor
        self.addSubview(self.recommendBtn)
        self.recommendBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(10 * HEIGHT_SCALE)
            make.centerX.equalTo(self)
            make.width.equalTo(295 * WIDTH_SCALE)
            make.height.equalTo(45 * HEIGHT_SCALE)
        }
        
        let label : UILabel = UILabel()
        label.text = "完善认证信息，审核通过更容易，预估额度更高"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        label.textColor = UIColor().colorWithHexString(hex: "666666")
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.recommendBtn.snp.bottom).offset(20 * HEIGHT_SCALE)
        }
    }
}
