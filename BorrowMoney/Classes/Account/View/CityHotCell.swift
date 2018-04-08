//
//  CityHotCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/2.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias HotCityBlock = (String) -> Void
class CityHotCell: BasicViewCell {
    var baseView : UIView = UIView()
    var hotCityBlock : HotCityBlock?//获取选中的城市
    var hotArray : [CityModel]? {
        didSet{
            let count : Int = (hotArray?.count)!
            let labelWidth : CGFloat = (SCREEN_WIDTH - 20 * WIDTH_SCALE) / 3
            for i in 0 ..< count {
                let model : CityModel = hotArray![i]
                let text : UIButton = UIButton (type: UIButtonType.custom)
                text.setTitle(model.zone_name, for: UIControlState.normal)
                text.titleLabel?.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
                text.tag = i
                text.setTitleColor(UIColor.black, for: UIControlState.normal)
                text.addTarget(self, action: #selector(tapClick(sender:)), for: UIControlEvents.touchUpInside)
                self.baseView.addSubview(text)
                let row : Int = i / 3
                let column : Int = i % 3
                text.snp.makeConstraints({ (make) in
                    make.top.equalTo(self.baseView.snp.top).offset(CGFloat(row * 40) * HEIGHT_SCALE)
                    make.left.equalTo(self.baseView.snp.left).offset(CGFloat(column) * labelWidth * WIDTH_SCALE)
                    make.width.equalTo(labelWidth)
                    make.height.equalTo(40 * HEIGHT_SCALE)
                })
            }
        }
    }
    

    // 创建界面
    override func createUI() {
        super.createUI()
        self.contentView.backgroundColor = UIColor.white
        
        self.contentView.addSubview(self.baseView)
        self.baseView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(5 * WIDTH_SCALE)
            make.right.equalTo(self.contentView.snp.right).offset(-15 * WIDTH_SCALE)
            make.top.bottom.equalTo(self.contentView)
        }
    }
    
    
    // 按钮的点击事件
    func tapClick(sender: UIButton) -> Void {
        if self.hotCityBlock != nil {
            let model : CityModel = self.hotArray![sender.tag]
            self.hotCityBlock!(model.zone_name)
        }
    }
}
