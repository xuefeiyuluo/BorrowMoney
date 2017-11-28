//
//  UserCollectionViewCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/14.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    var titleLabel : UILabel?
    var imageView : UIImageView?
    
    // "titileName":"贷款计算器","imageName":"ic_jsq.png"
    var dataDict : NSDictionary? {
        didSet {
            self.imageView?.image = UIImage (named: (dataDict?["imageName"] as? String)!)
            self.titleLabel?.text = dataDict?["titileName"] as? String
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
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        self.imageView = imageView
        self.contentView .addSubview(self.imageView!)
        self.imageView?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.width.height.equalTo(26 * WIDTH_SCALE)
            make.top.equalTo(self.contentView.snp.top).offset((self.contentView.frame.size.height - 37 * WIDTH_SCALE) / 2)
        })
        
        
        let titleLabel : UILabel = UILabel()
        titleLabel.font = UIFont .systemFont(ofSize: 12 * WIDTH_SCALE)
        titleLabel.textColor = TEXT_BLACK_COLOR
        titleLabel.textAlignment = .center
        self.titleLabel = titleLabel
        self.contentView .addSubview(self.titleLabel!)
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.imageView?.snp.bottom)!).offset(2 * HEIGHT_SCALE)
            make.left.right.equalTo(self.contentView)
            make.height.equalTo(15 * HEIGHT_SCALE)
        })
        
    }
}
