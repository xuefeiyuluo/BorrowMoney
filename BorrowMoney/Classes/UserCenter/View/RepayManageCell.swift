//
//  RepayManageCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/29.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit
import Kingfisher


class RepayManageCell: UITableViewCell {
    var headerImage : UIImageView?// 头像
    var loanName : UILabel?// 贷款名称
    var loanAccount : UILabel?// 贷款账户
    var loanRepaid : UIButton?// 设为已还
    var loanAmount : UILabel?// 贷款金额
    var loanDay : UILabel?// 拒还日期
    var clockImage : UIImageView?// 时钟图片
    var contentLabel : UILabel?// 提示信息
    var againLabel : UILabel?// 重新导入
    var refreshImage : UIImageView?// 刷新图片
    var repaymentBtn : UIButton?// 立即还款
    var loanAmountInfo : UILabel?// 贷款金额信息
    var loanDayInfo : UILabel?// 拒还日期信息
    var loanStatus : UILabel?// 贷款信息状态
    var btnView : UIView?// 立即还款的View
    var bottomView : UIView?// 底部View
    var bottomBtn : UIButton?// 刷新图标与重新导入的点击事件
    
    var loanData : LoanManageData?{
        didSet {
            // 头像
            self.headerImage?.kf.setImage(with: URL (string: (loanData?.productLogo)!), placeholder: UIImage (named: "channelDefault.png"), options: [KingfisherOptionsInfoItem.forceRefresh], progressBlock: nil, completionHandler: nil)
            
            // 贷款名称
            self.loanName?.text = loanData?.loanChannelName
            
            // 贷款账户
            if !(loanData?.loanUser?.isEmpty)! {
                self.loanAccount?.text = loanData?.loanUser
            } else {
                
                self.loanAccount?.text = USERINFO?.mobile
            }
            
            // 设为已还
            // 贷款类型 自家api: API 第三方账户:THIR
            if loanData?.loanType == "THIRD_PARTY" {
                // NORMAL_REPAY正常还款   HAD_OVERDUED已逾期
                if loanData?.status == "NORMAL_REPAY" || loanData?.status == "HAD_OVERDUED" {
                    self.loanRepaid?.isHidden = false
                } else {
                    self.loanRepaid?.isHidden = true
                }
            } else {
                self.loanRepaid?.isHidden = true
            }
            // 贷款状态信息
            // NORMAL_REPAY //正常还款 HAD_OVERDUED//已逾期 UPDATING//更新数据中 PASSWORD_ERROR//账号密码错误 NO_LOAN//无贷款信息 DATA_EXCEPTION//账户异常
            if loanData?.status == "NORMAL_REPAY" ||  loanData?.status == "HAD_OVERDUED" {
                self.loanStatus?.text = "账单详情"
                self.loanStatus?.textColor = TEXT_LIGHT_COLOR
            } else if loanData?.status == "UPDATING" {
                self.loanStatus?.text = "数据导入中..."
                self.loanStatus?.textColor = TEXT_LIGHT_COLOR
            } else if loanData?.status == "PASSWORD_ERROR" ||  loanData?.status == "DATA_EXCEPTION" {
                self.loanStatus?.text = "--"
                self.loanStatus?.textColor = UIColor().colorWithHexString(hex: "cccccc")
            } else if loanData?.status == "UPDATING" {
                self.loanStatus?.text = "暂无贷款信息"
                self.loanStatus?.textColor = TEXT_LIGHT_COLOR
            }
            
            // 金额   金额类型   天数   天数类型
            let absTemp : Int = abs(Int(loanData!.currentRepayDays!)!)
            let days : String = String (format: "%i", absTemp)
            if loanData?.status == "NORMAL_REPAY" || loanData?.status == "PASSWORD_ERROR" || loanData?.status == "DATA_EXCEPTION" {
                self.loanAmount?.text = loanData?.currentRepayAmount
                self.loanAmount?.textColor = UIColor().colorWithHexString(hex: "FF5A30")
                self.loanAmountInfo?.text = "应还金额/元"
                self.loanDay?.text = days
                self.loanDay?.textColor = UIColor().colorWithHexString(hex: "FF5A30")
                self.loanDayInfo?.text = "距还款日/天"
            } else if loanData?.status == "HAD_OVERDUED" {
                self.loanAmount?.text = loanData?.currentRepayAmount
                self.loanAmount?.textColor = UIColor().colorWithHexString(hex: "FF5A30")
                self.loanAmountInfo?.text = "逾期金额/元"
                self.loanDay?.text = days
                self.loanDay?.textColor = UIColor().colorWithHexString(hex: "FF5A30")
                self.loanDayInfo?.text = "已逾期/天"
            } else if loanData?.status == "UPDATING" || loanData?.status == "NO_LOAN" {
                self.loanAmount?.text = "--"
                self.loanAmount?.textColor = UIColor().colorWithHexString(hex: "cccccc")
                self.loanAmountInfo?.text = "应还金额/元"
                self.loanDay?.text = "--"
                self.loanDay?.textColor = UIColor().colorWithHexString(hex: "cccccc")
                self.loanDayInfo?.text = "距还款日/天"
            }
            // 立即还款按钮
            if loanData?.loanType == "API" && loanData?.repaymentType != "NONE" {
                self.btnView?.snp.updateConstraints({ (make) in
                    make.height.equalTo(50 * HEIGHT_SCALE)
                })
                
                self.repaymentBtn?.isHidden = false
                if (loanData?.repaymentSate)! {
                    self.repaymentBtn?.layer.borderColor = TEXT_LIGHT_COLOR.cgColor
                    self.repaymentBtn?.setTitleColor(TEXT_LIGHT_COLOR, for: UIControlState.normal)
                    self.repaymentBtn?.setTitle("还款处理中", for: UIControlState.normal)
                } else {
                    self.repaymentBtn?.layer.borderColor = NAVIGATION_COLOR.cgColor
                    self.repaymentBtn?.setTitleColor(NAVIGATION_COLOR, for: UIControlState.normal)
                    self.repaymentBtn?.setTitle("立即还款", for: UIControlState.normal)
                }
            } else {
                self.btnView?.snp.updateConstraints({ (make) in
                    make.height.equalTo(0 * HEIGHT_SCALE)
                })
                self.repaymentBtn?.isHidden = true
            }
            
            // 时钟图片状态   提示信息   重新导入或立即刷新
            if loanData?.status == "PASSWORD_ERROR" || loanData?.status == "DATA_EXCEPTION" {
                self.clockImage?.image = UIImage (named: "clockIconError.png")
                self.contentLabel?.textColor = UIColor().colorWithHexString(hex: "009cff")
                
                if loanData?.status == "PASSWORD_ERROR" {
                    self.refreshImage?.isHidden = true
                    self.againLabel?.isHidden = false
                    self.contentLabel?.text = "账号或密码错误"
                } else {
                    if (loanData?.refreshImageSate)! {
                        self.refreshImage?.isHidden = true
                    } else {
                        self.refreshImage?.isHidden = false
                    }
                    self.againLabel?.isHidden = true
                    self.contentLabel?.text = "数据更新异常"
                }
            } else {
                if loanData?.status == "UPDATING" {
                    self.bottomView?.isHidden = true
                } else {
                    self.bottomView?.isHidden = false
                    self.clockImage?.image = UIImage (named: "clockIcon.png")
                    self.contentLabel?.text = loanData?.updateTimeStr
                    self.contentLabel?.textColor = TEXT_LIGHT_COLOR
                    self.againLabel?.isHidden = true
                    self.refreshImage?.isHidden = true
                }
            }
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
        // 头像
        let headerImage : UIImageView = UIImageView()
        self.headerImage = headerImage
        self.contentView.addSubview(self.headerImage!)
        self.headerImage?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentView.snp.top).offset(10 * HEIGHT_SCALE)
            make.left.equalTo(self.contentView.snp.left).offset(10 * WIDTH_SCALE)
            make.width.height.equalTo(55 * HEIGHT_SCALE)
        })
        
        // 贷款名称
        let loanLabel = UILabel()
        loanLabel.textColor = TEXT_BLACK_COLOR
        loanLabel.font = UIFont .systemFont(ofSize: 15 * WIDTH_SCALE)
        self.loanName = loanLabel
        self.contentView.addSubview(self.loanName!)
        self.loanName?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentView.snp.top).offset(15 * HEIGHT_SCALE)
            make.left.equalTo((self.headerImage?.snp.right)!).offset(10 * WIDTH_SCALE)
            
        })

        // 贷款账户
        let accountLabel = UILabel()
        accountLabel.textColor = TEXT_BLACK_COLOR
        accountLabel.backgroundColor = UIColor().colorWithHexString(hex: "F4FBFC")
        accountLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.loanAccount = accountLabel
        self.contentView.addSubview(self.loanAccount!)
        self.loanAccount?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.loanName?.snp.bottom)!).offset(8 * HEIGHT_SCALE)
            make.left.equalTo((self.headerImage?.snp.right)!).offset(10 * WIDTH_SCALE)
            make.height.equalTo(20 * HEIGHT_SCALE)
        })
        
        // 设为已还
        let repaidBtn = UIButton(type: UIButtonType.custom)
        repaidBtn.setTitle("设为已还", for: UIControlState.normal)
        repaidBtn.setTitleColor(UIColor().colorWithHexString(hex: "009CFF"), for: UIControlState.normal)
        repaidBtn.titleLabel?.font = UIFont .systemFont(ofSize: 12 * WIDTH_SCALE)
        repaidBtn.layer.cornerRadius = 1
        repaidBtn.layer.borderColor = UIColor().colorWithHexString(hex: "009CFF").cgColor
        repaidBtn.layer.borderWidth = 1
        repaidBtn.layer.masksToBounds = true
        self.loanRepaid = repaidBtn
        self.contentView.addSubview(self.loanRepaid!)
        self.loanRepaid?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.loanAccount?.snp.right)!).offset(8 * WIDTH_SCALE)
            make.centerY.equalTo(self.loanAccount!)
            make.height.equalTo(20 * HEIGHT_SCALE)
            make.width.equalTo(65 * WIDTH_SCALE)
        })
        
        
        // 进入图标
        let enterImage : UIImageView = UIImageView()
        enterImage.image = UIImage (named: "rightArrow.png")
        enterImage.contentMode = .center
        self.contentView.addSubview(enterImage)
        enterImage.snp.makeConstraints({ (make) in
            make.height.equalTo(75 * HEIGHT_SCALE)
            make.right.equalTo(self.contentView.snp.right).offset(-5 * WIDTH_SCALE)
            make.width.equalTo(30 * WIDTH_SCALE)
        })
        
        // 账单详情
        let detailLabel = UILabel()
        detailLabel.textColor = TEXT_LIGHT_COLOR
        detailLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.loanStatus = detailLabel
        self.contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints({ (make) in
            make.right.equalTo(enterImage.snp.left).offset(-5 * WIDTH_SCALE)
            make.centerY.equalTo(enterImage.snp.centerY)
        })
        
        let lineView1 : UIView = UIView()
        lineView1.backgroundColor = LINE_COLOR2
        self.contentView.addSubview(lineView1)
        lineView1.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.height.equalTo(1 * HEIGHT_SCALE)
            make.top.equalTo(self.contentView.snp.top).offset(70 * HEIGHT_SCALE)
        }
        
        // 中间分割图标
        let divisionImage : UIImageView = UIImageView()
        divisionImage.image = UIImage (named: "cutDottedLine.png")
        self.contentView.addSubview(divisionImage)
        divisionImage.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentView.snp.top).offset(78 * HEIGHT_SCALE)
            make.height.equalTo(60 * HEIGHT_SCALE)
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.width.equalTo(2 * WIDTH_SCALE)
        })
        
        
        // 金额
        let amountLabel = UILabel()
        amountLabel.textColor = UIColor.red
        amountLabel.textAlignment = NSTextAlignment.center
        amountLabel.font = UIFont.boldSystemFont(ofSize: 20 * WIDTH_SCALE)
        self.loanAmount = amountLabel
        self.contentView.addSubview(self.loanAmount!)
        self.loanAmount?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentView.snp.top).offset(87 * HEIGHT_SCALE)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(divisionImage.snp.left)
        })
        
        // 金额类型
        let infoLabel = UILabel()
        infoLabel.textColor = TEXT_LIGHT_COLOR
        infoLabel.textAlignment = NSTextAlignment.center
        infoLabel.font = UIFont.systemFont(ofSize: 12)
        self.loanAmountInfo = infoLabel
        self.contentView.addSubview(self.loanAmountInfo!)
        self.loanAmountInfo?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentView.snp.top).offset(120 * HEIGHT_SCALE)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(divisionImage.snp.left)
        })

        // 天数
        let dateLabel = UILabel()
        dateLabel.textColor = UIColor.red
        dateLabel.textAlignment = NSTextAlignment.center
        dateLabel.font = UIFont.boldSystemFont(ofSize: 20 * WIDTH_SCALE)
        self.loanDay = dateLabel
        self.contentView.addSubview(self.loanDay!)
        self.loanDay?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentView.snp.top).offset(87 * HEIGHT_SCALE)
            make.right.equalTo(self.contentView.snp.right)
            make.left.equalTo(divisionImage.snp.right)
        })
        
        // 天数类型
        let infoDateLabel = UILabel()
        infoDateLabel.textColor = TEXT_LIGHT_COLOR
        infoDateLabel.textAlignment = NSTextAlignment.center
        infoDateLabel.font = UIFont.systemFont(ofSize: 12)
        self.loanDayInfo = infoDateLabel
        self.contentView.addSubview(self.loanDayInfo!)
        self.loanDayInfo?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentView.snp.top).offset(120 * HEIGHT_SCALE)
            make.right.equalTo(self.contentView.snp.right)
            make.left.equalTo(divisionImage.snp.right)
        })
        
        
        let lineView2 : UIView = UIView()
        lineView2.backgroundColor = LINE_COLOR2
        self.contentView.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.height.equalTo(1 * HEIGHT_SCALE)
            make.top.equalTo(self.contentView.snp.top).offset(146 * HEIGHT_SCALE)
        }
        
        
        let btnView : UIView = UIView()
        self.btnView = btnView
        self.contentView.addSubview(self.btnView!)
        self.btnView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentView.snp.top).offset(147 * HEIGHT_SCALE)
            make.left.right.equalTo(self.contentView)
            make.height.equalTo(50 * HEIGHT_SCALE)
        })

        // 立即还款
        let repaymentBtn : UIButton = UIButton (type: UIButtonType.custom)
        repaymentBtn.layer.cornerRadius = 2.5
        repaymentBtn.layer.borderWidth = 1
        repaymentBtn.layer.borderColor = NAVIGATION_COLOR.cgColor
        repaymentBtn.layer.masksToBounds = true
        repaymentBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17 * HEIGHT_SCALE)
        repaymentBtn.setTitleColor(NAVIGATION_COLOR, for: UIControlState.normal)
        self.repaymentBtn = repaymentBtn;
        self.btnView?.addSubview(self.repaymentBtn!)
        self.repaymentBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.btnView?.snp.top)!).offset(10 * HEIGHT_SCALE)
            make.left.equalTo((self.btnView?.snp.left)!).offset(10 * HEIGHT_SCALE)
            make.right.equalTo((self.btnView?.snp.right)!).offset(-10 * HEIGHT_SCALE)
            make.bottom.equalTo(self.btnView!)
        })
        
        
        let bottomView : UIView = UIView()
        self.bottomView = bottomView
        self.contentView.addSubview(self.bottomView!)
        self.bottomView?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.btnView?.snp.bottom)!)
            make.left.right.equalTo(self.contentView)
            make.height.equalTo(30 * HEIGHT_SCALE)
        })
        
        
        // 时钟图标
        let clickImage : UIImageView = UIImageView()
        clickImage.contentMode = .center
        self.clockImage = clickImage
        self.bottomView?.addSubview(self.clockImage!)
        self.clockImage?.snp.makeConstraints({ (make) in
            make.top.bottom.equalTo(self.bottomView!)
            make.left.equalTo((self.bottomView?.snp.left)!).offset(15 * WIDTH_SCALE)
            make.width.equalTo(20 * WIDTH_SCALE)
        })
        
        
        // 提示信息
        let contentLabel = UILabel()
        contentLabel.textColor = TEXT_BLACK_COLOR
        contentLabel.font = UIFont .systemFont(ofSize: 13 * WIDTH_SCALE)
        self.contentLabel = contentLabel
        self.bottomView?.addSubview(self.contentLabel!)
        self.contentLabel?.snp.makeConstraints({ (make) in
            make.top.bottom.equalTo(self.bottomView!)
            make.left.equalTo((self.clockImage?.snp.right)!)
        })
        // 刷新图标
        let refreshImage : UIImageView = UIImageView()
        refreshImage.contentMode = .center
        self.refreshImage = refreshImage
        self.bottomView?.addSubview(self.refreshImage!)
        self.refreshImage?.snp.makeConstraints({ (make) in
            make.top.bottom.equalTo(self.bottomView!)
            make.right.equalTo((self.bottomView?.snp.right)!).offset(-10 * WIDTH_SCALE)
            make.width.equalTo(20 * WIDTH_SCALE)
        })
        
        
        // 重新导入
        let againLabel = UILabel()
        againLabel.text = "重新导入"
        againLabel.textColor = UIColor().colorWithHexString(hex: "009cff")
        againLabel.font = UIFont .systemFont(ofSize: 13 * WIDTH_SCALE)
        self.againLabel = againLabel
        self.bottomView?.addSubview(self.againLabel!)
        self.againLabel?.snp.makeConstraints({ (make) in
            make.top.bottom.equalTo(self.bottomView!)
            make.right.equalTo((self.bottomView?.snp.right)!).offset(-10 * WIDTH_SCALE)
        })
        
        // 刷新图标与重新导入的点击事件
        let bottomBtn = UIButton (type: UIButtonType.custom)
        self.bottomBtn = bottomBtn
        self.bottomView?.addSubview(self.bottomBtn!)
        self.againLabel?.snp.makeConstraints({ (make) in
            make.top.bottom.right.equalTo(self.bottomView!)
            make.width.equalTo(120 * WIDTH_SCALE)
        })
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
