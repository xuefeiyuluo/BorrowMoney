//
//  ProductViewCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/30.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

typealias ImageTapBlock = (Int) -> Void
class ProductViewCell: UICollectionViewCell {
    var iconImage : UIImageView?// 产品图标
    var productName : UILabel?// 产品名称
    var imageTapBlock : ImageTapBlock?// 图片的点击回调
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        // 创建UI
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // 创建UI
    func createUI() -> Void {
        
        let iconImage : UIImageView = UIImageView()
        iconImage.isUserInteractionEnabled = true
        iconImage.backgroundColor = UIColor.purple
        iconImage.contentMode = .center
        self.iconImage = iconImage
        self.contentView.addSubview(self.iconImage!)
        self.iconImage?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentView.snp.top).offset(12 * HEIGHT_SCALE)
            make.height.width.equalTo(46 * HEIGHT_SCALE)
            make.centerX.equalTo(self.contentView.snp.centerX)
        })
        let tap : UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(imageClick(sender:)))
        self.iconImage?.addGestureRecognizer(tap)
        
        
        let loanName : UILabel = UILabel()
        loanName.text = "小额可带";
        loanName.font = UIFont.systemFont(ofSize: 11 * HEIGHT_SCALE)
        loanName.textAlignment = NSTextAlignment.center
        loanName.textColor = TEXT_BLACK_COLOR
        self.productName = loanName
        self.contentView.addSubview(loanName)
        loanName.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-2 * HEIGHT_SCALE)
            make.height.equalTo(15 * HEIGHT_SCALE)
        }
    }
    
    
    // 图片的点击事件
    func imageClick(sender : UIImageView) -> Void {
        if self.imageTapBlock != nil {
            self.imageTapBlock!(sender.tag)
        }
    }
    
}
