//
//  LoanApplicantType2CellCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/19.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias ApplicantType2Block = () -> Void
class LoanApplicantType2Cell: BasicViewCell {
    var typeLabel : UILabel = UILabel()// 类别信息
    var importText : UILabel = UILabel()// 导入文案
    var phoneTextLabel : UILabel = UILabel()// 电话号码
    var backBtn : UIButton = UIButton (type: UIButtonType.custom)// row的点击事件
    var applicantType2Block : ApplicantType2Block?// row的点击事件
    var regulaModel : ApplyRegulaModel = ApplyRegulaModel() {
        didSet{
            // 类别信息
            self.typeLabel.text = regulaModel.attribute_name
            
            // 导入文案 电话号码
            let array : [String] = self.regulaModel.selectValue.components(separatedBy: "|")
            if array.count == 2 {
                self.importText.text = array[0]
                self.phoneTextLabel.text = array[1]
            }
        }
    }
    
    // 创建界面
    override func createUI() {
        super.createUI()
        self.backgroundColor = MAIN_COLOR
        
        let view1 : UIView = UIView()
        self.contentView.addSubview(view1)
        view1.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.contentView)
            make.height.equalTo(44 * HEIGHT_SCALE)
        }
        
        // 类别信息
        self.typeLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.typeLabel.textColor = TEXT_SECOND_COLOR
        view1.addSubview(self.typeLabel)
        self.typeLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(view1)
            make.left.equalTo(view1.snp.left).offset(52 * WIDTH_SCALE)
        }
        
        
        // 导入按钮
        let importBtn : UIButton = UIButton (type: UIButtonType.custom)
        importBtn.setTitle("快捷导入", for: UIControlState.normal)
        importBtn.layer.cornerRadius = 2 * WIDTH_SCALE
        importBtn.layer.borderColor = UIColor().colorWithHexString(hex: "009CFF").cgColor
        importBtn.setTitleColor(UIColor().colorWithHexString(hex: "009CFF"), for: UIControlState.normal)
        importBtn.layer.borderWidth = 1 * WIDTH_SCALE
        importBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        view1.addSubview(importBtn)
        importBtn.snp.makeConstraints { (make) in
            make.top.equalTo(view1.snp.top).offset(6 * HEIGHT_SCALE)
            make.bottom.equalTo(view1.snp.bottom).offset(-6 * HEIGHT_SCALE)
            make.right.equalTo(view1.snp.right).offset(-15 * WIDTH_SCALE)
            make.width.equalTo(80 * WIDTH_SCALE)
        }

        // 导入文案
        self.importText.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.importText.textColor = UIColor.black
        view1.addSubview(self.importText)
        self.importText.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(view1)
            make.right.equalTo(importBtn.snp.left).offset(-5 * WIDTH_SCALE)
        }

        let lineView1 : UIView = UIView()
        lineView1.backgroundColor = LINE_COLOR2
        view1.addSubview(lineView1)
        lineView1.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(view1)
            make.height.equalTo(1 * HEIGHT_SCALE)
            make.left.equalTo(view1.snp.left).offset(15 * WIDTH_SCALE)
        }
        
        
        let view2 : UIView = UIView()
        self.contentView.addSubview(view2)
        view2.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(44 * HEIGHT_SCALE)
        }
        
        
        let phoneLabel : UILabel = UILabel()
        phoneLabel.text = "手机号码"
        phoneLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        phoneLabel.textColor = TEXT_SECOND_COLOR
        view2.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(view2)
            make.left.equalTo(view2.snp.left).offset(52 * WIDTH_SCALE)
        }
        
        
        // 电话号码
        self.phoneTextLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.phoneTextLabel.textColor = UIColor.black
        view2.addSubview(self.phoneTextLabel)
        self.phoneTextLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(view2)
            make.right.equalTo(view2.snp.right).offset(-15 * WIDTH_SCALE)
        }
        
        let lineView2 : UIView = UIView()
        lineView2.backgroundColor = LINE_COLOR2
        view2.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(view2)
            make.height.equalTo(1 * HEIGHT_SCALE)
            make.left.equalTo(view2.snp.left).offset(15 * WIDTH_SCALE)
        }
        
        self.backBtn.addTarget(self, action: #selector(backClick), for: UIControlEvents.touchUpInside)
        self.contentView.addSubview(self.backBtn)
        self.backBtn.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self.contentView)
        }
    }

    // 整个row的点击事件
    func backClick() -> Void {
        if self.applicantType2Block != nil {
            self.applicantType2Block!()
        }
    }
}
