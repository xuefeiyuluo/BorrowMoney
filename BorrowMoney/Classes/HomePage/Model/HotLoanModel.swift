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
    var channelName : String? = ""//
    var channel_id : String? = ""//
    var descriptions : String? = ""//
    var interestUnit : String? = ""// 利率的类型 0日利率  1月利率
    var interestValue : String? = ""//
    var loan_id : String? = ""//
    var logo : String? = ""//
    var maxAmount : String? = ""//
    var maxTerms : String? = ""//
    var minAmount : String? = ""//
    var minTerms : String? = ""//
    var month_fee_rate : String? = ""//
    var name : String? = ""//
    var rankType : String? = ""//
    var targetType : String? = ""//
    var deviceType : String? = ""//
//    var arguments : NSDictionary?//
    
    override func replacedKeyFromPropertyName() -> NSDictionary {
        return ["descriptions":"description"]
    }
    
}
