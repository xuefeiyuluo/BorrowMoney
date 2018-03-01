//
//  FixedAdverView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/30.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

typealias AdverClickBlock = (_ url : String) -> Void
class FixedAdverView: BasicView {

    var adverClickBlock : AdverClickBlock?
    var leftBtn : UIButton?// 左边的按钮
    var rightBtn : UIButton?// 右边的按钮
    var adverArray : NSArray?// 数据源
    
    
    // 创建界面
    override func createUI() -> Void {
        let leftBtn : UIButton = UIButton.init(type: UIButtonType.custom)
        leftBtn.tag = 300
        leftBtn.addTarget(self, action: #selector(tapClick(sender:)), for: UIControlEvents.touchUpInside)
        self.leftBtn = leftBtn
        self.addSubview(leftBtn)
        leftBtn.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(self)
            make.width.equalTo(SCREEN_WIDTH / 2)
        }
        
        let rightBtn : UIButton = UIButton.init(type: UIButtonType.custom)
        rightBtn.tag = 400
        rightBtn.addTarget(self, action: #selector(tapClick(sender:)), for: UIControlEvents.touchUpInside)
        self.rightBtn = rightBtn
        self.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (make) in
            make.top.right.bottom.equalTo(self)
            make.width.equalTo(SCREEN_WIDTH / 2)
        }
    }

    
    // 按钮的点击事件
    func tapClick(sender : UIButton) -> Void {
        if self.adverClickBlock != nil {
            var bannerModel : BannerModel?//
            if sender.tag == 300 {
                bannerModel = self.adverArray?[0] as? BannerModel
            } else {
                bannerModel = self.adverArray?[1] as? BannerModel
            }
            if bannerModel != nil {
                self.adverClickBlock!((bannerModel?.address)!)
            }
        }
    }


    // 数据更新
    func updateFixedAdverData(dataArray : NSArray) -> Void {
        if dataArray.count > 0 {
            self.adverArray = dataArray
            for i in 0 ..< dataArray.count {
                let tempBanner : BannerModel = dataArray[i] as! BannerModel
                if i == 0 {
                    self.leftBtn?.kf.setBackgroundImage(with: URL.init(string: tempBanner.logo!), for: UIControlState.normal)
                } else {
                    self.rightBtn?.kf.setBackgroundImage(with: URL.init(string: tempBanner.logo!), for: UIControlState.normal)
                }
            }
        }
    }
}
