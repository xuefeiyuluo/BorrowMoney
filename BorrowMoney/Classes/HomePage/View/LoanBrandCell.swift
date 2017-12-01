//
//  LoanBrandCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/30.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class LoanBrandCell: UITableViewCell {
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
            if !self.isEmptyAndNil(str: (hotModel?.apply_count)!) {
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
            if !self.isEmptyAndNil(str: (hotModel?.descriptions)!) {
                self.contentLabel?.isHidden = false
                self.contentLabel?.text = hotModel?.descriptions
            } else {
                self.contentLabel?.isHidden = true
            }
        }
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 创建界面
        createUI()
    }
    
    
    // 创建界面
    func createUI() -> Void {
        // 产品logo
        let channelLabel : UIImageView = UIImageView()
        channelLabel.contentMode = .scaleToFill
        self.channelLogo = channelLabel
        self.contentView.addSubview(self.channelLogo!)
        self.channelLogo?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15 * WIDTH_SCALE)
            make.height.width.equalTo(55 * HEIGHT_SCALE)
            make.top.equalTo(self.contentView.snp.top).offset(10 * HEIGHT_SCALE)
        })
        
        // 产品名称
        let nameLabel : UILabel = UILabel()
        nameLabel.textColor = TEXT_BLACK_COLOR
        nameLabel.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        self.channelName = nameLabel
        self.contentView.addSubview(self.channelName!)
        self.channelName?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.channelLogo?.snp.top)!)
            make.left.equalTo((self.channelLogo?.snp.right)!).offset(8 * WIDTH_SCALE)
        })
        
        // 申请人数
        let personLabel : UILabel = UILabel()
        personLabel.textColor = TEXT_LIGHT_COLOR
        personLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.loanNumber = personLabel
        self.contentView.addSubview(self.loanNumber!)
        self.loanNumber?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self.channelName!)
            make.right.equalTo(self.contentView.snp.right).offset(-15 * WIDTH_SCALE)
        })
        
        // 贷款金额区间
        let amountLabel : UILabel = UILabel()
        amountLabel.textColor = NAVIGATION_COLOR
        amountLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.loanSection = amountLabel
        self.contentView.addSubview(self.loanSection!)
        self.loanSection?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.channelName?.snp.bottom)!).offset(3 * HEIGHT_SCALE)
            make.left.equalTo((self.channelName?.snp.left)!)
        })

        // 贷款额度
        let amountInfoLabel : UILabel = UILabel()
        amountInfoLabel.textColor = TEXT_LIGHT_COLOR
        amountInfoLabel.text = "可贷额度"
        amountInfoLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.contentView.addSubview(amountInfoLabel)
        amountInfoLabel.snp.makeConstraints({ (make) in
            make.top.equalTo((self.loanSection?.snp.bottom)!).offset(3 * HEIGHT_SCALE)
            make.left.equalTo((self.channelName?.snp.left)!)
        })

        // 中间竖线
        let lineView: UIView = UIView()
        lineView.backgroundColor = LINE_COLOR2
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.top.equalTo(self.loanSection!)
            make.bottom.equalTo(amountInfoLabel)
            make.width.equalTo(1 * WIDTH_SCALE)
        }
        
        // 贷款利率
        let rateLabel : UILabel = UILabel()
        rateLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        rateLabel.textColor = TEXT_LIGHT_COLOR
        self.loanRate = rateLabel
        self.contentView.addSubview(self.loanRate!)
        self.loanRate?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.loanSection?.snp.top)!)
            make.left.equalTo(lineView.snp.right).offset(15 * WIDTH_SCALE)
        })
        
        // 贷款利率单位
        let rateInfoLabel : UILabel = UILabel()
        rateInfoLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        rateInfoLabel.textColor = TEXT_LIGHT_COLOR
        self.loanRateInfo = rateInfoLabel
        self.contentView.addSubview(self.loanRateInfo!)
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
        self.contentView.addSubview(self.fastLoan!)
        self.fastLoan?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.loanNumber!)
            make.width.equalTo(65 * WIDTH_SCALE)
            make.bottom.equalTo(amountInfoLabel)
            make.height.equalTo(25 * HEIGHT_SCALE)
        })
        
        
        let lineView2 : UIView = UIView()
        lineView2.backgroundColor = LINE_COLOR2
        self.contentView.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.right.left.equalTo(self.contentView)
            make.height.equalTo(1 * HEIGHT_SCALE)
            make.top.equalTo((self.channelLogo?.snp.bottom)!).offset(10 * HEIGHT_SCALE)
        }
        
        // 产品简介
        let detailLabel : UILabel = UILabel()
        detailLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        detailLabel.textColor = TEXT_LIGHT_COLOR
        self.contentLabel = detailLabel
        self.contentView.addSubview(self.contentLabel!)
        self.contentLabel?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self.contentView)
            make.left.equalTo(self.contentView.snp.left).offset(15 * WIDTH_SCALE)
            make.top.equalTo(lineView2.snp.bottom)
        })
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
