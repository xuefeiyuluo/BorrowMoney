//
//  LoanApplicantTypeCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/16.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class LoanApplicantTypeCell: BasicViewCell {
    var typeLabel : UILabel = UILabel()// 类别信息
    var infoField : UITextField = UITextField()// 信息输入
    var enterImageView : UIImageView = UIImageView()// 选中按钮
    var importBtn : UIButton = UIButton()// 导入按钮
    var importText : UILabel = UILabel()// 导入文案
    var cardBtn : UIButton = UIButton()// 身份证拍照按钮
    
    // 类别信息
    // 信息输入
    // 选中按钮
    // 导入按钮
    // 导入文案
    // 身份证拍照按钮

    // 创建界面
    override func createUI() {
        super.createUI()
        self.backgroundColor = MAIN_COLOR
        
        // 类别信息
        self.typeLabel.text = "手机号"
        self.typeLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.typeLabel.textColor = TEXT_SECOND_COLOR
        self.addSubview(self.typeLabel)
        self.typeLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(self.snp.left).offset(52 * WIDTH_SCALE)
        }
        
//        // 选中按钮
//        self.enterImageView.contentMode = .center
//        self.enterImageView.image = UIImage (named: "promptArrow")
//        self.addSubview(self.enterImageView)
//        self.enterImageView.snp.makeConstraints { (make) in
//            make.top.bottom.right.equalTo(self)
//            make.width.equalTo(30 * WIDTH_SCALE)
//        }
//
//
//        // 信息输入
//        self.infoField.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
//        self.infoField.textColor = TEXT_SECOND_COLOR
//        self.infoField.textAlignment = .right
//        self.infoField.placeholder = "请填写"
//        self.addSubview(self.infoField)
//        self.infoField.snp.makeConstraints { (make) in
//            make.top.bottom.equalTo(self)
//            make.right.equalTo(self.enterImageView.snp.left)
//            make.width.equalTo(200 * WIDTH_SCALE)
//        }
        
//        // 导入按钮
//        self.importBtn.setTitle("快捷导入", for: UIControlState.normal)
//        self.importBtn.layer.cornerRadius = 2 * WIDTH_SCALE
//        self.importBtn.layer.borderColor = UIColor().colorWithHexString(hex: "009CFF").cgColor
//        self.importBtn.setTitleColor(UIColor().colorWithHexString(hex: "009CFF"), for: UIControlState.normal)
//        self.importBtn.layer.borderWidth = 1 * WIDTH_SCALE
//        self.importBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
//        self.addSubview(self.importBtn)
//        self.importBtn.snp.makeConstraints { (make) in
//            make.top.equalTo(self.snp.top).offset(6 * HEIGHT_SCALE)
//            make.bottom.equalTo(self.snp.bottom).offset(-6 * HEIGHT_SCALE)
//            make.right.equalTo(self.snp.right).offset(-15 * WIDTH_SCALE)
//            make.width.equalTo(80 * WIDTH_SCALE)
//        }
//
//        // 导入文案
//        self.importText.text = "手机号"
//        self.importText.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
//        self.importText.textColor = TEXT_SECOND_COLOR
//        self.addSubview(self.importText)
//        self.importText.snp.makeConstraints { (make) in
//            make.top.bottom.equalTo(self)
//            make.right.equalTo(self.importBtn.snp.left).offset(-5 * WIDTH_SCALE)
//        }
        
        
        // 身份证拍照按钮
        self.cardBtn.setTitleColor(UIColor().colorWithHexString(hex: "B2B2B2"), for: UIControlState.normal)
        self.cardBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.cardBtn.setTitle("点击上传", for: UIControlState.normal)
        self.cardBtn.setImage(UIImage (named: "camera.png"), for: UIControlState.normal)
        self.cardBtn.setBackgroundImage(UIImage (named: "cardBackground.png"), for: UIControlState.normal)
        self.cardBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -7 * WIDTH_SCALE, 0, 0)
        self.addSubview(self.cardBtn)
        self.cardBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(6 * HEIGHT_SCALE)
            make.bottom.equalTo(self.snp.bottom).offset(-6 * HEIGHT_SCALE)
            make.right.equalTo(self.snp.right).offset(-15 * WIDTH_SCALE)
            make.width.equalTo(160 * WIDTH_SCALE)
        }
        
        
        let lineView : UIView = UIView()
        lineView.backgroundColor = LINE_COLOR2
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(self)
            make.height.equalTo(1 * HEIGHT_SCALE)
            make.left.equalTo(self.snp.left).offset(15 * WIDTH_SCALE)
        }
    }
}
