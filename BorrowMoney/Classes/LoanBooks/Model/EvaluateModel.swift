//
//  EvaluateModel.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/17.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class EvaluateModel: NSObject {
    var coment : String = ""// 评价内容
    var mobilephone : String = ""// 手机号码
    var tagPriority : String = ""//
    var commentTime : String = ""// 评价时间
    var tag : String = ""// 评价标签
    var score : String = ""// 评分
    var applyTime : String = ""// 申请时间
    var applyAmount : String = ""// 申请金额
    var markArray : [String] {// 标签数组
        set{}
        get{
            if self.tag.isEmpty {
                return [String]()
            } else {
                let markArray : [String] = self.tag.components(separatedBy: ",") as [String]
                return markArray
            }
        }
    }
    var contentHeight : CGFloat{// 内容的高度
        set{}
        get{
            var tempHeight : CGFloat = 0.0
            // 计算mark的高度
            if self.markArray.count > 0 {
                let markView : HotSearchView = HotSearchView()
                markView.frame = CGRect (x: 0, y: 0, width: SCREEN_WIDTH - 20 * HEIGHT_SCALE, height: SCREEN_HEIGHT)
                markView.createUI(dataArray: self.markArray)
                tempHeight = markView.markAllHeight
            }
            // 计算文案的高度
            if !self.coment.isEmpty {
                let size : CGSize = self.sizeWithText(text: self.coment, font: UIFont.systemFont(ofSize: 13 * WIDTH_SCALE), maxSize: CGSize.init(width: SCREEN_WIDTH - 20 * WIDTH_SCALE, height: CGFloat(MAXFLOAT)))
                tempHeight = tempHeight + size.height + 1
            }
            return tempHeight
        }
    }
    
}
