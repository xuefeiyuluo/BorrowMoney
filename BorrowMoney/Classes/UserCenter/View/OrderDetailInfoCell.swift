//
//  OrderDetailInfoCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/8.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias ProtocolBlock = (String) -> Void
class OrderDetailInfoCell: BasicViewCell, UITextViewDelegate {
    let amountLabel : UILabel = UILabel()// 申请金额
    let termLabel : UILabel = UILabel()// 申请期限
    let timeLabel : UILabel = UILabel()// 申请时间
    let protocolView : UITextView = UITextView()// 协议
    let memberCardLabel : UILabel = UILabel()// 会员卡
    var protocolBlock : ProtocolBlock?// 点击合同的回调
    
    
    var orderDetail : OrderDetailModel?{
        didSet{
            // 申请金额
            self.amountLabel.text = String (format: "申请金额:%@",(orderDetail?.loanAmount)!)
            
            // 申请期限
            self.termLabel.text = String (format: "申请期限:%@个月", (orderDetail?.loanTerms)!)
            
            // 申请时间
            self.timeLabel.text = String (format: "申请时间：%@", (orderDetail?.orderTime)!)
            
            // 会员卡
            if (orderDetail?.memberCard.isEmpty)! {
                self.memberCardLabel.isHidden = true
                self.memberCardLabel.snp.updateConstraints({ (make) in
                    make.height.equalTo(0.01 * HEIGHT_SCALE)
                })
            } else {
                self.memberCardLabel.isHidden = false
                self.memberCardLabel.snp.updateConstraints({ (make) in
                    make.height.equalTo(14 * HEIGHT_SCALE)
                })
                self.memberCardLabel.text = String (format: "会员服务：%@",(orderDetail?.memberCard)!)
            }

            // 协议
            if self.orderDetail?.protocols.count != 0 {
                let protocolStr : NSMutableString = "查看协议:"
                for model : ProtocolModel in (orderDetail?.protocols)! {
                    protocolStr.appendFormat("《%@》",model.contract_name)
                }
                
                let attString : NSMutableAttributedString = NSMutableAttributedString.init(string:protocolStr as String)
                attString.setAttributes([NSForegroundColorAttributeName : LINE_COLOR3,NSFontAttributeName : UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)], range: NSMakeRange(0, 5))
                
                var index : Int = 5;
                for model : ProtocolModel in (orderDetail?.protocols)! {
                    let name : String = model.contract_name
                    let url : String = model.url
                    attString.setAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 12 * WIDTH_SCALE),NSLinkAttributeName : url], range: NSMakeRange(index, name.count + 2))
                    index = index + name.count + 2
                }
                // 设置合同协议的颜色
                self.protocolView.linkTextAttributes = [NSForegroundColorAttributeName : NAVIGATION_COLOR]
    
                let size : CGSize = self.sizeWithText(text: protocolStr as String, font: UIFont.systemFont(ofSize: 12 * WIDTH_SCALE), maxSize: CGSize.init(width: SCREEN_WIDTH - 25 * WIDTH_SCALE, height: CGFloat(MAXFLOAT)))
                if (orderDetail?.memberCard.isEmpty)! {
                    self.protocolView.snp.updateConstraints({ (make) in
                        make.top.equalTo(self.memberCardLabel.snp.bottom).offset(-10 * HEIGHT_SCALE)
                        make.height.equalTo((size.height + 10) * HEIGHT_SCALE)
                    })
                } else {
                    self.protocolView.snp.updateConstraints({ (make) in
                        make.height.equalTo((size.height + 10) * HEIGHT_SCALE)
                    })
                }
                self.protocolView.attributedText = attString
            }
        }
    }

    
    // 创建界面
    override func createUI() {
        super.createUI()
        
        // 申请金额
        self.amountLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.amountLabel.textColor = LINE_COLOR3
        self.contentView.addSubview(self.amountLabel)
        self.amountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15 * WIDTH_SCALE)
            make.top.equalTo(self.contentView.snp.top).offset(10 * WIDTH_SCALE)
            make.width.equalTo((SCREEN_WIDTH - 30 * WIDTH_SCALE) / 2)
        }
        
        // 申请期限
        self.termLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.termLabel.textColor = LINE_COLOR3
        self.contentView.addSubview(self.termLabel)
        self.termLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-15 * WIDTH_SCALE)
            make.top.equalTo(self.contentView.snp.top).offset(12 * WIDTH_SCALE)
            make.width.equalTo((SCREEN_WIDTH - 30 * WIDTH_SCALE) / 2)
        }
        
        // 申请时间
        self.timeLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.timeLabel.textColor = LINE_COLOR3
        self.contentView.addSubview(self.timeLabel)
        self.timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15 * WIDTH_SCALE)
            make.top.equalTo(self.amountLabel.snp.bottom).offset(10 * WIDTH_SCALE)
            make.width.equalTo(SCREEN_WIDTH - 30 * WIDTH_SCALE)
        }
        
        // 会员卡
        self.memberCardLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.memberCardLabel.textColor = LINE_COLOR3
        self.contentView.addSubview(self.memberCardLabel)
        self.memberCardLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15 * WIDTH_SCALE)
            make.top.equalTo(self.timeLabel.snp.bottom).offset(10 * HEIGHT_SCALE)
            make.height.equalTo(0.01 * HEIGHT_SCALE)
            make.width.equalTo((SCREEN_WIDTH - 30 * WIDTH_SCALE) / 2)
        }

        // 协议
        self.protocolView.delegate = self
        self.protocolView.isEditable = false
        self.contentView.addSubview(self.protocolView)
        self.protocolView.snp.makeConstraints { (make) in
            make.top.equalTo(self.memberCardLabel.snp.bottom).offset(10 * HEIGHT_SCALE)
            make.height.equalTo(0.01 * HEIGHT_SCALE)
            make.left.equalTo(self.contentView.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.contentView.snp.right).offset(-15 * WIDTH_SCALE)
        }
    }
    
    
    // MARK:UITextViewDelegate
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        if self.protocolBlock != nil {
            self.protocolBlock!(URL.absoluteString)
        }
        return false
    }
}
