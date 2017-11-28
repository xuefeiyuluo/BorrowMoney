//
//  LoanProductsModel.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/25.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class LoanProductsModel: NSObject {
    
    var updateTime : NSString?//
    var totalCount : NSString?//
    var totalAmount : NSString?//
    var loanList : NSArray?//
    var thirdLoanRecordList : NSArray?//
    var currentRepayAmount : NSString?// 应还金额
    var currentRepayDays : NSString?// 应还日期
    var type : NSString?// 类型 有逾期HAD_OVERDUED、无逾期NORMAL_REPAY、无贷款应还或未登陆NO_LOAN
    
}
