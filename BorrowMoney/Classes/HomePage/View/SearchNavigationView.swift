//
//  SearchNavigationView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/30.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class SearchNavigationView: UIView {
    var cancelBtn : UIButton?// 取消按钮
    var searchBar : UISearchBar?// 搜索框
    
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
        // 取消按钮
        let cancelBtn : UIButton = UIButton (type: UIButtonType.custom)
        cancelBtn.setTitle("取消", for: UIControlState.normal)
        cancelBtn.titleLabel?.font = UIFont .systemFont(ofSize: 14 * WIDTH_SCALE)
        cancelBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.cancelBtn = cancelBtn
        self.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(self)
            make.top.equalTo(self.snp.top).offset(20)
            make.width.equalTo(50 * WIDTH_SCALE)
        }
        
        // 搜索框
        let searchBar : UISearchBar = UISearchBar()
        searchBar.keyboardType = UIKeyboardType.default
        searchBar.backgroundColor = UIColor.clear
        searchBar.placeholder = "搜索产品/关键字"
        searchBar.becomeFirstResponder()
        // 去除UISearchBar的背景图片
        for view : UIView in searchBar.subviews {
            if view.isKind(of: UIView.self) && view.subviews.count > 0 {
                (view.subviews[0]).removeFromSuperview()
                break;
            }
        }
        let searchField : UITextField = searchBar.value(forKey: "searchField") as! UITextField
        searchField.layer.cornerRadius = 14
        searchField.layer.masksToBounds = true
        
        self.searchBar = searchBar
        self.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top).offset(20 + 5 * HEIGHT_SCALE)
            make.height.equalTo(34 * HEIGHT_SCALE)
            make.right.equalTo((self.cancelBtn?.snp.left)!)
        }
    }
}
