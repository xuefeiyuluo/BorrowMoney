//
//  LoanManageModel.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/29.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class LoanManageData: NSObject {
    var loanChannelName : String?// 机构名称
    //    // NORMAL_REPAY //正常还款 HAD_OVERDUED//已逾期 UPDATING//更新数据中 PASSWORD_ERROR//账号密码错误 NO_LOAN//无贷款信息 DATA_EXCEPTION//账户异常
    var status : String?// 贷款状态
    var loanChannelId : String?// 机构id
    var productLogo : String?// 产品logo
    var currentRepayAmount : String?// 当期应还
    var currentRepayDays : String?// 应还日期
    var repayDate : String?//
    var errorCode : String?// 错误码
    var loanUser : String?// 用户名
    var recordId : String?// 贷款id
    var planId : String?// 分期id
    var accountId : String?// 账户Id
    var updateTime : String?// 更新时间
    var updateTimeStr : String?// 更新时间文案
    var loanType : String?// 贷款类型 自家api: API 第三方账户:THIRD_PARTY
    var repaymentType : String?// 立即还款类型 HTML类型为网页地址 API为请求地址 NONE 不支持立即还款
    var repaymentURL : String?// 立即还款url
    var repaymentSate : Bool  = false// 立即还款的按钮状态
    var refreshImageSate : Bool = false// 数据异常的按钮状态
    var confirmText : String?// 还款提示文案
}


class LoanManageModel: NSObject {
    var totalCount : String?// 应还几期
    var totalRepayAmount : String?// 总金额
    var currentRepayAmount : String?// 当期应还
    var currentRepayDays : String?// 距应还天数
    //    // 贷款状态 NORMAL_REPAY //正常还款 HAD_OVERDUED//已逾期 UPDATING//更新数据中 PASSWORD_ERROR//账号密码错误 NO_LOAN//无贷款信息 DATA_EXCEPTION//数据异常
    var status : String?// 状态
    var loanList : NSArray = []// 还款管理列表
    
    static func customClassMapping() -> [String : String]? {
        return["loanList":"LoanManageData"]
    }

}
