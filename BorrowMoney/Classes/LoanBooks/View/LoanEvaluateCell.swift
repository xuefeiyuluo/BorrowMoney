//
//  LoanEvaluateCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/13.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class LoanEvaluateCell: BasicViewCell {
    var headerView : UIView = UIView()// 头部View
    var userLabel : UILabel = UILabel()// 用户
    var timeLabel : UILabel = UILabel()// 时间
    var bottomView : UIView = UIView()// 底部部View
    var applyLabel : UILabel = UILabel()// 申请信息
    var evaluatView : UIView = UIView()// 评价View
    var starView : UIView = UIView()// 评价星星的View
    var markView : HotSearchView = HotSearchView()// 标签View
    var contentLabel : UILabel = UILabel()// 评价内容
    var uiArray : [UIImageView] = [UIImageView]()// 评价星星数组
    
    // 创建界面
    override func createUI() {
        super.createUI()
        // 创建头部UI
        createHeaderUI()
        
        // 创建底部UI
        createBottomUI()
        
        // 创建评价UI
        createEvaluatUI()
    }
    
    
    // 创建头部UI
    func createHeaderUI() -> Void {
        self.contentView.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.contentView)
            make.height.equalTo(30 * HEIGHT_SCALE)
        }
        
        // 用户
        self.userLabel.text = String (format: "用户%@", "13838383838")
        self.userLabel.textColor = UIColor().colorWithHexString(hex: "5A5A5A")
        self.userLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.headerView.addSubview(self.userLabel)
        self.userLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.headerView)
            make.left.equalTo(self.headerView.snp.left).offset(10 * WIDTH_SCALE)
        }
        
        // 时间
        self.timeLabel.text = "2016-12-12"
        self.timeLabel.textColor = UIColor().colorWithHexString(hex: "5A5A5A")
        self.timeLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.headerView.addSubview(self.timeLabel)
        self.timeLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.headerView)
            make.right.equalTo(self.headerView.snp.right).offset(-10 * WIDTH_SCALE)
        }
        
        
        let lineView : UIView = UIView()
        lineView.backgroundColor = LINE_COLOR2
        self.headerView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.headerView)
            make.left.equalTo(self.headerView.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.headerView.snp.right).offset(-10 * WIDTH_SCALE)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
    }
    
    
    // 创建底部UI
    func createBottomUI() -> Void {
        self.contentView.addSubview(self.bottomView)
        self.bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(30 * HEIGHT_SCALE)
        }
        
        
        // 申请信息
        self.applyLabel.text = String (format: "申请时间:%@   申请金额:%@", "2016-12-12","10000")
        self.applyLabel.textColor = UIColor().colorWithHexString(hex: "5A5A5A")
        self.applyLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.headerView.addSubview(self.applyLabel)
        self.applyLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.bottomView)
            make.left.equalTo(self.bottomView.snp.left).offset(10 * WIDTH_SCALE)
        }
        
        
        let lineView1 : UIView = UIView()
        lineView1.backgroundColor = LINE_COLOR2
        self.bottomView.addSubview(lineView1)
        lineView1.snp.makeConstraints { (make) in
            make.top.equalTo(self.bottomView)
            make.left.equalTo(self.bottomView.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.bottomView.snp.right).offset(-10 * WIDTH_SCALE)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        
        let lineView2 : UIView = UIView()
        lineView2.backgroundColor = LINE_COLOR2
        self.bottomView.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self.bottomView)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
    }
    
    
    // 创建评价UI
    func createEvaluatUI() -> Void {
        self.contentView.addSubview(self.evaluatView)
        self.evaluatView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(self.headerView.snp.bottom)
            make.bottom.equalTo(self.bottomView.snp.top)
        }
        
        // 星星的View
        self.evaluatView.addSubview(self.starView)
        self.starView.snp.makeConstraints { (make) in
            make.top.equalTo(self.evaluatView)
            make.left.equalTo(self.evaluatView.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.evaluatView.snp.right).offset(-10 * WIDTH_SCALE)
            make.height.equalTo(25 * HEIGHT_SCALE)
        }
        
        
        // 五颗星星
        for i in 0 ..< 5 {
            let imageView : UIImageView = UIImageView()
            imageView.contentMode = .center
            imageView.image = UIImage (named: "evaluatStar1.png")
            self.starView.addSubview(imageView)
            imageView.snp.makeConstraints { (make) in
                make.left.equalTo(self.starView.snp.left).offset(CGFloat(i * 16) * WIDTH_SCALE)
                make.top.bottom.equalTo(self.starView)
                make.width.equalTo(16 * WIDTH_SCALE)
            }
            self.uiArray.append(imageView)
        }
        
        
        // 标签View
        self.markView.backgroundColor = UIColor.red
        self.evaluatView.addSubview(self.markView)
        self.markView.snp.makeConstraints { (make) in
            make.left.equalTo(self.evaluatView.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.evaluatView.snp.right).offset(-10 * WIDTH_SCALE)
            make.top.equalTo(self.starView.snp.bottom)
            make.height.equalTo(20 * HEIGHT_SCALE)
        }
        
        // 评价内容
        self.contentLabel.text = "虚心好评阿迪达斯"
        self.contentLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.contentLabel.textColor = TEXT_SECOND_COLOR
        self.contentLabel.numberOfLines = 0
        self.evaluatView.addSubview(self.contentLabel)
        self.contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.evaluatView.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.evaluatView.snp.right).offset(-10 * WIDTH_SCALE)
            make.bottom.equalTo(self.evaluatView.snp.bottom).offset(-10 * HEIGHT_SCALE)
        }
    }
}
