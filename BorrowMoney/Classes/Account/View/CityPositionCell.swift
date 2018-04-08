//
//  CityPositionCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/2.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias RepositionBlock = (String) -> Void
class CityPositionCell: BasicViewCell {
    var cityName : UILabel = UILabel()// 城市名称
    var repositionBlock : RepositionBlock?// 重新定位后的城市
    let location : ObtainLocationInfo = ObtainLocationInfo()// 定位
    
    // 创建界面
    override func createUI() {
        super.createUI()
        
        let imageView : UIImageView = UIImageView()
        imageView.image = UIImage (named: "cityPosition")
        imageView.contentMode = .center
        self.contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.left.equalTo(self.contentView.snp.left).offset(15 * WIDTH_SCALE)
            make.width.equalTo(15 * WIDTH_SCALE)
        }
        
        // 城市名称
        self.cityName.text = "上海"
        self.cityName.textColor = LINE_COLOR3
        self.cityName.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.contentView.addSubview(self.cityName)
        self.cityName.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.left.equalTo(imageView.snp.right).offset(2 * WIDTH_SCALE)
        }
        
        // 重新定位
        let positionBtn : UIButton = UIButton (type: UIButtonType.custom)
        positionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        positionBtn.setTitle("重新定位", for: UIControlState.normal)
        positionBtn.setTitleColor(UIColor().colorWithHexString(hex: "009CFF"), for: UIControlState.normal)
        positionBtn.addTarget(self, action: #selector(repositionClick), for: UIControlEvents.touchUpInside)
        self.contentView.addSubview(positionBtn)
        positionBtn.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.right.equalTo(self.contentView.snp.right).offset(-15 * WIDTH_SCALE)
        }
        
        // 横线
        let lineView : UIView = UIView()
        lineView.backgroundColor = UIColor().colorWithHexString(hex: "009CFF")
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView.snp.centerY).offset(9 * HEIGHT_SCALE)
            make.left.right.equalTo(positionBtn)
            make.height.equalTo(0.5 * HEIGHT_SCALE)
        }
    }
    
    
    // 重新定位
    func repositionClick() -> Void {
        weak var weakSelf = self
        self.cityName.text = "正在定位中...."
        
        // 开始定位
        location.startLocation()
        location.locationBlock = {(state,string) in
            if !state {
                SVProgressHUD.showInfo(withStatus: string)
                weakSelf?.cityName.text = "上海"
            } else {
                weakSelf?.cityName.text = string
            }
        }
    }
}
