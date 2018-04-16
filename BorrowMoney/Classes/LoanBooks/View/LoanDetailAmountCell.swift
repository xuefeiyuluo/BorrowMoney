//
//  LoanDetailAmountView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/11.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias TremsBlock = () -> Void
typealias QuestionBlock = () -> Void
class LoanDetailAmountCell: BasicViewCell {
    let upperView : UIView = UIView()// 上半部分View
    let lowerView : UIView = UIView()// 下半部分View
    var loanAmount : UITextField = UITextField()// 贷款金额
    var loanTerm : UITextField = UITextField()// 贷款期限
    var amountFooterLabel : UILabel = UILabel()// 金额范围
    var termFooterLabel : UILabel = UILabel()// 期限范围
    let tremBtn : UIButton = UIButton ()// 期限选择
    var interestRateView : UIView = UIView()// 参考利率View
    var rateLabel : UILabel = UILabel()// 利率
    var rateTextLabel : UILabel = UILabel()// 利率文案
    var lenderDaterView : UIView = UIView()// 时间View
    var dateImageView : UIImageView = UIImageView()
    var dateBtn : UIButton = UIButton ()// ?号弹框
    var dateLabel : UILabel = UILabel()// 时间
    var dateTextLabel : UILabel = UILabel()// 时间文案
    var repayAmountView : UIView = UIView()// 还款金额View
    var amountBtn : UIButton = UIButton ()// ?号弹框
    var amountLabel : UILabel = UILabel()// 金额
    var amountTextLabel : UILabel = UILabel()// 金额文案
    var tremsBlock : TremsBlock?// 期限的回调
    var questionBlock : QuestionBlock?// 疑问的回调
    
    
    // 贷款金额
    // 贷款期限
    // 金额范围
    // 期限范围
    // 利率
    // 利率文案
    // 时间
    // 时间文案
    // 金额
    // 金额文案
    
    // 创建UI
    override func createUI() {
        super.createUI()
        
        // 上半部分View
        createUpperView()
        
        // 下半部分View
        createLowerView()
    }
    
    
    // 上半部分View
    func createUpperView() -> Void {
        self.addSubview(self.upperView)
        self.upperView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(110 * HEIGHT_SCALE)
        }
        
        let lineView1 : UIView = UIView()
        lineView1.backgroundColor = LINE_COLOR2
        self.upperView.addSubview(lineView1)
        lineView1.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.upperView)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        let leftView : UIView = UIView()
        self.upperView.addSubview(leftView)
        leftView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self.upperView)
            make.width.equalTo(SCREEN_WIDTH / 2)
        }

        // 贷款金额
        self.loanAmount.textColor = NAVIGATION_COLOR
        self.loanAmount.text = "10000"
        self.loanAmount.font = UIFont.systemFont(ofSize: 25 * WIDTH_SCALE)
        self.loanAmount.textAlignment = .center
        self.loanAmount.borderStyle = .roundedRect
        leftView.addSubview(self.loanAmount)
        self.loanAmount.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(leftView)
            make.height.equalTo(35 * HEIGHT_SCALE)
            make.width.equalTo(110 * WIDTH_SCALE)
        }

        let amountHeaderLabel : UILabel = UILabel()
        amountHeaderLabel.text = "借款金额/元"
        amountHeaderLabel.textAlignment = .center
        amountHeaderLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        amountHeaderLabel.textColor = LINE_COLOR3
        leftView.addSubview(amountHeaderLabel)
        amountHeaderLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.loanAmount.snp.top).offset(-8 * HEIGHT_SCALE)
            make.left.right.equalTo(leftView)
        }

        // 金额范围
        self.amountFooterLabel.text = "额度范围1.00-6.00万元"
        self.amountFooterLabel.textAlignment = .center
        self.amountFooterLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.amountFooterLabel.textColor = LINE_COLOR3
        leftView.addSubview(self.amountFooterLabel)
        self.amountFooterLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.loanAmount.snp.bottom).offset(8 * HEIGHT_SCALE)
            make.left.right.equalTo(leftView)
        }
        
        
        let rightView : UIView = UIView()
        self.upperView.addSubview(rightView)
        rightView.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(self.upperView)
            make.width.equalTo(SCREEN_WIDTH / 2)
        }
        
        // 贷款期限
        self.loanTerm.textColor = NAVIGATION_COLOR
        self.loanTerm.text = "18"
        self.loanTerm.font = UIFont.systemFont(ofSize: 25 * WIDTH_SCALE)
        self.loanTerm.textAlignment = .center
        self.loanTerm.borderStyle = .roundedRect
        rightView.addSubview(self.loanTerm)
        self.loanTerm.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(rightView)
            make.height.equalTo(35 * HEIGHT_SCALE)
            make.width.equalTo(110 * WIDTH_SCALE)
        }
        
        // 期限选择按钮
        self.tremBtn.setImage(UIImage (named: "tremsIcon"), for: UIControlState.normal)
        self.tremBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10 * WIDTH_SCALE)
        self.tremBtn.contentHorizontalAlignment = .right
        self.tremBtn.addTarget(self, action: #selector(termClick), for: UIControlEvents.touchUpInside)
        rightView.addSubview(self.tremBtn)
        rightView.addSubview(self.tremBtn)
        self.tremBtn.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(self.loanTerm)
            make.right.equalTo(rightView)
        }
        
        
        let termHeaderLabel : UILabel = UILabel()
        termHeaderLabel.text = "借款期限/天"
        termHeaderLabel.textAlignment = .center
        termHeaderLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        termHeaderLabel.textColor = LINE_COLOR3
        rightView.addSubview(termHeaderLabel)
        termHeaderLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.loanTerm.snp.top).offset(-8 * HEIGHT_SCALE)
            make.left.right.equalTo(rightView)
        }
        
        // 期限范围
        self.termFooterLabel.text = "期限范围18-36个月"
        self.termFooterLabel.textAlignment = .center
        self.termFooterLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.termFooterLabel.textColor = LINE_COLOR3
        rightView.addSubview(self.termFooterLabel)
        self.termFooterLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.loanTerm.snp.bottom).offset(8 * HEIGHT_SCALE)
            make.left.right.equalTo(rightView)
        }
        
        
        let lineView2 : UIView = UIView()
        lineView2.backgroundColor = LINE_COLOR2
        self.upperView.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.upperView)
            make.left.equalTo(self.upperView.snp.left).offset(15 * WIDTH_SCALE)
            make.right.equalTo(self.upperView.snp.right).offset(-15 * WIDTH_SCALE)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
    }
    
    
    // 下半部分View
    func createLowerView() -> Void {
        self.addSubview(self.lowerView)
        self.lowerView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.upperView.snp.bottom)
            make.height.equalTo(60 * HEIGHT_SCALE)
        }
        
        let viewWidth : CGFloat = SCREEN_WIDTH / 3
        // 参考利率View
        self.lowerView.addSubview(self.interestRateView)
        self.interestRateView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.lowerView)
            make.width.equalTo(viewWidth)
            make.left.equalTo(self.lowerView)
        }

        let rateImageView : UIImageView = UIImageView()
        rateImageView.contentMode = .center
        rateImageView.image = UIImage (named: "greenLine")
        self.interestRateView.addSubview(rateImageView)
        rateImageView.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self.interestRateView)
            make.width.equalTo(2 * WIDTH_SCALE)
        }

        // 利率
        self.rateLabel.text = "10.00%"
        self.rateLabel.textColor = UIColor().colorWithHexString(hex: "777777")
        self.rateLabel.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        self.rateLabel.textAlignment = .center
        self.interestRateView.addSubview(self.rateLabel)
        self.rateLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.interestRateView)
            make.top.equalTo(self.interestRateView.snp.top).offset(10 * HEIGHT_SCALE)
        }

        // 利率文案
        self.rateTextLabel.text = "参考日利率"
        self.rateTextLabel.textColor = UIColor().colorWithHexString(hex: "777777")
        self.rateTextLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.rateTextLabel.textAlignment = .center
        self.interestRateView.addSubview(self.rateTextLabel)
        self.rateTextLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.interestRateView)
            make.bottom.equalTo(self.interestRateView.snp.bottom).offset(-10 * HEIGHT_SCALE)
        }
        
        // 时间View
        self.lowerView.addSubview(self.lenderDaterView)
        self.lenderDaterView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.lowerView)
            make.width.equalTo(viewWidth)
            make.left.equalTo(self.interestRateView.snp.right)
        }
        
        self.dateImageView.contentMode = .center
        self.dateImageView.image = UIImage (named: "greenLine")
        self.lenderDaterView.addSubview(self.dateImageView)
        self.dateImageView.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self.lenderDaterView)
            make.width.equalTo(2 * WIDTH_SCALE)
        }

        self.dateBtn.setImage(UIImage (named: "questionmark"), for: UIControlState.normal)
        self.dateBtn.addTarget(self, action: #selector(questionClick), for: UIControlEvents.touchUpInside)
        self.lenderDaterView.addSubview(self.dateBtn)
        self.dateBtn.snp.makeConstraints { (make) in
            make.top.right.equalTo(self.lenderDaterView)
            make.width.equalTo(30 * WIDTH_SCALE)
            make.height.equalTo(30 * WIDTH_SCALE)
        }

        // 时间
        self.dateLabel.text = "3分钟"
        self.dateLabel.textColor = UIColor().colorWithHexString(hex: "777777")
        self.dateLabel.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        self.dateLabel.textAlignment = .center
        self.lenderDaterView.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.lenderDaterView)
            make.top.equalTo(self.lenderDaterView.snp.top).offset(10 * HEIGHT_SCALE)
        }

        // 时间文案
        self.dateTextLabel.text = "最快放款时间"
        self.dateTextLabel.textColor = UIColor().colorWithHexString(hex: "777777")
        self.dateTextLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.dateTextLabel.textAlignment = .center
        self.lenderDaterView.addSubview(self.dateTextLabel)
        self.dateTextLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.lenderDaterView)
            make.bottom.equalTo(self.lenderDaterView.snp.bottom).offset(-10 * HEIGHT_SCALE)
        }
        
        
        // 还款金额View
        self.lowerView.addSubview(self.repayAmountView)
        self.repayAmountView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.lowerView)
            make.width.equalTo(viewWidth)
            make.left.equalTo(self.lenderDaterView.snp.right)
        }
        
        self.amountBtn.setImage(UIImage (named: "questionmark"), for: UIControlState.normal)
        self.amountBtn.addTarget(self, action: #selector(questionClick), for: UIControlEvents.touchUpInside)
        self.repayAmountView.addSubview(self.amountBtn)
        self.amountBtn.snp.makeConstraints { (make) in
            make.top.right.equalTo(self.repayAmountView)
            make.width.equalTo(30 * WIDTH_SCALE)
            make.height.equalTo(30 * WIDTH_SCALE)
        }
//
        // 还款金额
        self.amountLabel.text = "1000"
        self.amountLabel.textColor = UIColor().colorWithHexString(hex: "777777")
        self.amountLabel.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        self.amountLabel.textAlignment = .center
        self.repayAmountView.addSubview(self.amountLabel)
        self.amountLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.repayAmountView)
            make.top.equalTo(self.repayAmountView.snp.top).offset(10 * HEIGHT_SCALE)
        }
        
        // 还款金额文案
        self.amountTextLabel.text = "每月还款金额"
        self.amountTextLabel.textColor = UIColor().colorWithHexString(hex: "777777")
        self.amountTextLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.amountTextLabel.textAlignment = .center
        self.repayAmountView.addSubview(self.amountTextLabel)
        self.amountTextLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.repayAmountView)
            make.bottom.equalTo(self.repayAmountView.snp.bottom).offset(-10 * HEIGHT_SCALE)
        }
        
        
        
        let lineView : UIView = UIView()
        lineView.backgroundColor = LINE_COLOR2
        self.lowerView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.lowerView)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        change()
    }
    
    
    func change() -> Void {
        if false {
            let viewWidth : CGFloat = SCREEN_WIDTH / 3
            
            self.interestRateView.snp.updateConstraints { (make) in
                make.width.equalTo(viewWidth)
            }
            
            self.lenderDaterView.snp.updateConstraints { (make) in
                make.width.equalTo(viewWidth)
                make.left.equalTo(self.interestRateView.snp.right)
            }
            self.dateBtn.isHidden = true
            self.dateImageView.isHidden = false
            
            self.repayAmountView.snp.updateConstraints { (make) in
                make.width.equalTo(viewWidth)
                make.left.equalTo(self.lenderDaterView.snp.right)
            }
        } else {
            let viewWidth : CGFloat = SCREEN_WIDTH / 2
            
            self.interestRateView.snp.updateConstraints { (make) in
                make.width.equalTo(viewWidth)
            }
            
            self.lenderDaterView.snp.updateConstraints { (make) in
                make.width.equalTo(viewWidth)
                make.left.equalTo(self.interestRateView.snp.right)
            }
            self.dateBtn.isHidden = false
            self.dateImageView.isHidden = true
            
            self.repayAmountView.snp.updateConstraints { (make) in
                make.width.equalTo(0)
            }
        }
    }
    
    
    
    
    // 期限选择框
    func termClick() -> Void {
        if  self.tremsBlock != nil {
            self.tremsBlock!()
        }
    }
    
    
    // 问号的点击事件
    func questionClick() -> Void {
        if  self.questionBlock != nil {
            self.questionBlock!()
        }
    }
}
