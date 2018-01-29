//
//  DropViewCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/12/26.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class DropViewCell: UICollectionViewCell {
    var contentLabel : UILabel?
    
    var loanType : LoanAmountType? {
        didSet{
            if loanType?.type == "amount" {
                self.contentLabel?.text = loanType?.desc
            } else if loanType?.type == "type" {
                self.contentLabel?.text = loanType?.tagName
            }
            
            if (loanType?.typeSelected)! {
                self.contentLabel?.textColor = NAVIGATION_COLOR
                self.contentLabel?.layer.borderColor = NAVIGATION_COLOR.cgColor
            } else {
                self.contentLabel?.textColor = UIColor().colorWithHexString(hex: "777777")
                self.contentLabel?.layer.borderColor = UIColor().colorWithHexString(hex: "777777").cgColor
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 创建UI
        createUI()
    }
    
    
    // 创建UI
    func createUI() -> Void {
        let contentLabel : UILabel = UILabel()
        contentLabel.isUserInteractionEnabled = true
        contentLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        contentLabel.layer.borderWidth = 1 * WIDTH_SCALE
        contentLabel.layer.cornerRadius = 2 * WIDTH_SCALE
        contentLabel.layer.masksToBounds = true
        contentLabel.textAlignment = NSTextAlignment.center
        self.contentLabel = contentLabel
        self.contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self.contentView)
        }
    }
}
