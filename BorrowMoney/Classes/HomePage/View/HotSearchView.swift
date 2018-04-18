//
//  HotSearchView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/1/29.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias TagClickBlock = (Int) -> Void
class HotSearchView: UIView {
    var font : CGFloat = 12 * WIDTH_SCALE // 字体高度默认为12
    var textColor : UIColor = TEXT_LIGHT_COLOR// 默认字体的颜色
    var backColor : UIColor = UIColor.clear// 默认控件的背景颜色
    var textBorderColor : UIColor = TEXT_LIGHT_COLOR// 默认字体边框的颜色
    var verticalDistance : CGFloat = 8 * HEIGHT_SCALE// 默认垂直间的距离为5(第一行与第二行之间的距离)
    var horizontalDistance : CGFloat = 8 * WIDTH_SCALE// 默认水平间的距离为5(两个空间间的距离)
    var textHorizontalDistance : CGFloat = 8 * WIDTH_SCALE// 字两边距离边框的距离
    var verticalUI : CGFloat = 20 * HEIGHT_SCALE// 默认控件的高低位20
    var tagBlock : TagClickBlock?// 标签回调的点击事件
    var markAllHeight : CGFloat = 20 * HEIGHT_SCALE// 标签view的总高度
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
    }
    
    
    // 创建UI
    func createUI(dataArray : [String]) -> Void {
        var allWidth : CGFloat = 0// 当前标签的总长度
        var rowCount : CGFloat = 0// 行数
        var columnCount : CGFloat = 0// 列数
        
        // 整个View的宽度
        let viewWidth : CGFloat = self.frame.size.width
        if self.font > self.verticalUI {
            XPrint("文字的高度大于整个控件的高度。。。")
            // 设置默认高度
            self.font = 13 * WIDTH_SCALE
            self.verticalUI = 20 * HEIGHT_SCALE
        }
        
        for i in 0 ..< dataArray.count {
            let size : CGSize = self.sizeWithText(text: dataArray[i], font: UIFont.systemFont(ofSize: self.font) , maxSize: CGSize.init(width: self.frame.size.width, height: CGFloat(MAXFLOAT)))
            // 每个标签的宽度
            let btnWidth : CGFloat = size.width + self.textHorizontalDistance * 2

            // 现在的总宽度
            allWidth = allWidth + btnWidth
            
            // 当前的宽度已不够一个标签宽度，需要换行
            if allWidth > viewWidth {
                // 当前行数+1
                rowCount += 1
                // 换行时列数清空为0
                columnCount = 0
                // 当前标签宽度为0
                allWidth = 0
                // 换行后第一个控件的宽度
                allWidth = allWidth + btnWidth
            } else {
                
            }
            
            // 创建标签
            let btn : UIButton = UIButton (type: UIButtonType.custom)
            btn.tag = i
            btn.frame = CGRect (x: allWidth - btnWidth, y: rowCount * (self.verticalDistance + self.verticalUI), width: btnWidth, height: self.verticalUI)
            btn.setTitle(dataArray[i], for: UIControlState.normal)
            btn.setTitleColor(self.textColor, for: UIControlState.normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: self.font)
            btn.backgroundColor = backColor
            btn.layer.borderColor = self.textBorderColor.cgColor
            btn.layer.borderWidth = 0.8 * WIDTH_SCALE
            btn.layer.cornerRadius = 1.5 * WIDTH_SCALE
            btn.layer.masksToBounds = true
            btn.addTarget(self, action: #selector(tagClick(sender:)), for: UIControlEvents.touchUpInside)
            self.addSubview(btn)
            
            // 当前的宽度还可以放下一个标签
            if allWidth < viewWidth {
                allWidth = allWidth + self.horizontalDistance
                // 当前的列数+1
                columnCount += 1
            }
        }
        
        // 获取整个View的高度
        self.markAllHeight = self.verticalUI + (self.verticalUI + self.verticalDistance) * rowCount + 10 * HEIGHT_SCALE
    }
    
    
    // 标签的点击事件
    func tagClick(sender : UIButton) -> Void {
        if self.tagBlock != nil {
            self.tagBlock!(sender.tag)
        }
    }
}
