//
//  SearchNavigationView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/30.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class SearchNavigationView: UIView {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = NAVIGATION_COLOR
        
        // 创建界面
        createUI()
    }
    
    
    // 创建界面
    func createUI() -> Void {
    
    }

}
