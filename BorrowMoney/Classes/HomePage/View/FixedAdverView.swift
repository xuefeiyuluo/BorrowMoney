//
//  FixedAdverView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/30.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

typealias AdverClickBlock = (Int) -> Void
class FixedAdverView: UIView {

    var adverClickBlock : AdverClickBlock?
    var leftBtn : UIButton?// 左边的按钮
    var rightBtn : UIButton?// 右边的按钮
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 创建界面
        createUI()
    }
    
    
    // 创建界面
    func createUI() -> Void {
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
            make.top.left.bottom.equalTo(self)
            make.width.equalTo(SCREEN_WIDTH / 2)
        }
    }

    
    // 按钮的点击事件
    func tapClick(sender : UIButton) -> Void {
        if self.adverClickBlock != nil {
            self.adverClickBlock!(sender.tag)
        }
    }


    // 数据更新
    func updateFixedAdverData() -> Void {
        self.leftBtn?.kf.setBackgroundImage(with: URL.init(string: ""), for: UIControlState.normal)
        self.rightBtn?.kf.setBackgroundImage(with: URL.init(string: ""), for: UIControlState.normal)
    }


}
