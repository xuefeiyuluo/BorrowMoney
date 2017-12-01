//
//  ProductViewCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/30.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class ProductViewCell: UICollectionViewCell {
    var iconImage : UIImageView?// 产品图标
    var productName : UILabel?// 产品名称
    var model : BannerModel? {
        didSet{
            // 图标
            self.iconImage?.kf.setImage(with: URL (string: (model?.logo)!))
            
            // 产品名称
            self.productName?.text = model?.name
        }
    }
    
    
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
        // 产品图标
        let iconImage : UIImageView = UIImageView()
        iconImage.isUserInteractionEnabled = true
        iconImage.contentMode = .scaleToFill
        self.iconImage = iconImage
        self.contentView.addSubview(self.iconImage!)
        self.iconImage?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentView.snp.top).offset(12 * HEIGHT_SCALE)
            make.height.width.equalTo(46 * HEIGHT_SCALE)
            make.centerX.equalTo(self.contentView.snp.centerX)
        })
        
        // 产品名称
        let loanName : UILabel = UILabel()
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
}
