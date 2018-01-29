//
//  SortViewCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/1/25.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class SortViewCell: UITableViewCell {
    lazy var contenLabel : UILabel = UILabel()
    lazy var shoWImageView : UIImageView = UIImageView()
    var loanType : LoanAmountType? {
        didSet {
            if (loanType?.typeSelected)! {
                self.shoWImageView.image = UIImage (named: "sortSelected.png")
            } else {
                self.shoWImageView.image = UIImage (named: "")
            }
            self.contenLabel.text = loanType?.sortName
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 创建UI
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // 创建UI
    func createUI() -> Void {
        
        // 选择 选中
        let imageView : UIImageView = UIImageView()
        imageView.contentMode = UIViewContentMode.center
        self.shoWImageView = imageView
        self.contentView.addSubview(self.shoWImageView)
        self.shoWImageView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.right.equalTo(self.contentView.snp.right).offset(-10 * WIDTH_SCALE)
            make.width.equalTo(30 * WIDTH_SCALE)
        }
        
        // 内容信息
        let contentLabel : UILabel = UILabel()
        contentLabel.textColor = UIColor().colorWithHexString(hex: "777777")
        contentLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.contenLabel = contentLabel
        self.contentView.addSubview(self.contenLabel)
        self.contenLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.left.equalTo(self.contentView.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.shoWImageView.snp.left).offset(-10 * WIDTH_SCALE)
        }
        
        // 横线
        let lineView : UIView = UIView()
        lineView.backgroundColor = UIColor().colorWithHexString(hex: "AAAAAA")
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.contentView)
            make.left.equalTo(self.contentView.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.contentView.snp.right).offset(-10 * WIDTH_SCALE)
            make.height.equalTo(0.5 * HEIGHT_SCALE)
        }
    }

}
