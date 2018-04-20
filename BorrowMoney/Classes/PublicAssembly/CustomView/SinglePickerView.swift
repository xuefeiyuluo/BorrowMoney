//
//  SinglePickerView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/20.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class SinglePickerView: BasicView {
    let backBtn : UIButton = UIButton()// 背景的点击事件
    var pickerView : UIPickerView = UIPickerView()// 选择器
    var pickerData : [String] = [String]()// 数据源
    

    override func createUI() {
        super.createUI()
        
        // 背景的点击事件
        self.backBtn.addTarget(self, action: #selector(backClick), for: UIControlEvents.touchUpInside)
        self.addSubview(backBtn)
        self.backBtn.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self)
        }
    }
    
    
    // 背景的点击事件
    func backClick() -> Void {
        // 移除弹框
        removePickerView()
    }
    
    
    // 移除弹框
    func removePickerView() -> Void {
        self.removeFromSuperview()
    }
    
}
