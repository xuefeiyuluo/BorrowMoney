//
//  LoanDetailModel.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/13.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class ApplyModel: NSObject {
    var applyId : String = ""//
    var logo : String = ""//
    var name : String = ""//
    var flowId : String = ""//
    var productId : String = ""//
    
    override func replacedKeyFromPropertyName() -> NSDictionary {
        return ["applyId":"id"]
    }
}


class LoanDetailModel: NSObject {
    var apkName : String = ""//
    var product_id : String = ""//
    var apply_status : String = ""//
    var interestDisplay : String = ""// 判断是否有每月还款金额的View "1"有
    var materials : String = ""//
    var descriptions : String = ""//
    var max_terms : String = ""// 贷款最高期限值
    var min_terms : String = ""// 贷款最低期限值
    var flowList : [ApplyModel] = [ApplyModel]()// 审核资料列表
    var max_amount : String = ""// 贷款的最大金额
    var min_amount : String = ""// 贷款的最小金额
    var wapSupportIframe : String = ""//
    var allowTerms : String = ""// 借款期限是否可以选择
    var serviceRate : String = ""//
    var condition_count : String = ""//
    var availableStatus : String = ""//
    var conditions : String = ""// 申请条件文案
    var systemTips : String = ""// 借小二亲测文案
    var interestUnit : String = ""// 借款期限类型 “1”表示以月为单位
    var interestValue : String = ""// 贷款利率
    var repaymentName : String = ""//
    var meet_condition : String = ""//
    var acceptNewApi : String = ""//
    var success_rate : String = ""//
    var apply_count : String = ""//
    var newLoanName : String = ""//
    var interfaceType : String = ""//
    var month_fee_rate : String = ""// 月利率
    var dbInterest : String = ""// 日利率
    var accessControl : NSArray = []//
    var serviceFeeBy : String = ""//
    var loan_channel_id : String = ""//
    var guideUrl : String = ""//
    var online : String = ""//
    var name : String = ""//
    var min_duration : String = ""//
    var showAmountDetail : String = ""//
    var interestOri : String = ""//
    var defaultAmount : String = ""//
    var logo : String = ""//
    var channelName : String = ""//
    var apkDownloadURL : String = ""//
    var apply_url : String = ""//
    var overLimitType : String = ""//
    var commissionRate : String = ""//
    var prodCommConfigId : String = ""//
    var min_duration_value : String = ""// 最快放款时间
    var min_duration_unit : String = ""// 最快放款时间单位
    var IOSDownloadURL : String = ""//
    var tips : String = ""//
    var defaultTerms : String = ""//
    var tagList : NSArray = []//
    var inputAmount : String = ""// 借款金额
    var inputTerms : String = ""// 借款期限
    var conditionState : Bool = false// 申请条件的是否展开的状态
    var jxrState : Bool = false// 借小二的是否展开的状态
    
    
    override func replacedKeyFromPropertyName() -> NSDictionary {
        return ["descriptions":"description"]
    }
    
    static func customClassMapping() -> [String : String]? {
        return["flowList":"ApplyModel"]
    }
}
