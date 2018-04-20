//
//  LoanApplicantTypeCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/16.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias ApplicantType1Block = () -> Void
class LoanApplicantType1Cell: BasicViewCell {
    var typeLabel : UILabel = UILabel()// 类别信息
    var infoField : UITextField = UITextField()// 信息输入
    var enterImageView : UIImageView = UIImageView()// 选中按钮
    var cardBtn : UIButton = UIButton()// 身份证拍照按钮
    var backBtn : UIButton = UIButton (type: UIButtonType.custom)// row的点击事件
    var applicantType1Block : ApplicantType1Block?// row的点击事件
    
    var regulaModel : ApplyRegulaModel = ApplyRegulaModel() {
        didSet {
        
            // 类别信息
            self.typeLabel.text = regulaModel.attribute_name
            
            // 信息输入
            if regulaModel.selectValue.isEmpty {
                self.infoField.textColor = LINE_COLOR3
            } else {
                self.infoField.textColor = TEXT_SECOND_COLOR
                self.infoField.text = regulaModel.selectValue
            }
            
            // 选中按钮
            if regulaModel.attibute_type == "int" || regulaModel.attibute_type == "string" {
                self.enterImageView.isHidden = true
                self.cardBtn.isHidden = true
                self.infoField.isEnabled = true
            } else if regulaModel.attibute_type == "idCardFrontOcr" || regulaModel.attibute_type == "idCardBackOcr" || regulaModel.attibute_type == "livenessOcr" {
                self.enterImageView.isHidden = true
                self.cardBtn.isHidden = false
            } else {
                self.infoField.isEnabled = false
                self.enterImageView.isHidden = false
                self.cardBtn.isHidden = true
            }
            
            if ASSERLOGIN! {
                self.backBtn.isHidden = true
            } else {
                self.backBtn.isHidden = false
            }
        }
    }
    
    
    
    
    
    // 身份证拍照按钮

    // 创建界面
    override func createUI() {
        super.createUI()
        self.backgroundColor = MAIN_COLOR
        
        // 类别信息
        self.typeLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.typeLabel.textColor = TEXT_SECOND_COLOR
        self.contentView.addSubview(self.typeLabel)
        self.typeLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.left.equalTo(self.contentView.snp.left).offset(52 * WIDTH_SCALE)
        }
        
        // 选中按钮
        self.enterImageView.contentMode = .center
        self.enterImageView.image = UIImage (named: "promptArrow")
        self.contentView.addSubview(self.enterImageView)
        self.enterImageView.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self.contentView)
            make.width.equalTo(30 * WIDTH_SCALE)
        }


        // 信息输入
        self.infoField.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.infoField.textAlignment = .right
        self.infoField.placeholder = "请填写"
        self.contentView.addSubview(self.infoField)
        self.infoField.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.contentView)
            make.right.equalTo(self.enterImageView.snp.left)
            make.width.equalTo(200 * WIDTH_SCALE)
        }
        
        
        // 身份证拍照按钮
        self.cardBtn.setTitleColor(UIColor().colorWithHexString(hex: "B2B2B2"), for: UIControlState.normal)
        self.cardBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.cardBtn.setTitle("点击上传", for: UIControlState.normal)
        self.cardBtn.setImage(UIImage (named: "camera.png"), for: UIControlState.normal)
        self.cardBtn.setBackgroundImage(UIImage (named: "cardBackground.png"), for: UIControlState.normal)
        self.cardBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -7 * WIDTH_SCALE, 0, 0)
        self.contentView.addSubview(self.cardBtn)
        self.cardBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(6 * HEIGHT_SCALE)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-6 * HEIGHT_SCALE)
            make.right.equalTo(self.contentView.snp.right).offset(-15 * WIDTH_SCALE)
            make.width.equalTo(160 * WIDTH_SCALE)
        }
        
        
        let lineView : UIView = UIView()
        lineView.backgroundColor = LINE_COLOR2
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(self.contentView)
            make.height.equalTo(1 * HEIGHT_SCALE)
            make.left.equalTo(self.contentView.snp.left).offset(15 * WIDTH_SCALE)
        }
        
    
        self.backBtn.addTarget(self, action: #selector(backClick), for: UIControlEvents.touchUpInside)
        self.contentView.addSubview(self.backBtn)
        self.backBtn.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self.contentView)
        }
    }
    
    
    // 整个row的点击事件
    func backClick() -> Void {
        if self.applicantType1Block != nil {
            self.applicantType1Block!()
        }
    }
}
