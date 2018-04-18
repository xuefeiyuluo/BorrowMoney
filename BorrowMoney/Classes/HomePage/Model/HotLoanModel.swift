//
//  HotLoanModel.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/12/1.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class HotLoanModel: NSObject {
    var apply_count : String? = ""//
    var channelName : String? = ""// 机构名称
    var channel_id : String? = ""//
    var descriptions : String? = ""//
    var interestUnit : String? = ""// 利率的类型 0日利率  1月利率
    var interestValue : String? = ""//
    var loan_id : String? = ""// 贷款ID
    var logo : String? = ""//
    var maxAmount : String? = ""//
    var maxTerms : String? = ""//
    var minAmount : String? = ""//
    var minTerms : String? = ""//
    var month_fee_rate : String? = ""// 月利率
    var name : String? = ""// 贷款名
    var rankType : String? = ""//
    var targetType : String? = ""// DETAIL跳转到详情页 APPLY_NOW跳转立即申请url
    var deviceType : String? = ""//
    var source : String? = ""// 来源
    var backFrom : Bool = false// 是否返回首页
    
    override func replacedKeyFromPropertyName() -> NSDictionary {
        return ["descriptions":"description"]
    }
    
}
