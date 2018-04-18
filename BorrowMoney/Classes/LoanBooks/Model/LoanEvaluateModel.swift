//
//  LoanEvaluateModel.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/17.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class MarkModel: NSObject {
    var tagName : String = ""//
    var tagCount : String = ""//
}



class LoanEvaluateModel: NSObject {
    var commentTag : [MarkModel] = [MarkModel]()// 标签数组
    var badComment : String = ""//
    var goodComment : String = ""//
    var normalComment : String = ""//
    var commentCount : String = ""// 全部评论
    var commentList : [EvaluateModel] = [EvaluateModel]()// 评论数组
    var markArray : [String] {// 标签数组
        set {}
        get{
            var tempArray : [String] = [String]()
            for model : MarkModel in self.commentTag {
                tempArray.append(String (format: "%@(%@)", model.tagName,model.tagCount))
            }
            return tempArray
        }
    }
    
    var markHeight : CGFloat {// 标签的高度
        set {}
        get{
            // 计算高度
            let markView : HotSearchView = HotSearchView()
            markView.frame = CGRect (x: 0, y: 0, width: SCREEN_WIDTH - 20 * HEIGHT_SCALE, height: SCREEN_HEIGHT)
            markView.createUI(dataArray: self.markArray)
            return markView.markAllHeight
        }
    }
    
    
    static func customClassMapping() -> [String : String]? {
        return["commentTag":"MarkModel","commentList":"EvaluateModel"]
    }
}
