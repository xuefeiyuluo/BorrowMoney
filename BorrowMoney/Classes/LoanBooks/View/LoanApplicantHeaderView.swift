//
//  LoanApplicantHeaderView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/13.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias HeaderBlock = (Int) -> Void
class LoanApplicantHeaderView: BasicView {
    var iconImageView : UIImageView = UIImageView()// 图标
    var titleLabel : UILabel = UILabel()// 标题信息
    var stateLabel : UILabel = UILabel()// 状态
    let arrowImageView : UIImageView = UIImageView()// 是否展开
    let backBtn : UIButton = UIButton()
    var headerBlock : HeaderBlock?// 头部的点击事件
    var applicantModel : ApplicantModel? {
        didSet{
            // 图标
            self.iconImageView.kf.setImage(with: URL (string: (applicantModel?.catLogo)!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            // 标题信息
            self.titleLabel.text = applicantModel?.catName
            
            // 状态
            if ASSERLOGIN! {
                self.stateLabel.text = "已完成"
                self.stateLabel.textColor = NAVIGATION_COLOR
                for regulaModel : ApplyRegulaModel in (applicantModel?.attrList)! {
                    if regulaModel.selectValue.isEmpty {
                        self.stateLabel.text = "未完成"
                        self.stateLabel.textColor = TEXT_SECOND_COLOR
                        continue
                    }
                }
            } else {
                self.stateLabel.text = "未完成"
                self.stateLabel.textColor = TEXT_SECOND_COLOR
            }
            
            // 是否展开
            if (applicantModel?.applicantState)! {
                self.arrowImageView.image = UIImage (named: "applicantUp")
            } else {
                self.arrowImageView.image = UIImage (named: "applicantDown")
            }
            
            self.backBtn.tag = (applicantModel?.applicantGroup)!
        }
    }
    

    // 创建UI
    override func createUI() {
        super.createUI()
        self.backgroundColor = UIColor.white
        
        // 图标
        self.addSubview(self.iconImageView)
        self.iconImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.width.equalTo(28 * WIDTH_SCALE)
            make.height.equalTo(28 * WIDTH_SCALE)
            make.left.equalTo(self.snp.left).offset(12 * WIDTH_SCALE)
        }
        
        // 标题信息
        self.titleLabel.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        self.titleLabel.textColor = TEXT_SECOND_COLOR
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(self.iconImageView.snp.right).offset(12 * WIDTH_SCALE)
        }
        
        // 是否展开
        self.arrowImageView.contentMode = .center
        self.addSubview(self.arrowImageView)
        self.arrowImageView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.right.equalTo(self.snp.right).offset(-6 * WIDTH_SCALE)
            make.width.equalTo(30 * WIDTH_SCALE)
        }
        
        // 状态
        self.stateLabel.textAlignment = .right
        self.stateLabel.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        self.addSubview(self.stateLabel)
        self.stateLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.arrowImageView.snp.left)
            make.top.bottom.equalTo(self)
        }
        
        let lineView : UIView = UIView()
        lineView.backgroundColor = LINE_COLOR2
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        self.backBtn.addTarget(self, action: #selector(headerClick(sender:)), for: UIControlEvents.touchUpInside)
        self.addSubview(self.backBtn)
        self.backBtn.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self)
        }
    }
    
    
    // 头部的点击事件
    func headerClick(sender : UIButton) -> Void {
        if self.headerBlock != nil {
            self.headerBlock!(sender.tag)
        }
    }
}
