//
//  BasicView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/2/27.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class BasicView: UIView {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 初始化数据
        initializationData()
        
        // 创建UI
        createUI()
    }

    
    // 创建UI
    func createUI() -> Void {
        
    }
    
    
    // 初始化数据
    func initializationData() -> Void {
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
