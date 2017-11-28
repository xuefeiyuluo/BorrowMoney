//
//  UserCenterCell1.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/13.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class UserCenterCell1: UITableViewCell {
    var iconImage : UIImageView?// 图标
    var titleLabel : UILabel?// 标题
    var subLabel : UILabel?// 副标题
    var payLabel : UILabel?// 应还金额
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func createUI() -> Void {
        // 图标
        let iconImageView : UIImageView = UIImageView()
        iconImageView.contentMode = .center
        self.iconImage = iconImageView
        self.contentView .addSubview(self.iconImage!)
        self.iconImage?.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(10 * WIDTH_SCALE)
            make.top.bottom.equalTo(self.contentView)
            make.width.equalTo(self.contentView.snp.height)
        }
        
        // 标题
        let titleLabel : UILabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        titleLabel.textColor = TEXT_BLACK_COLOR
        self.titleLabel = titleLabel
        self.contentView .addSubview(self.titleLabel!)
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.iconImage?.snp.right)!)
            make.top.bottom.equalTo(self.contentView)
        })
        

        let enterImageView : UIImageView = UIImageView()
        enterImageView.contentMode = .center
        enterImageView.image = UIImage (named: "rightArrow.png")
        self.contentView .addSubview(enterImageView)
        enterImageView.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-10 * WIDTH_SCALE)
            make.top.bottom.equalTo(self.contentView)
            make.width.equalTo(25 * WIDTH_SCALE)
        }
        
        // 内容
        let contentLabel : UILabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        contentLabel.textColor = TEXT_BLACK_COLOR
        self.subLabel = contentLabel
        self.contentView .addSubview(self.subLabel!)
        self.subLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(enterImageView.snp.left)
            make.top.bottom.equalTo(self.contentView)
        })
        
        
        // 金额
        let payLabel : UILabel = UILabel()
        payLabel.font = UIFont.boldSystemFont(ofSize: 14 * WIDTH_SCALE)
        payLabel.textColor = TEXT_BLACK_COLOR
        self.payLabel = payLabel
        self.contentView .addSubview(self.payLabel!)
        self.payLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo((self.subLabel?.snp.left)!).offset(-5 * WIDTH_SCALE)
            make.top.bottom.equalTo(self.contentView)
        })
    }
    

    // 更新订单管理
    func updateOrdeManage(loanOrdermodel : LoanOrderModel) -> Void {
        
        self.payLabel?.text = ""
        
        if loanOrdermodel.channelName != nil {
            self.subLabel?.text = loanOrdermodel.channelName
            self.subLabel?.textColor = TEXT_BLACK_COLOR
            self.subLabel?.font = UIFont .systemFont(ofSize: 14 * WIDTH_SCALE)
        } else {
            self.subLabel?.text = "暂无订单记录"
            self.subLabel?.textColor = LINE_COLOR3
            self.subLabel?.font = UIFont .systemFont(ofSize: 13 * WIDTH_SCALE)
        }
    }

    
    // 更新还款管理
    func updatePayManage(loanData : LoanProductsModel) -> Void {

        
        self.subLabel?.textColor = UIColor().colorWithHexString(hex: "FF5A30")
        // 类型 有逾期HAD_OVERDUED、无逾期NORMAL_REPAY、无贷款应还或未登陆NO_LOAN
        if loanData.type == "HAD_OVERDUED" {
            self.subLabel?.text = NSString (format: "%@元", loanData.currentRepayAmount!) as String
            self.payLabel?.text = "逾期金额"
            self.payLabel?.textColor = UIColor().colorWithHexString(hex: "FF5A30")
        } else  if loanData.type == "NORMAL_REPAY" {
            self.subLabel?.text = NSString (format: "%@元", loanData.currentRepayAmount!) as String
            self.payLabel?.text = "本期应还"
            self.payLabel?.textColor = UIColor().colorWithHexString(hex: "FF5A30")
        } else {
            self.subLabel?.text = "0.00元"
            self.payLabel?.text = "本期应还"
            self.payLabel?.textColor = UIColor().colorWithHexString(hex: "999999")
            
        }
        
        
        // 金额为0时颜色为黑色
        if loanData.currentRepayAmount?.floatValue == 0 {
            self.subLabel?.textColor = UIColor().colorWithHexString(hex: "585858")
            self.subLabel?.font = UIFont.boldSystemFont(ofSize: 16 * WIDTH_SCALE)
        } else {
            self.subLabel?.textColor = UIColor().colorWithHexString(hex: "FF5A30")
            self.subLabel?.font = UIFont .systemFont(ofSize: 16 * WIDTH_SCALE)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
