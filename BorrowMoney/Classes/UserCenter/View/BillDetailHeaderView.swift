//
//  BillDetailHeaderView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/19.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias RepaidBlock = (String) -> Void
class BillDetailHeaderView: BasicView {
    lazy var repaidAlertView : RepaidAlertView = RepaidAlertView()// 设为已还弹框
    var iconImageView : UIImageView = UIImageView()// 图标
    var channelLabel : UILabel = UILabel()// 机构名称
    var phoneLabel : UILabel = UILabel()// 电话号码
    var amountLabel : UILabel = UILabel()// 还款金额
    var stateLabel : UILabel = UILabel()// 还款状态
    var repaidBtn : UIButton = UIButton()// 设为已还按钮
    var loanAmountLabel : UILabel = UILabel()// 借款金额
    var allAmountLabel : UILabel = UILabel()// 总还金额
    var termLabel : UILabel = UILabel()// 分期
    var repaidBlock : RepaidBlock?// 设为已还的回调
    var planList : [PlanModel] = [PlanModel]()// 贷款分期列表

    // 创建UI
    override func createUI() {
        super.createUI()
        // 上半部分
        let view1: UIView = UIView()
        self.addSubview(view1)
        view1.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(90 * HEIGHT_SCALE)
        }
        
        // 图标
        view1.addSubview(self.iconImageView)
        self.iconImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(view1)
            make.width.height.equalTo(60 * WIDTH_SCALE)
            make.left.equalTo(view1.snp.left).offset(15 * WIDTH_SCALE)
        }
        
        // 机构名称
        self.channelLabel.textColor = TEXT_SECOND_COLOR
        self.channelLabel.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        view1.addSubview(self.channelLabel)
        self.channelLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconImageView.snp.right).offset(10 * WIDTH_SCALE)
            make.top.equalTo(self.snp.top).offset(20 * HEIGHT_SCALE)
        }
        
        
        // 电话号码
        self.phoneLabel.textColor = LINE_COLOR3
        self.phoneLabel.backgroundColor = UIColor().colorWithHexString(hex: "F4FBFC")
        self.phoneLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        view1.addSubview(self.phoneLabel)
        self.phoneLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.channelLabel)
            make.top.equalTo(self.channelLabel.snp.bottom).offset(15 * HEIGHT_SCALE)
            make.height.equalTo(18 * HEIGHT_SCALE)
        }
        
        // 还款金额
        self.amountLabel.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        view1.addSubview(self.amountLabel)
        self.amountLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-15 * WIDTH_SCALE)
            make.top.equalTo(self.snp.top).offset(15 * HEIGHT_SCALE)
        }
        
        // 还款状态
        self.stateLabel.text = "本期应还"
        self.stateLabel.textColor = TEXT_BLACK_COLOR
        self.stateLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        view1.addSubview(self.stateLabel)
        self.stateLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.amountLabel)
            make.top.equalTo(self.amountLabel.snp.bottom).offset(5 * HEIGHT_SCALE)
        }
        
        // 设为已还按钮
        self.repaidBtn.setTitle("设为已还", for: UIControlState.normal)
        self.repaidBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.repaidBtn.setTitleColor(UIColor().colorWithHexString(hex: "009CFF"), for: UIControlState.normal)
        self.repaidBtn.layer.borderColor = UIColor().colorWithHexString(hex: "009CFF").cgColor
        self.repaidBtn.layer.borderWidth = 1.5 * WIDTH_SCALE
        self.repaidBtn.layer.cornerRadius = 1.5 * WIDTH_SCALE
        self.repaidBtn.layer.masksToBounds = true
        self.repaidBtn.addTarget(self, action: #selector(repaidClick), for: UIControlEvents.touchUpInside)
        self.repaidBtn.isHidden = true
        view1.addSubview(self.repaidBtn)
        self.repaidBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.amountLabel)
            make.width.equalTo(65 * WIDTH_SCALE)
            make.height.equalTo(20 * HEIGHT_SCALE)
            make.top.equalTo(self.stateLabel.snp.bottom).offset(5 * HEIGHT_SCALE)
        }
        
        let lineView1 = UIView()
        lineView1.backgroundColor = LINE_COLOR2
        view1.addSubview(lineView1)
        lineView1.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(view1)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        // 下半部分
        let view2: UIView = UIView()
        self.addSubview(view2)
        view2.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(view1.snp.bottom)
            make.height.equalTo(70 * HEIGHT_SCALE)
        }
        
        // 借款金额
        let firstView : UIView = UIView()
        view2.addSubview(firstView)
        firstView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(view2)
            make.width.equalTo(SCREEN_WIDTH / 3)
        }

        self.loanAmountLabel.textColor = UIColor.black
        self.loanAmountLabel.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        self.loanAmountLabel.textAlignment = NSTextAlignment.center
        firstView.addSubview(self.loanAmountLabel)
        self.loanAmountLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(firstView)
            make.top.equalTo(firstView.snp.top).offset(15 * HEIGHT_SCALE)
        }


        let amountText : UILabel = UILabel()
        amountText.textAlignment = NSTextAlignment.center
        amountText.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        amountText.text = "借款金额"
        amountText.textColor = LINE_COLOR3
        firstView.addSubview(amountText)
        amountText.snp.makeConstraints { (make) in
            make.left.right.equalTo(firstView)
            make.top.equalTo(self.loanAmountLabel.snp.bottom).offset(8 * HEIGHT_SCALE)
        }

        let imageView1 : UIImageView = UIImageView()
        imageView1.contentMode = UIViewContentMode.center
        imageView1.image = UIImage (named: "billLine.png")
        firstView.addSubview(imageView1)
        imageView1.snp.makeConstraints { (make) in
            make.top.equalTo(firstView.snp.top).offset(15 * HEIGHT_SCALE)
            make.bottom.equalTo(firstView.snp.bottom).offset(-15 * HEIGHT_SCALE)
            make.right.equalTo(firstView.snp.right)
            make.width.equalTo(2 * WIDTH_SCALE)
        }
        
        // 总还金额
        let secView : UIView = UIView()
        view2.addSubview(secView)
        secView.snp.makeConstraints { (make) in
            make.left.equalTo(firstView.snp.right)
            make.top.bottom.equalTo(view2)
            make.width.equalTo(SCREEN_WIDTH / 3)
        }
        
        self.allAmountLabel.textColor = UIColor.black
        self.allAmountLabel.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        self.allAmountLabel.textAlignment = NSTextAlignment.center
        secView.addSubview(self.allAmountLabel)
        self.allAmountLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(secView)
            make.top.equalTo(secView.snp.top).offset(15 * HEIGHT_SCALE)
        }
        
        
        let allText : UILabel = UILabel()
        allText.textAlignment = NSTextAlignment.center
        allText.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        allText.text = "总还款金额"
        allText.textColor = LINE_COLOR3
        secView.addSubview(allText)
        allText.snp.makeConstraints { (make) in
            make.left.right.equalTo(secView)
            make.top.equalTo(self.allAmountLabel.snp.bottom).offset(8 * HEIGHT_SCALE)
        }
        
        let imageView2 : UIImageView = UIImageView()
        imageView2.contentMode = UIViewContentMode.center
        imageView2.image = UIImage (named: "billLine.png")
        secView.addSubview(imageView2)
        imageView2.snp.makeConstraints { (make) in
            make.top.equalTo(secView.snp.top).offset(15 * HEIGHT_SCALE)
            make.bottom.equalTo(secView.snp.bottom).offset(-15 * HEIGHT_SCALE)
            make.right.equalTo(secView.snp.right)
            make.width.equalTo(2 * WIDTH_SCALE)
        }
        
        // 分期
        let thirdView : UIView = UIView()
        view2.addSubview(thirdView)
        thirdView.snp.makeConstraints { (make) in
            make.left.equalTo(secView.snp.right)
            make.top.bottom.equalTo(view2)
            make.width.equalTo(SCREEN_WIDTH / 3)
        }
        
        self.termLabel.textColor = UIColor.black
        self.termLabel.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        self.termLabel.textAlignment = NSTextAlignment.center
        thirdView.addSubview(self.termLabel)
        self.termLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(thirdView)
            make.top.equalTo(thirdView.snp.top).offset(15 * HEIGHT_SCALE)
        }
        
        
        let termText : UILabel = UILabel()
        termText.textAlignment = NSTextAlignment.center
        termText.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        termText.text = "分期"
        termText.textColor = LINE_COLOR3
        thirdView.addSubview(termText)
        termText.snp.makeConstraints { (make) in
            make.left.right.equalTo(thirdView)
            make.top.equalTo(self.termLabel.snp.bottom).offset(8 * HEIGHT_SCALE)
        }
        
        let lineView2 = UIView()
        lineView2.backgroundColor = LINE_COLOR2
        view1.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(view2)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
    }
    
    
    // 更新头部信息
    func updateHeaderView(detailModel : BillDetailModel) -> Void {
        self.planList = detailModel.planList
        // 图标
        self.iconImageView.kf.setImage(with:URL (string: detailModel.productLogo), placeholder: UIImage (named: "defaultWait.png"), options: nil, progressBlock: nil, completionHandler: nil)
        
        // 机构名称
        self.channelLabel.text = detailModel.loanChannelName
        
        // 电话号码
        self.phoneLabel.text = detailModel.loanUser
        
        // 还款金额
        if detailModel.currentRepayAmount.isEmpty {
            self.amountLabel.text = ""
        } else {
            let amountText : String = String (format: "%@元", detailModel.currentRepayAmount)
            let amountStr : NSMutableAttributedString = NSMutableAttributedString(string: amountText)
            let amountFirstDict = [NSForegroundColorAttributeName : UIColor().colorWithHexString(hex: "ff5a30")]
            amountStr.addAttributes(amountFirstDict, range: NSMakeRange(0, detailModel.currentRepayAmount.count))
            let amountThirdDict = [NSForegroundColorAttributeName : TEXT_BLACK_COLOR]
            amountStr.addAttributes(amountThirdDict, range: NSMakeRange(amountText.count - 1, 1))
            self.amountLabel.attributedText = amountStr
        }
        
        // 设为已还按钮
        if detailModel.loanType == "API" {
            self.repaidBtn.isHidden = true
            self.amountLabel.snp.updateConstraints({ (make) in
                make.top.equalTo(self.snp.top).offset(20 * HEIGHT_SCALE)
            })
            
            self.stateLabel.snp.updateConstraints({ (make) in
                make.top.equalTo(self.amountLabel.snp.bottom).offset(15 * HEIGHT_SCALE)
            })
            
            self.repaidBtn.snp.updateConstraints({ (make) in
                make.height.equalTo(0.01 * HEIGHT_SCALE)
            })
        } else {
            var repaid : Bool = true
            
            for planModel : PlanModel in detailModel.planList {
                if planModel.status == "1" || planModel.status == "4" {
                    repaid = false
                    break
                }
            }
            
            if repaid {
                self.repaidBtn.isHidden = true
                
                self.amountLabel.snp.updateConstraints({ (make) in
                    make.top.equalTo(self.snp.top).offset(20 * HEIGHT_SCALE)
                })
                
                self.stateLabel.snp.updateConstraints({ (make) in
                    make.top.equalTo(self.amountLabel.snp.bottom).offset(17 * HEIGHT_SCALE)
                })
                
                self.repaidBtn.snp.updateConstraints({ (make) in
                    make.height.equalTo(0.01 * HEIGHT_SCALE)
                })
            } else {
                self.repaidBtn.isHidden = false
                self.amountLabel.snp.updateConstraints({ (make) in
                    make.top.equalTo(self.snp.top).offset(15 * HEIGHT_SCALE)
                })
                
                self.stateLabel.snp.updateConstraints({ (make) in
                    make.top.equalTo(self.amountLabel.snp.bottom).offset(5 * HEIGHT_SCALE)
                })
                
                self.repaidBtn.snp.updateConstraints({ (make) in
                    make.height.equalTo(20 * HEIGHT_SCALE)
                })
            }
        }
        
        // 借款金额
        self.loanAmountLabel.text = detailModel.totalAmount
        
        // 总还金额
        self.allAmountLabel.text = detailModel.totalRepayAmount
        
        // 分期
        self.termLabel.text = String (format: "共%@期", detailModel.totalPeriod)
    }
    
    
    // 设为已还的点击事件
    func repaidClick() -> Void {
        var tempArray : [PlanModel] = [PlanModel]()
        for model : PlanModel in self.planList {
            // 状态  0=未出账 1=待还款 2=正常结清 3=逾期结清 4=逾期
            if model.status == "1" || model.status == "4" {
                model.selectedId = true
                tempArray.append(model)
            }
        }
        
        // 弹框的高度
        var repaidHeight : CGFloat = 0.0
        if tempArray.count > 5 {
            repaidHeight = 160 + 27 * 5
        } else {
            repaidHeight = CGFloat(160 + tempArray.count * 27)
        }
        if tempArray.count > 0 {
            let window : UIWindow = UIApplication.shared.keyWindow!
            self.repaidAlertView.frame = window.bounds
            self.repaidAlertView.alertHeight = repaidHeight
            self.repaidAlertView.repaiArray = tempArray
            window.addSubview(self.repaidAlertView)
            self.repaidAlertView.repaidBlock = {(ids) in
                weak var weakSelf = self
                if weakSelf?.repaidBlock != nil {
                    weakSelf?.repaidBlock!(ids)
                }
            }
        }
    }
}
