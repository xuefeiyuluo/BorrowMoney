//
//  NaviBarView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/10/16.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class NaviBarView: UIView {

    func setUpNaviBarWithTitle(title : String) -> UILabel {
        let label = UILabel (frame: CGRect (x: 0, y: 0, width: 40 * WIDTH_SCALE, height: 40 * HEIGHT_SCALE))
        label.font = UIFont .systemFont(ofSize: 18 * HEIGHT_SCALE)
        label.textColor = UIColor .white
        label.text = title
        return label
    }

    func setUpNaviBarWithTitle(title : String, imageName : String) -> UIView {
        let view = UIView (frame: CGRect (x: 0, y: 0, width: 125 * WIDTH_SCALE, height: 44))
        
        let label = UILabel (frame: CGRect (x: 0, y: 7, width: 125 * WIDTH_SCALE, height: 17))
        label.font = UIFont .systemFont(ofSize: 17 * HEIGHT_SCALE)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        label.text = title
        view .addSubview(label)
        
        let imageView = UIImageView (frame: CGRect (x: 0, y: 28, width: 125, height: 11 * HEIGHT_SCALE))
        imageView.image = UIImage (named: imageName)
        view .addSubview(imageView)
        
        return view
    }
    

    func addBarButtonItem(target : Any,action : Selector) -> UIBarButtonItem {
        let comeBackButton = UIButton (type: .custom)
        comeBackButton .setImage(UIImage (named: "nav_btn_back"), for: .normal)
        comeBackButton .setImage(UIImage (named: "nav_btn_back"), for: .highlighted)
        comeBackButton .setTitle("返回", for: .normal)
        comeBackButton .frame = CGRect (x: 0, y: 0, width: 60, height: 30)
        comeBackButton .titleLabel?.font = UIFont .systemFont(ofSize: 14 * WIDTH_SCALE)
        comeBackButton .addTarget(target, action: action, for: UIControlEvents .touchUpInside)
        comeBackButton .imageEdgeInsets = UIEdgeInsetsMake(5, -20, 5, 0)
        comeBackButton .titleEdgeInsets = UIEdgeInsetsMake(0, -11, 0, 0)
        let leftItem = UIBarButtonItem (customView: comeBackButton)
        return leftItem
    }
}
