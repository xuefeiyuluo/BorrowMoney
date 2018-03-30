//
//  EvaluateMarkView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/22.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias EvaluateBlock = (Int) -> Void
class EvaluateMarkView: BasicView {
    var goodBtn : UIButton = UIButton()// 赞一下
    var badBtn : UIButton = UIButton()// 吐槽
    var scrollLine : UIView = UIView()// 滚动的横线
    var uiArray : [UIButton] = [UIButton]()// 标签的数组
    var currentTag : Int = 0// 默认是“赞的”
    var evaluateBlock : EvaluateBlock?// 评价标签的选择
    var tagArray : [TagModel] = [TagModel]()// 标签列表

    
    // 创建UI
    override func createUI() {
        super.createUI()
        
        self.backgroundColor = UIColor.white
        // 更多评论
        let moreLabel : UILabel = UILabel()
        moreLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        moreLabel.textColor = UIColor().colorWithHexString(hex: "5A5A5A")
        moreLabel.text = "更多评论"
        self.addSubview(moreLabel)
        moreLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15 * WIDTH_SCALE)
            make.height.equalTo(45 * HEIGHT_SCALE)
            make.top.equalTo(self.snp.top)
        }
        
        let lineView1 : UIView = UIView()
        lineView1.backgroundColor = LINE_COLOR2
        self.addSubview(lineView1)
        lineView1.snp.makeConstraints { (make) in
            make.top.equalTo(moreLabel.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        
        let btnView : UIView = UIView()
        self.addSubview(btnView)
        btnView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(moreLabel.snp.bottom)
            make.height.equalTo(46 * HEIGHT_SCALE)
        }
        
        let lineView2 : UIView = UIView()
        lineView2.backgroundColor = LINE_COLOR2
        btnView.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(btnView)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        
        // 赞一下
        self.goodBtn.setTitle("赞一下", for: UIControlState.normal)
        self.goodBtn.setTitleColor(UIColor().colorWithHexString(hex: "5A5A5A"), for: UIControlState.normal)
        self.goodBtn.isSelected = true
        self.goodBtn.addTarget(self, action: #selector(operationClick(sender:)), for: UIControlEvents.touchUpInside)
        self.goodBtn.tag = 0
        self.goodBtn.setTitleColor(NAVIGATION_COLOR, for: UIControlState.selected)
        self.goodBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        btnView.addSubview(self.goodBtn)
        self.goodBtn.snp.makeConstraints { (make) in
            make.left.top.equalTo(btnView)
            make.bottom.equalTo(lineView2.snp.top)
            make.width.equalTo((SCREEN_WIDTH - 1 * WIDTH_SCALE) / 2)
        }
        
        let verticalLine : UIView = UIView()
        verticalLine.backgroundColor = LINE_COLOR2
        btnView.addSubview(verticalLine)
        verticalLine.snp.makeConstraints { (make) in
            make.left.equalTo(self.goodBtn.snp.right)
            make.width.equalTo(1 * WIDTH_SCALE)
            make.top.equalTo(btnView.snp.top).offset(12 * HEIGHT_SCALE)
            make.bottom.equalTo(btnView.snp.bottom).offset(-12 * HEIGHT_SCALE)
        }
        
        // 我要吐槽
        self.badBtn.setTitle("我要吐槽", for: UIControlState.normal)
        self.badBtn.addTarget(self, action: #selector(operationClick(sender:)), for: UIControlEvents.touchUpInside)
        self.badBtn.tag = 1
        self.badBtn.setTitleColor(UIColor().colorWithHexString(hex: "5A5A5A"), for: UIControlState.normal)
        self.badBtn.setTitleColor(NAVIGATION_COLOR, for: UIControlState.selected)
        self.badBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        btnView.addSubview(self.badBtn)
        self.badBtn.snp.makeConstraints { (make) in
            make.top.equalTo(btnView)
            make.bottom.equalTo(lineView2.snp.top)
            make.left.equalTo(verticalLine.snp.right)
            make.width.equalTo((SCREEN_WIDTH - 1 * WIDTH_SCALE) / 2)
        }
        
        // 滚动的横线
        self.scrollLine.backgroundColor = NAVIGATION_COLOR
        self.scrollLine.frame = CGRect (x: 0, y: 44 * HEIGHT_SCALE, width: SCREEN_WIDTH / 2, height: 2 * HEIGHT_SCALE)
        btnView.addSubview(self.scrollLine)
        
        
        let view : UIView = UIView()
        self.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.snp.right).offset(-10 * WIDTH_SCALE)
            make.top.equalTo(self.scrollLine.snp.bottom).offset(15 * HEIGHT_SCALE)
            make.height.equalTo(80 * HEIGHT_SCALE)
        }
        
        let btnWidth : CGFloat = (SCREEN_WIDTH - (20 + 40) * WIDTH_SCALE) / 3
        
        for i in 0 ..< 6 {
            let btn : UIButton = UIButton (type: UIButtonType.custom)
            btn.tag = i
            btn.addTarget(self, action: #selector(markClick(sender:)), for: UIControlEvents.touchUpInside)
            btn.layer.cornerRadius = 3 * WIDTH_SCALE
            btn.layer.borderWidth = 1 * WIDTH_SCALE
            btn.layer.borderColor = NAVIGATION_COLOR.cgColor
            btn.layer.masksToBounds = true
            btn.setTitleColor(NAVIGATION_COLOR, for: UIControlState.normal)
            btn.setTitleColor(UIColor.white, for: UIControlState.selected)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
            view.addSubview(btn)
            
            // 行数
            let row : CGFloat = CGFloat(i / 3)
            // 列数
            let column : CGFloat = CGFloat(i % 3)
        
            btn.snp.makeConstraints { (make) in
                make.left.equalTo(view.snp.left).offset(column * btnWidth + column * 20 * WIDTH_SCALE)
                make.top.equalTo(view.snp.top).offset(row * 45 * HEIGHT_SCALE)
                make.width.equalTo(btnWidth)
                make.height.equalTo(30 * HEIGHT_SCALE)
            }
        
            // 按钮列表
            self.uiArray.append(btn)
        }
    }
    
    
    // 更新标签
    func updateMarkBtn(tagArray : [TagModel]) -> Void {
        if tagArray.count >= 6 {
            self.tagArray = tagArray
            let btnWidth : CGFloat = (SCREEN_WIDTH - (20 + 40) * WIDTH_SCALE) / 3
            for i in 0 ..< self.uiArray.count {
                let btn : UIButton = self.uiArray[i]
                btn.isSelected = false
                let model : TagModel = tagArray[i]
                model.tagSelector = "0"
                btn.setTitle(model.tagName, for: UIControlState.normal)
                btn.setTitleShadowColor(UIColor.clear, for: UIControlState.normal)
                if self.currentTag == 0 {
                    btn.layer.borderColor = NAVIGATION_COLOR.cgColor
                    btn.setBackgroundImage(UIImage().imageCustom(color: NAVIGATION_COLOR, size: CGSize.init(width: btnWidth, height: 30 * HEIGHT_SCALE)), for: UIControlState.selected)
                    btn.setBackgroundImage(UIImage().imageCustom(color: UIColor.clear, size: CGSize.init(width: btnWidth, height: 30 * HEIGHT_SCALE)), for: UIControlState.normal)
                } else {
                    btn.layer.borderColor = LINE_COLOR3.cgColor
                    btn.setBackgroundImage(UIImage().imageCustom(color: LINE_COLOR3, size: CGSize.init(width: btnWidth, height: 30 * HEIGHT_SCALE)), for: UIControlState.selected)
                    btn.setBackgroundImage(UIImage().imageCustom(color: UIColor.clear, size: CGSize.init(width: btnWidth, height: 30 * HEIGHT_SCALE)), for: UIControlState.normal)
                }
            }
        }
    }
    
    
    // 赞一下与吐槽的点击事件
    func operationClick(sender : UIButton) -> Void
    {
        self.currentTag = sender.tag
        if sender.tag == 0 {
            self.goodBtn.isSelected = !self.goodBtn.isSelected
            self.badBtn.isSelected = false
        } else {
            self.badBtn.isSelected = !self.badBtn.isSelected
            self.goodBtn.isSelected = false
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.scrollLine.frame = CGRect (x: CGFloat(sender.tag) * SCREEN_WIDTH / 2, y: 44 * HEIGHT_SCALE, width: SCREEN_WIDTH / 2, height: 2 * HEIGHT_SCALE)
        })
        if self.evaluateBlock != nil {
           self.evaluateBlock!(self.currentTag)
        }
    }
    
    
    // 标签的点击事件
    func markClick(sender : UIButton) -> Void
    {
        let btn : UIButton = self.uiArray[sender.tag]
        btn.isSelected = true
    }
    
    
    // 获取选中的标签
    func requestTagList() -> Void {
        
    }
}
