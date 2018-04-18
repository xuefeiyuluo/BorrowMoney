//
//  LoanDetailConditionView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/11.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias ConditionBlock = () -> Void
class LoanDetailConditionCell: BasicViewCell {
    var titleLabel : UILabel = UILabel()// 头部标题
    var contentLabel : UILabel = UILabel()// 内容
    var moreView : UIView = UIView()// 点击显示全部
    var moreBtn : UIButton = UIButton()// 展示全部
    var conditionBlock : ConditionBlock?// 显示全部的点击事件
    

    // 创建UI
    override func createUI() {
        super.createUI()
        
        let lineView1 : UIView = UIView()
        lineView1.backgroundColor = LINE_COLOR2
        self.addSubview(lineView1)
        lineView1.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }

        let spotImageView : UIImageView = UIImageView()
        spotImageView.image = UIImage (named: "loanSpot")
        spotImageView.contentMode = .center
        self.addSubview(spotImageView)
        spotImageView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self)
            make.width.equalTo(35 * WIDTH_SCALE)
            make.height.equalTo(35 * WIDTH_SCALE)
        }

        // 头部标题
        self.titleLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.titleLabel.textColor = TEXT_SECOND_COLOR
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(spotImageView)
            make.left.equalTo(spotImageView.snp.right)
        }
        
        let lineView2 : UIView = UIView()
        lineView2.backgroundColor = LINE_COLOR2
        self.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.right.equalTo(self)
            make.top.equalTo(spotImageView.snp.bottom).offset(-1 * HEIGHT_SCALE)
            make.height.equalTo(1 * HEIGHT_SCALE)
            make.left.equalTo(self.snp.left).offset(15 * WIDTH_SCALE)
        }

        self.contentLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.contentLabel.textColor = LINE_COLOR3
        self.contentLabel.numberOfLines = 0
        self.addSubview(self.contentLabel)
        self.contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(spotImageView.snp.bottom).offset(5 * HEIGHT_SCALE)
            make.height.equalTo(30 * HEIGHT_SCALE)
            make.right.equalTo(self.snp.right).offset(-30 * WIDTH_SCALE)
            make.left.equalTo(self.snp.left).offset(30 * WIDTH_SCALE)
        }
        
        // 点击显示更多的View
        createMoreView()
    }
    
    
    // 点击显示更多的View
    func createMoreView() -> Void {
        self.addSubview(self.moreView)
        self.moreView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(35 * HEIGHT_SCALE)
        }
        
        let lineView : UIView = UIView()
        lineView.backgroundColor = LINE_COLOR2
        self.moreView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.right.top.equalTo(self.moreView)
            make.height.equalTo(1 * HEIGHT_SCALE)
            make.left.equalTo(self.moreView.snp.left).offset(15 * WIDTH_SCALE)
        }
        
        // 显示全部文案
        self.moreBtn.addTarget(self, action: #selector(moreClick), for: UIControlEvents.touchUpInside)
        self.moreView.addSubview(self.moreBtn)
        self.moreBtn.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self.moreView)
            make.top.equalTo(lineView.snp.bottom)
        }
        
        let lineView2 : UIView = UIView()
        lineView2.backgroundColor = LINE_COLOR2
        self.moreView.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.right.left.bottom.equalTo(self.moreView)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
    }
    
    
    
    // 更新界面View
    func updateConditionView(title : String,text : String,state : Bool) -> Void {
        // 头部标题
        self.titleLabel.text = title
        
        // 内容
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4 * HEIGHT_SCALE
        let size : CGSize = self.sizeWithAttributeText(text: text, font: UIFont.systemFont(ofSize: 14 * WIDTH_SCALE), maxSize: CGSize.init(width: SCREEN_WIDTH - 60 * WIDTH_SCALE, height: CGFloat(MAXFLOAT)), paragraphStyle: paragraphStyle)
        
        self.contentLabel.snp.updateConstraints { (make) in
            make.height.equalTo(size.height + 1)
        }
        self.moreView.snp.updateConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom)
        }
        
        if state {
            self.moreBtn.setImage(UIImage (named: "applicantDown"), for: UIControlState.normal)
            self.moreView.isHidden = false
            self.contentLabel.numberOfLines = 0
        } else {
            if size.height < 105 * HEIGHT_SCALE {
                self.moreView.isHidden = true
                self.contentLabel.numberOfLines = 0
            } else {
                self.moreBtn.setImage(UIImage (named: "applicantUp"), for: UIControlState.normal)
                self.moreView.isHidden = false
                self.contentLabel.numberOfLines = 5
            }
        }
        
        
        self.contentLabel.attributedText = self.setTextLineSpace(text: text, lineSpacing: 4 * HEIGHT_SCALE, font: UIFont.systemFont(ofSize: 14 * WIDTH_SCALE))
    }
    

    // 显示全部的点击事件
    func moreClick() -> Void {
        if self.conditionBlock != nil {
            self.conditionBlock!()
        }
    }
}
