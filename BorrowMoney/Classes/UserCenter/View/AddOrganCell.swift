//
//  AddOrganCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/21.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class AddOrganCell: BasicViewCell {
    var loanIconImage : UIImageView = UIImageView()// 贷款图标
    var loanName : UILabel = UILabel()// 贷款名称
    var organModel : OrganModel?{
        didSet{
            // 贷款图标
            self.loanIconImage.kf.setImage(with:URL (string: (organModel?.logo)!), placeholder: UIImage (named: "defaultWait.png"), options: nil, progressBlock: nil, completionHandler: nil)
            
            // 贷款名称
            self.loanName.text = organModel?.name
        }
    }

    
    // 创建界面
    override func createUI() {
        super.createUI()
        
        // 贷款图标
        self.contentView.addSubview(self.loanIconImage)
        self.loanIconImage.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15 * WIDTH_SCALE)
            make.centerY.equalTo(self.contentView)
            make.width.equalTo(40 * WIDTH_SCALE)
            make.height.equalTo(40 * WIDTH_SCALE)
        }
        
        // 贷款名称
        self.loanName.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        self.loanName.textColor = TEXT_SECOND_COLOR
        self.contentView.addSubview(self.loanName)
        self.loanName.snp.makeConstraints { (make) in
            make.left.equalTo(self.loanIconImage.snp.right).offset(10 * WIDTH_SCALE)
            make.top.bottom.equalTo(self.contentView)
        }
        
        let lineView : UIView = UIView()
        lineView.backgroundColor = LINE_COLOR2
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self.contentView)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
    }
}
