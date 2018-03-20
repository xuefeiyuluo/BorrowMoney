//
//  recommendCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/14.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class recommendCell: BasicViewCell {
    var channelLogo : UIImageView?// 产品logo
    var channelName : UILabel?// 产品名称
    var loanSection : UILabel?// 贷款金额区间
    var loanRate : UILabel?// 贷款利率
    var loanRateInfo : UILabel?// 贷款利率单位
    var contentLabel : UILabel?// 产品简介
    var loanNumber : UILabel?// 申请人数
    var fastLoan : UIButton?// 一键申请
    var hotModel : HotLoanModel? {
        didSet{
            // 产品logo
            self.channelLogo?.kf.setImage(with: URL (string: (hotModel?.logo)!))
            
            // 产品名称
            self.channelName?.text = String (format: "%@-%@", (hotModel?.channelName)!,(hotModel?.name)!)
            
            // 申请人数
            if !(hotModel?.apply_count?.isEmpty)! {
                self.loanNumber?.text = (hotModel?.apply_count)! + "人申请"
            }
            
            // 贷款金额区间
            let min : Float  = Float((hotModel?.minAmount)!)! / 10000
            let max : Float  = Float((hotModel?.maxAmount)!)! / 10000
            self.loanSection?.text = String (format: "%.2f-%.2f万",min,max)
            
            // 贷款利率 贷款利率单位
            if hotModel?.interestUnit == "0" {
                self.loanRate?.text = String (format: "%.2f%", Double((hotModel?.interestValue)!)! / 100)
                self.loanRateInfo?.text = "参考日利率"
            } else if hotModel?.interestUnit == "1" {
                self.loanRate?.text = String (format: "%.2f%%", Double((hotModel?.interestValue)!)! / 100)
                self.loanRateInfo?.text = "参考月利率"
            } else {
                self.loanRate?.text = ""
                self.loanRateInfo?.text = ""
            }
            
            // 产品简介
            if !(hotModel?.descriptions?.isEmpty)! {
                self.contentLabel?.isHidden = false
                self.contentLabel?.text = hotModel?.descriptions
            } else {
                self.contentLabel?.isHidden = true
            }
        }
    }
    
    
    // 创建界面
    override func createUI() {
        super.createUI()

        self.contentView.backgroundColor = MAIN_COLOR
        let backView : UIView = UIView()
        backView.backgroundColor = UIColor.white
        self.contentView.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-10 * HEIGHT_SCALE)
        }
        
        // 产品logo
        let channelLabel : UIImageView = UIImageView()
        channelLabel.contentMode = .scaleToFill
        self.channelLogo = channelLabel
        backView.addSubview(self.channelLogo!)
        self.channelLogo?.snp.makeConstraints({ (make) in
            make.left.equalTo(backView.snp.left).offset(15 * WIDTH_SCALE)
            make.height.width.equalTo(55 * HEIGHT_SCALE)
            make.top.equalTo(backView.snp.top).offset(10 * HEIGHT_SCALE)
        })
        
        // 产品名称
        let nameLabel : UILabel = UILabel()
        nameLabel.textColor = TEXT_BLACK_COLOR
        nameLabel.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        self.channelName = nameLabel
        backView.addSubview(self.channelName!)
        self.channelName?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.channelLogo?.snp.top)!)
            make.left.equalTo((self.channelLogo?.snp.right)!).offset(8 * WIDTH_SCALE)
        })
        
        // 申请人数
        let personLabel : UILabel = UILabel()
        personLabel.textColor = TEXT_LIGHT_COLOR
        personLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.loanNumber = personLabel
        backView.addSubview(self.loanNumber!)
        self.loanNumber?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self.channelName!)
            make.right.equalTo(backView.snp.right).offset(-15 * WIDTH_SCALE)
        })
        
        // 贷款金额区间
        let amountLabel : UILabel = UILabel()
        amountLabel.textColor = NAVIGATION_COLOR
        amountLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.loanSection = amountLabel
        backView.addSubview(self.loanSection!)
        self.loanSection?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.channelName?.snp.bottom)!).offset(3 * HEIGHT_SCALE)
            make.left.equalTo((self.channelName?.snp.left)!)
        })
        
        // 贷款额度
        let amountInfoLabel : UILabel = UILabel()
        amountInfoLabel.textColor = TEXT_LIGHT_COLOR
        amountInfoLabel.text = "可贷额度"
        amountInfoLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        backView.addSubview(amountInfoLabel)
        amountInfoLabel.snp.makeConstraints({ (make) in
            make.top.equalTo((self.loanSection?.snp.bottom)!).offset(3 * HEIGHT_SCALE)
            make.left.equalTo((self.channelName?.snp.left)!)
        })
        
        // 中间竖线
        let lineView: UIView = UIView()
        lineView.backgroundColor = LINE_COLOR2
        backView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.centerX.equalTo(backView.snp.centerX)
            make.top.equalTo(self.loanSection!)
            make.bottom.equalTo(amountInfoLabel)
            make.width.equalTo(1 * WIDTH_SCALE)
        }
        
        // 贷款利率
        let rateLabel : UILabel = UILabel()
        rateLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        rateLabel.textColor = TEXT_LIGHT_COLOR
        self.loanRate = rateLabel
        backView.addSubview(self.loanRate!)
        self.loanRate?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.loanSection?.snp.top)!)
            make.left.equalTo(lineView.snp.right).offset(15 * WIDTH_SCALE)
        })
        
        // 贷款利率单位
        let rateInfoLabel : UILabel = UILabel()
        rateInfoLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        rateInfoLabel.textColor = TEXT_LIGHT_COLOR
        self.loanRateInfo = rateInfoLabel
        backView.addSubview(self.loanRateInfo!)
        self.loanRateInfo?.snp.makeConstraints({ (make) in
            make.top.equalTo(amountInfoLabel)
            make.left.equalTo(lineView.snp.right).offset(15 * WIDTH_SCALE)
        })
        
        // 一键申请
        let fastBtn : UIButton = UIButton (type: UIButtonType.custom)
        fastBtn.setTitle("一键申请", for: UIControlState.normal)
        fastBtn.setTitleColor(NAVIGATION_COLOR, for: UIControlState.normal)
        fastBtn.layer.cornerRadius = 2 * WIDTH_SCALE
        fastBtn.layer.borderColor = NAVIGATION_COLOR.cgColor
        fastBtn.layer.borderWidth = 1 * WIDTH_SCALE
        fastBtn.layer.masksToBounds = true
        fastBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.fastLoan = fastBtn
        backView.addSubview(self.fastLoan!)
        self.fastLoan?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.loanNumber!)
            make.width.equalTo(65 * WIDTH_SCALE)
            make.bottom.equalTo(amountInfoLabel)
            make.height.equalTo(25 * HEIGHT_SCALE)
        })
        
        
        let lineView2 : UIView = UIView()
        lineView2.backgroundColor = LINE_COLOR2
        backView.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.right.left.equalTo(backView)
            make.height.equalTo(1 * HEIGHT_SCALE)
            make.top.equalTo((self.channelLogo?.snp.bottom)!).offset(10 * HEIGHT_SCALE)
        }
        
        // 产品简介
        let detailLabel : UILabel = UILabel()
        detailLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        detailLabel.textColor = TEXT_LIGHT_COLOR
        self.contentLabel = detailLabel
        backView.addSubview(self.contentLabel!)
        self.contentLabel?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(backView)
            make.left.equalTo(backView.snp.left).offset(15 * WIDTH_SCALE)
            make.top.equalTo(lineView2.snp.bottom)
        })
        
    }
}
