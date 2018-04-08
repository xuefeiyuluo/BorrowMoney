//
//  SearchView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/2.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias CancelBlock = () -> Void
typealias SearchBlock = (String) -> Void
class SearchView: BasicView, UISearchBarDelegate {
    var lineView : UIView = UIView()// 横线
    var searchBar : UISearchBar = UISearchBar()// 搜索框
    var cancelBlock :CancelBlock?// 取消按钮的回调
    var searchBlock : SearchBlock?// 字符串搜索回调

    // 创建UI
    override func createUI() {
        super.createUI()
        self.backgroundColor = UIColor.white
        
        // 搜索框
        self.searchBar.keyboardType = UIKeyboardType.default
        self.searchBar.backgroundColor = UIColor.clear
        self.searchBar.placeholder = "搜索产品/关键字"
        self.searchBar.delegate = self
        self.searchBar.resignFirstResponder()
        // 去除UISearchBar的背景图片
        for view : UIView in searchBar.subviews {
            if view.isKind(of: UIView.self) && view.subviews.count > 0 {
                (view.subviews[0]).removeFromSuperview()
                break;
            }
        }
        
        self.addSubview(self.searchBar)
        self.searchBar.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.snp.top).offset(3 * HEIGHT_SCALE)
            make.height.equalTo(34 * HEIGHT_SCALE)
        }
        
        // 横线
        self.lineView.backgroundColor = NAVIGATION_COLOR
        self.lineView.isHidden = true
        self.addSubview(self.lineView)
        self.lineView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self)
            make.height.equalTo(0.5 * HEIGHT_SCALE)
        }
    }
    
    
    // MARK: UISearchBarDelegate
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.searchBar.showsCancelButton = true
        self.lineView.isHidden = false
        if self.searchBlock != nil {
            self.searchBlock!("")
        }
        return true
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
        self.lineView.isHidden = true
        self.searchBar.resignFirstResponder()
        if self.cancelBlock != nil {
            self.cancelBlock!()
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if self.searchBlock != nil {
            self.searchBlock!(searchBar.text!)
        }
    }
}
