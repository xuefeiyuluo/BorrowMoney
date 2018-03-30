//
//  EvaluateHeaderView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/22.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias StarBlock = (Int) -> Void
class EvaluateHeaderView: BasicView, UITextViewDelegate {
    let iconImageView : UIImageView = UIImageView()// 图标
    let numberLabel : UILabel = UILabel()// 0/140
    let placeHolder : UILabel = UILabel()// 提示信息
    let evaluateView : UITextView = UITextView()// 评价文案
    var uiArray : [UIButton] = [UIButton]()// 评价星星
    var starBlock : StarBlock?// 评价星星的回调
    var url : String? {
        didSet{
            // 机构图标
            self.iconImageView.kf.setImage(with:URL (string: url!), placeholder: UIImage (named: "defaultWait.png"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    
    // 创建UI
    override func createUI() {
        super.createUI()
        self.backgroundColor = UIColor.white
        
        // 机构图标
        self.addSubview(self.iconImageView)
        self.iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15 * WIDTH_SCALE)
            make.top.equalTo(self.snp.top).offset(18 * HEIGHT_SCALE)
            make.width.equalTo(56 * WIDTH_SCALE)
            make.height.equalTo(56 * WIDTH_SCALE)
        }
        
        let evaluateText1 : UILabel = UILabel()
        evaluateText1.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        evaluateText1.textColor = TEXT_SECOND_COLOR
        evaluateText1.text = "整体评价"
        self.addSubview(evaluateText1)
        evaluateText1.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconImageView.snp.right).offset(15 * WIDTH_SCALE)
            make.top.equalTo(self.snp.top).offset(20 * HEIGHT_SCALE)
        }
        
        let evaluateText2 : UILabel = UILabel()
        evaluateText2.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        evaluateText2.textColor = LINE_COLOR3
        evaluateText2.text = "满意请给5颗星哦！"
        self.addSubview(evaluateText2)
        evaluateText2.snp.makeConstraints { (make) in
            make.left.equalTo(evaluateText1.snp.right).offset(5 * WIDTH_SCALE)
            make.bottom.equalTo(evaluateText1)
        }
        
        // 星星的View
        let starView : UIView = UIView()
        self.addSubview(starView)
        starView.snp.makeConstraints { (make) in
            make.top.equalTo(evaluateText1.snp.bottom).offset(3 * HEIGHT_SCALE)
            make.left.equalTo(evaluateText1)
            make.height.equalTo(40 * HEIGHT_SCALE)
            make.right.equalTo(self.snp.right).offset(-15 * WIDTH_SCALE)
        }
        
        
        for i in 0 ..< 5 {
            let starBtn : UIButton = UIButton (type: UIButtonType.custom)
            starBtn.setImage(UIImage (named: "starNormal.png"), for: UIControlState.normal)
            starBtn.setImage(UIImage (named: "starSelector.png"), for: UIControlState.selected)
            starBtn.addTarget(self, action: #selector(starClick(sender:)), for: UIControlEvents.touchUpInside)
            starBtn.tag = i
            starView.addSubview(starBtn)
            starBtn.snp.makeConstraints { (make) in
                make.left.equalTo(starView.snp.left).offset(CGFloat(i) * 40 * WIDTH_SCALE)
                make.top.bottom.equalTo(starView)
                make.width.equalTo(40 * WIDTH_SCALE)
            }
            self.uiArray.append(starBtn)
        }
        
        
        // 填写评论的view
        let textView : UIView = UIView()
        textView.backgroundColor = UIColor().colorWithHexString(hex: "F4FBFC")
        textView.layer.borderWidth = 1 * WIDTH_SCALE
        textView.layer.borderColor = UIColor().colorWithHexString(hex: "b3b3b3").cgColor
        textView.layer.cornerRadius = 3 * WIDTH_SCALE
        textView.layer.masksToBounds = true
        self.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(90 * HEIGHT_SCALE)
            make.height.equalTo(100 * HEIGHT_SCALE)
            make.left.equalTo(self.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.snp.right).offset(-10 * WIDTH_SCALE)
        }
        
        // 字数
        self.numberLabel.textColor = UIColor().colorWithHexString(hex: "B2B2B2")
        self.numberLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.numberLabel.textAlignment = NSTextAlignment.right
        textView.addSubview(self.numberLabel)
        self.numberLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(textView.snp.bottom).offset(-5 * HEIGHT_SCALE)
            make.right.equalTo(textView.snp.right).offset(-5 * WIDTH_SCALE)
            make.width.equalTo(60 * WIDTH_SCALE)
        }
        
        
        // 评价文案
        self.evaluateView.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.evaluateView.backgroundColor = UIColor.clear
        self.evaluateView.delegate = self
        textView.addSubview(self.evaluateView)
        self.evaluateView.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.top).offset(8 * HEIGHT_SCALE)
            make.left.equalTo(textView.snp.left).offset(8 * WIDTH_SCALE)
            make.right.equalTo(textView.snp.right).offset(-8 * WIDTH_SCALE)
            make.bottom.equalTo(self.numberLabel.snp.top).offset(-3 * HEIGHT_SCALE)
        }
        
        
        // 提示信息
        self.placeHolder.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        self.placeHolder.numberOfLines = 0
        self.placeHolder.text = "写下贷款体验和感受来帮助其他小伙伴~\n评价满20个字即可获得10积分！"
        self.placeHolder.textColor = UIColor().colorWithHexString(hex: "B2B2B2")
        textView.addSubview(self.placeHolder)
        self.placeHolder.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.top).offset(13 * HEIGHT_SCALE)
            make.left.equalTo(textView.snp.left).offset(13 * WIDTH_SCALE)
            make.right.equalTo(textView.snp.right).offset(-8 * WIDTH_SCALE)
            make.height.equalTo(30 * HEIGHT_SCALE)
        }
        
        
        let lineView : UIView = UIView()
        lineView.backgroundColor = LINE_COLOR2
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
    }
    
    
    // MARK: UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        if textView.markedTextRange == nil {
            if textView.text.count <= 140 {
                if textView.text.count > 0 {
                    self.placeHolder.isHidden = true
                } else {
                    self.placeHolder.isHidden = false
                }
                self.numberLabel.text = String (format: "%li/140", textView.text.count)
            } else {
                self.placeHolder.isHidden = true
                textView.text = textView.text.substringInRange(0...139)
                self.numberLabel.text = "140/140"
            }
        } else {
            self.placeHolder.isHidden = true
        }
    }
    
    
    // 星星的点击事件
    func starClick(sender : UIButton) -> Void {
        for i in 0 ..< self.uiArray.count {
            let btn : UIButton = self.uiArray[i]
            if i <= sender.tag {
                btn.isSelected = true
            } else {
                btn.isSelected = false
            }
        }
        if self.starBlock != nil {
            self.starBlock!(2)
        }
    }
    
}
