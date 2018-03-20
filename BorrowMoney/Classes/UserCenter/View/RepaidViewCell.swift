//
//  RepaidViewCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/20.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class RepaidViewCell: BasicViewCell {
    var termText : UIButton = UIButton ()// 期限/总期数
    var amountText : UIButton = UIButton ()// 还款金额
    var dateLabel : UILabel = UILabel()// 还款日
    var stateLabel : UILabel = UILabel()// 还款情况
    var repaidImage : UIButton = UIButton ()// 是否选中
    var planModel : PlanModel? {
        didSet{
            // 期限/总期数
            self.termText.setTitle(planModel?.period, for: UIControlState.normal)
            
            // 还款金额
            self.amountText.setTitle(planModel?.repayAmount, for: UIControlState.normal)
            
            // 还款日
            self.dateLabel.text = planModel?.repayDate
            
            // 还款情况
            self.stateLabel.text = planModel?.statusStr
            
            // 是否选中
            if (planModel?.selectedId)! {
                self.repaidImage.setImage(UIImage (named: "repaidSelected.png"), for: UIControlState.normal)
            } else {
                self.repaidImage.setImage(UIImage (named: "repaidNormal.png"), for: UIControlState.normal)
            }
        }
    }
    
    

    // 创建界面
    override func createUI() {
        super.createUI()
        
        // 期限/总期数
        self.termText.titleLabel?.font = UIFont.systemFont(ofSize: 10 * WIDTH_SCALE)
        self.termText.setTitleColor(TEXT_SECOND_COLOR, for: UIControlState.normal)
        self.termText.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        self.termText.titleEdgeInsets = UIEdgeInsetsMake(0, 10 * WIDTH_SCALE, 0, 0)
        self.contentView.addSubview(self.termText)
        self.termText.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(self.contentView)
            make.width.equalTo((SCREEN_WIDTH - 20 * WIDTH_SCALE) / 5)
        }
        
        // 还款金额
        self.amountText.titleLabel?.font = UIFont.systemFont(ofSize: 10 * WIDTH_SCALE)
        self.amountText.setTitleColor(TEXT_SECOND_COLOR, for: UIControlState.normal)
        self.amountText.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        self.amountText.titleEdgeInsets = UIEdgeInsetsMake(0, 5 * WIDTH_SCALE, 0, 0)
        self.contentView.addSubview(self.amountText)
        amountText.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.left.equalTo(self.termText.snp.right)
            make.width.equalTo((SCREEN_WIDTH - 20 * WIDTH_SCALE) / 5)
        }
        
        // 还款日
        self.dateLabel.font = UIFont.systemFont(ofSize: 10 * WIDTH_SCALE)
        self.dateLabel.textColor = TEXT_SECOND_COLOR
        self.dateLabel.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.left.equalTo(self.amountText.snp.right)
            make.width.equalTo(((SCREEN_WIDTH - 20 * WIDTH_SCALE) / 25) * 6)
        }
        
        // 还款情况
        self.stateLabel.font = UIFont.systemFont(ofSize: 10 * WIDTH_SCALE)
        self.stateLabel.textColor = TEXT_SECOND_COLOR
        self.stateLabel.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(self.stateLabel)
        self.stateLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.left.equalTo(self.dateLabel.snp.right)
            make.width.equalTo(((SCREEN_WIDTH - 20 * WIDTH_SCALE) / 25) * 4.5)
        }
        
        // 是否选中
        self.contentView.addSubview(self.repaidImage)
        self.repaidImage.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.left.equalTo(self.stateLabel.snp.right).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.contentView.snp.right).offset(-10 * WIDTH_SCALE)
        }
    }
}
