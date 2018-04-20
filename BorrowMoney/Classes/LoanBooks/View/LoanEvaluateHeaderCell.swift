//
//  LoanEvaluateHeaderCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/13.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class LoanEvaluateHeaderCell: BasicViewCell {
    var countLabel : UILabel = UILabel()// 共xx条
    var promptLabel : UILabel = UILabel()// 无评论的提示信息
    var titleView : UIView = UIView()// 头部View
    var markView : HotSearchView = HotSearchView()// 标签View
    var evaluateModel : LoanEvaluateModel? {
        didSet{
            // 共xx条
            self.countLabel.text = String (format: "共%@条", (evaluateModel?.commentCount)!)
            
            // 标签
            self.markView.frame = CGRect (x: 10 * WIDTH_SCALE, y: 0, width: SCREEN_WIDTH - 20 * WIDTH_SCALE, height: 10000)
            self.markView.createUI(dataArray: (evaluateModel?.markArray)!)
        }
    }
    

    // 创建界面
    override func createUI() {
        super.createUI()
        
        self.contentView.addSubview(self.titleView)
        self.titleView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(30 * HEIGHT_SCALE)
        }
        
        // 图标
        let imageView : UIImageView = UIImageView()
        imageView.image = UIImage (named: "textImage.png")
        imageView.contentMode = .center
        self.titleView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.titleView)
            make.left.equalTo(10 * WIDTH_SCALE)
            make.width.equalTo(22 * WIDTH_SCALE)
        }
        
        let titleLabel : UILabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        titleLabel.text = "用户评价"
        titleLabel.textColor = NAVIGATION_COLOR
        self.titleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.titleView)
            make.left.equalTo(imageView.snp.right)
        }
        
        self.countLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.countLabel.textColor = LINE_COLOR3
        self.titleView.addSubview(self.countLabel)
        self.countLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.right).offset(15 * WIDTH_SCALE)
            make.top.bottom.equalTo(self.titleView)
        }
        
        let lineView : UIView = UIView()
        lineView.backgroundColor = LINE_COLOR2
        self.titleView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.titleView)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        // 标签View
        self.markView.textColor = LINE_COLOR3
        self.contentView.addSubview(self.markView)
        self.markView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.contentView)
            make.left.equalTo(self.contentView.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.contentView.snp.right).offset(-10 * WIDTH_SCALE)
            make.top.equalTo(self.titleView.snp.bottom).offset(10 * HEIGHT_SCALE)
        }
        
        
        self.promptLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.promptLabel.textColor = LINE_COLOR3
        self.promptLabel.text = "该产品暂无用户评价"
        self.promptLabel.isHidden =  true
        self.promptLabel.textAlignment = .center
        self.contentView.addSubview(self.promptLabel)
        self.promptLabel.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(self.contentView)
        }
    }
}
