//
//  OrderManageModel.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/6.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class OrderManageModel: NSObject {
    var canRepay : String = ""// “去还款” bool类型
    var loanAmount : String = ""// 金额
    var loanApplyUrl : String = ""//
    var loanChannelId : String = ""// 机构id
    var loanChannelLogo : String = ""// 机构图标
    var loanChannelName : String = ""// 机构名称
    var loanId : String = ""// 贷款ID
    var loanName : String = ""// 贷款名
    var loanOrderId : String = ""//
    var loanTerms : String = ""// 分期
    var loanType : String = ""// 贷款类型 API、第三方账户:THIRD_PARTY、数据回传DATA_PUSH
    var orderId : String = ""// 贷款id
    var orderTime : String = ""// 申请时间
    var status : String = ""// 1订单取消，2审核中，3审核失败，4审核成功，5放款失败， 6正常还款中，7逾期待还，8已还清
    var statusDesc : String = ""// 订单状态文案
    var updateTime : String = ""//
    var withdraw : String = ""// “签约提现” bool类型
    var needRepayAmount : String = ""// 当期应还
    var needRepayTime : String = ""// 当前还款日期
    var overdueAmount : String = ""// 逾期总额
    var overdueTime : String = ""// 逾期天数
    // cell的类型
    var cellSate : String {
        set {
            
        }
        get {
            if self.status == "6" {
                if !self.needRepayAmount.isEmpty && !self.needRepayTime.isEmpty {
                    return "2"
                } else {
                    return "1"
                }
            } else if self.status == "7" {
                if !self.overdueAmount.isEmpty && !self.overdueTime.isEmpty {
                    return "2"
                } else {
                    return "1"
                }
            } else {
                return "1"
            }
        }
    }
    
    
}
