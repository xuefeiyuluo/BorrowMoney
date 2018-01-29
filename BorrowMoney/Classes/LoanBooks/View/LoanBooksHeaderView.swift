//
//  LoanBooksHeaderView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/12/5.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

typealias TapClickType = (String) -> Void
class LoanBooksHeaderView: UIView {
    lazy var headerView : UIView = UIView()
    lazy var dataArray : [String] = ["金额不限","所有贷款类型","排序"]
    var uiArray : [UIButton] = [UIButton]()// 数组控件
    var tapClickType : TapClickType?// 头部点击 "amount"  "loanType" "sort"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 创建界面
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // 创建界面
    func createUI() -> Void {
        self.backgroundColor = UIColor.white
        let viewWidth : CGFloat = SCREEN_WIDTH / 3
        self.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(40 * HEIGHT_SCALE)
        }
        
        for i in 0 ..< 3 {
            let view : UIButton = UIButton (type: UIButtonType.custom)
            view.tag = i
            view.addTarget(self, action: #selector(tapClick(sender:)), for: UIControlEvents.touchUpInside)
            self.headerView.addSubview(view)
            view.snp.makeConstraints({ (make) in
                make.top.bottom.equalTo(self.headerView)
                make.width.equalTo(viewWidth)
                make.left.equalTo(self.headerView.snp.left).offset(CGFloat(i) * viewWidth)
            })

            var size : CGSize = self.sizeWithText(text: dataArray[i], font: UIFont.boldSystemFont(ofSize: 13 * WIDTH_SCALE) , maxSize: CGSize.init(width: CGFloat(MAXFLOAT), height: 13 * WIDTH_SCALE))
            if size.width > viewWidth - 14 * WIDTH_SCALE {
                size.width = viewWidth - 14 * WIDTH_SCALE
            }
            let textLabel : UILabel = UILabel()
            textLabel.text = self.dataArray[i]
            textLabel.font = UIFont.boldSystemFont(ofSize: 13 * WIDTH_SCALE)
            textLabel.textColor = TEXT_BLACK_COLOR
            textLabel.textAlignment = NSTextAlignment.center
            textLabel.tag = 1000
            view.addSubview(textLabel)
            textLabel.snp.makeConstraints({ (make) in
                make.top.bottom.equalTo(view)
                make.left.equalTo(view.snp.left).offset((viewWidth - size.width - 17 * WIDTH_SCALE) / 2)
            })
            
            let img : UIImageView = UIImageView()
            img.tag = 1001
            img.image = UIImage (named: "write_Arrow")
            img.contentMode = .center
            img.isUserInteractionEnabled = true
            view.addSubview(img)
            img.snp.makeConstraints({ (make) in
                make.top.bottom.equalTo(view)
                make.left.equalTo(textLabel.snp.right).offset(3 * WIDTH_SCALE)
                make.width.equalTo(14 * WIDTH_SCALE)
            })
            
            if i != 2 {
                let lineView : UIView = UIView()
                lineView.backgroundColor = LINE_COLOR2
                view.addSubview(lineView)
                lineView.snp.makeConstraints({ (make) in
                    make.right.equalTo(view)
                    make.width.equalTo(1 * WIDTH_SCALE)
                    make.top.equalTo(view.snp.top).offset(8 * HEIGHT_SCALE)
                    make.bottom.equalTo(view.snp.bottom).offset(-8 * HEIGHT_SCALE)
                })
            }
            
            // 添加控件到数组中
            self.uiArray.append(view)
        }
        
        // 横线
        let lineView : UIView = UIView()
        lineView.backgroundColor = LINE_COLOR2
        self.headerView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.headerView)
            make.top.equalTo(39 * HEIGHT_SCALE)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
    }
    
    
    // 按钮的点击事件
    func tapClick(sender: UIButton) -> Void {
        // 更改头部控件的样式
        updateHeaderUI(sender: sender)
        
        var type : String = ""
        if sender.tag == 0 {
            type = "amount"
        } else if sender.tag == 1 {
            type = "loanType"
        } else if sender.tag == 2 {
            type = "sort"
        }
        
        weak var weakSelf = self
        if self.tapClickType != nil {
            weakSelf?.tapClickType!(type)
        }
    }
    
    
    // 更改头部控件的样式
    func updateHeaderUI(sender: UIButton) -> Void {
        for i in 0 ..< self.uiArray.count {
            let btn : UIButton = self.uiArray[i] as UIButton;
            let text : UILabel = btn.viewWithTag(1000) as! UILabel
            let img : UIImageView = btn.viewWithTag(1001) as! UIImageView
            if sender.tag == i {
                btn.isSelected = !btn.isSelected
                if btn.isSelected {
                    text.textColor = NAVIGATION_COLOR
                    img.image = UIImage (named: "write_Arrow_on")
                } else {
                    text.textColor = TEXT_BLACK_COLOR
                    img.image = UIImage (named: "write_Arrow")
                }
                // 图标动画
                imageAnimation(img: img,direction: btn.isSelected)
            } else {
                text.textColor = TEXT_BLACK_COLOR
                img.image = UIImage (named: "write_Arrow")
                if btn.isSelected {
                    btn.isSelected = false
                    // 图标动画
                    imageAnimation(img: img,direction: btn.isSelected)
                }
            }
        }
    }
    
    
    // 图标动画改变
    func imageAnimation(img : UIImageView,direction : Bool) -> Void {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = M_PI
        anim.duration = 1
        anim.repeatCount = MAXFLOAT
        anim.isRemovedOnCompletion = true
        img.layer.add(anim, forKey: nil)
        img.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.2) {
            img.transform = img.transform.rotated(by: CGFloat(M_PI))
        }
    }
    
    
    // 改变头部文案
    func changeHeaderButtonText(tag : Int, titleText : String) -> Void {
        let changeView : UIButton = self.uiArray[tag];
        let changeLabel : UILabel = changeView.viewWithTag(1000) as! UILabel
        let imgView : UIImageView = changeView.viewWithTag(1001) as! UIImageView
        
        let viewWidth : CGFloat = SCREEN_WIDTH / 3
        var size : CGSize = self.sizeWithText(text: titleText, font: UIFont.boldSystemFont(ofSize: 13 * WIDTH_SCALE) , maxSize: CGSize.init(width: CGFloat(MAXFLOAT), height: 13 * WIDTH_SCALE))
        if size.width > viewWidth - 14 * WIDTH_SCALE {
            size.width = viewWidth - 14 * WIDTH_SCALE
        }

        changeLabel.snp.updateConstraints({ (make) in
            make.top.bottom.equalTo(changeView)
            make.left.equalTo(changeView.snp.left).offset((viewWidth - size.width - 17 * WIDTH_SCALE) / 2)
        })
        imgView.snp.updateConstraints({ (make) in
            make.top.bottom.equalTo(changeView)
            make.left.equalTo(changeLabel.snp.right).offset(3 * WIDTH_SCALE)
            make.width.equalTo(14 * WIDTH_SCALE)
        })
        changeLabel.text = titleText
    }
    
    
    // 点击蒙层改变点击的状态
    func animationForBtnTag(tag : Int) -> Void {
        let changeView : UIButton = self.uiArray[tag];
        updateHeaderUI(sender: changeView)
    }
}
