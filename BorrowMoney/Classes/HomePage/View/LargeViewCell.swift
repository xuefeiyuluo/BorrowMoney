//
//  LargeViewCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/3.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias CallPhoneBlcok = (Int) -> Void
typealias RefreshBlock = (Int) -> Void
class LargeViewCell: UICollectionViewCell {
    var baseView : UIView = UIView()// 底部View
    var loanType : UILabel = UILabel()// 贷款类型
    var loanPersonNum : UILabel = UILabel()// 该贷款类型的信贷经理数量
    var headeImageView : UIImageView = UIImageView()// 信贷经理头像
    var nameLabel : UILabel = UILabel()// 信贷经理的名称
    var companyLabel : UILabel = UILabel()// 信贷经理所在的公司
    var loanPhone : UIButton = UIButton()// 立即咨询按钮
    var changeLoan : UIButton = UIButton()// 更换按钮
    var loanDate : [LoanTypeModel] = [LoanTypeModel]()// 数据源
    var callPhoneBlcok : CallPhoneBlcok?// 立即咨询回调
    var refreshBlock : RefreshBlock?// 更换的点击事件
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 创建UI
        createUI()
    }
    
    
    // 创建UI
    func createUI() -> Void {
        // 边框的View
        self.baseView.layer.cornerRadius = 8 * WIDTH_SCALE
        self.baseView.layer.masksToBounds = true
        self.baseView.layer.borderWidth = 1 * WIDTH_SCALE
        self.baseView.layer.borderColor = UIColor().colorWithHexString(hex: "ededed").cgColor
        self.contentView.addSubview(self.baseView)
        self.baseView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.left.equalTo(self.contentView.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.contentView.snp.right).offset(-10 * WIDTH_SCALE)
        }
        
        // 贷款类型
        self.loanType.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.loanType.textColor = TEXT_SECOND_COLOR
        self.baseView.addSubview(self.loanType)
        self.loanType.snp.makeConstraints { (make) in
            make.left.equalTo(self.baseView.snp.left).offset(10 * WIDTH_SCALE)
            make.top.equalTo(self.baseView)
            make.height.equalTo(30 * HEIGHT_SCALE)
        }
        
        // 该贷款类型的信贷经理数量
        self.loanPersonNum.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.loanPersonNum.textColor = LINE_COLOR3
        self.baseView.addSubview(self.loanPersonNum)
        self.loanPersonNum.snp.makeConstraints { (make) in
            make.left.equalTo(self.loanType.snp.right).offset(15 * WIDTH_SCALE)
            make.top.bottom.equalTo(self.loanType)
        }
        
        let lineView : UIView = UIView()
        lineView.backgroundColor = LINE_COLOR2
        self.baseView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.baseView)
            make.top.equalTo(self.loanType.snp.bottom)
            make.height.equalTo(0.5 * HEIGHT_SCALE)
        }
        
        let backImageView : UIImageView = UIImageView()
        backImageView.image = UIImage (named: "largeHeaderBackground")
        self.baseView.addSubview(backImageView)
        backImageView.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(5 * HEIGHT_SCALE)
            make.left.equalTo(self.baseView.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.baseView.snp.right).offset(-10 * WIDTH_SCALE)
            make.height.equalTo(112 * WIDTH_SCALE)
        }
        
        
        let imageView : UIImageView = UIImageView()
        imageView.contentMode = .center
        imageView.image = UIImage (named: "loanIcon")
        self.baseView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(10 * HEIGHT_SCALE)
            make.left.equalTo(self.baseView.snp.left).offset(10 * WIDTH_SCALE)
            make.width.equalTo(20 * WIDTH_SCALE)
            make.height.equalTo(20 * WIDTH_SCALE)
        }
        
        
        // 信贷经理头像
        self.headeImageView.layer.cornerRadius = 90 * WIDTH_SCALE / 2
        self.headeImageView.layer.masksToBounds = true
        self.headeImageView.layer.borderWidth = 1.5 * WIDTH_SCALE
        self.headeImageView.layer.borderColor = UIColor().colorWithHexString(hex: "eeeeee").cgColor
        self.baseView.addSubview(self.headeImageView)
        self.headeImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.baseView)
            make.width.equalTo(90 * WIDTH_SCALE)
            make.height.equalTo(90 * WIDTH_SCALE)
            make.top.equalTo(lineView.snp.bottom).offset(10 * HEIGHT_SCALE)
        }
        
        // 更换按钮
        self.changeLoan.setImage(UIImage (named: "largeChange"), for: UIControlState.normal)
        self.changeLoan.setTitle("更换", for: UIControlState.normal)
        self.changeLoan.setTitleColor(NAVIGATION_COLOR, for: UIControlState.normal)
        self.changeLoan.titleLabel?.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.changeLoan.imageEdgeInsets = UIEdgeInsetsMake(0, -3 * WIDTH_SCALE, 0, 0)
        self.changeLoan.addTarget(self, action: #selector(changeClick(sender:)), for: UIControlEvents.touchUpInside)
        self.baseView.addSubview(self.changeLoan)
        self.changeLoan.snp.makeConstraints { (make) in
            make.right.equalTo(self.baseView)
            make.top.equalTo(lineView.snp.bottom)
            make.width.equalTo(50 * WIDTH_SCALE)
            make.height.equalTo(30 * HEIGHT_SCALE)
        }
        
        // 信贷经理的名称
        self.nameLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.nameLabel.textColor = TEXT_SECOND_COLOR
        self.nameLabel.textAlignment = .center
        self.baseView.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.headeImageView.snp.bottom).offset(5 * WIDTH_SCALE)
            make.right.left.equalTo(self.baseView)
        }
        
        // 信贷经理所在的公司
        self.companyLabel.numberOfLines = 0
        self.companyLabel.textAlignment = .center
        self.companyLabel.font = UIFont.systemFont(ofSize: 11 * WIDTH_SCALE)
        self.companyLabel.textColor = LINE_COLOR3
        self.baseView.addSubview(self.companyLabel)
        self.companyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(5 * WIDTH_SCALE)
            make.left.equalTo(self.baseView.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.baseView.snp.right).offset(-10 * WIDTH_SCALE)
            make.height.equalTo(30 * HEIGHT_SCALE)
        }
        
        
        // 立即咨询按钮
        self.loanPhone.layer.borderWidth = 1 * WIDTH_SCALE
        self.loanPhone.layer.masksToBounds = true;
        self.loanPhone.layer.cornerRadius = 3 * WIDTH_SCALE;
        self.loanPhone.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10 * WIDTH_SCALE)
        self.loanPhone.addTarget(self, action: #selector(phoneClick(sender:)), for: UIControlEvents.touchUpInside)
        self.baseView.addSubview(self.loanPhone)
        self.loanPhone.snp.makeConstraints { (make) in
            make.left.equalTo(self.baseView.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.baseView.snp.right).offset(-10 * WIDTH_SCALE)
            make.bottom.equalTo(self.baseView.snp.bottom).offset(-10 * WIDTH_SCALE)
            make.height.equalTo(30 * HEIGHT_SCALE)
        }
    }
    
    
    // 更新数据
    func updateViewWithData(loanDate : [LoanTypeModel],indexPath : IndexPath) -> Void {
        self.loanDate = loanDate
        let model : LoanTypeModel = self.loanDate[indexPath.item]
        self.changeLoan.tag = indexPath.item
        
        if indexPath.item % 2 == 0 {
            self.baseView.snp.updateConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(10 * WIDTH_SCALE)
                make.right.equalTo(self.contentView.snp.right).offset(0 * WIDTH_SCALE)
            })
        } else {
            self.baseView.snp.updateConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(0 * WIDTH_SCALE)
                make.right.equalTo(self.contentView.snp.right).offset(-10 * WIDTH_SCALE)
            })
        }
        
        // 贷款类型
        self.loanType.text = model.spreadTypeName
        
        // 该贷款类型的信贷经理数量
        self.loanPersonNum.text = String (format: "%@位信贷顾问",model.providerCount!)
        
        // 更换按钮
        if model.providerList.count > 1 {
            self.changeLoan.isHidden = false
        } else {
            self.changeLoan.isHidden = true
        }
        
        // 信贷经理头像
        self.headeImageView.kf.setImage(with: URL (string: model.providerUrl), placeholder: UIImage (named: "loanDefault.png"), options: nil, progressBlock: nil, completionHandler: nil)
        
        // 信贷经理的名称
        self.nameLabel.text = model.providerName
        
        // 信贷经理所在的公司
        self.companyLabel.text = model.channelName
        
        // 立即咨询按钮
        if model.providerId.isEmpty {
            self.loanPhone.isEnabled = false
            self.loanPhone.setTitle("暂无应答", for: UIControlState.normal)
            self.loanPhone.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
            self.loanPhone.layer.borderColor = UIColor.lightGray.cgColor
            self.loanPhone.setImage(UIImage (named: ""), for: UIControlState.normal)
        } else {
            self.loanPhone.isEnabled = true
            self.loanPhone.setTitle("立即咨询", for: UIControlState.normal)
            self.loanPhone.setTitleColor(NAVIGATION_COLOR, for: UIControlState.normal)
            self.loanPhone.layer.borderColor = NAVIGATION_COLOR.cgColor
            self.loanPhone.setImage(UIImage (named: "loanPhone"), for: UIControlState.normal)
        }
        self.loanPhone.tag = indexPath.item
    }
    
    
    // 立即拨打的点击事件
    func phoneClick(sender : UIButton) -> Void {
        if self.callPhoneBlcok != nil {
            self.callPhoneBlcok!(sender.tag)
        }
    }
    
    
    // 更换的点击事件
    func changeClick(sender : UIButton) -> Void {
        let typeModel : LoanTypeModel = self.loanDate[sender.tag]
        typeModel.providerNum += 1
        if self.refreshBlock != nil {
            self.refreshBlock!(sender.tag)
        }
    }
}
