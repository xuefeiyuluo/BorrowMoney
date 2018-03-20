//
//  BillDetailModel.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/19.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class BillDetailModel: NSObject {
    var interestAmount = "";// 总利息
    var applicationURL : String = ""// 申请链接
    var changeCardDesc : String = ""// 换卡的文案提示
    var changeCardUrl : String = ""// 换卡跳转地址
    var channelId : String = ""// 机构id
    var confirmDesc : String = ""// 用户点击还款按钮后的二次确认文案，无此字段则显示默认文案
    var confirmText : String = ""// 弹框文案
    var currentRepayAmount : String = ""// 本期应还
    var lastUpdateTime : String = ""// 最后更新时间
    var loanChannelName : String = ""// 机构名称
    var loanType : String = ""// 贷款类型 自家api: API 第三方账户:THIRD_PARTY
    var planList : [PlanModel] = [PlanModel]()// 贷款分期列表
    var prepayUrl : String = ""// 信贷云还款url
    var productLogo : String = ""// 机构logo
    var recordId : String = ""//
    var repaymentDesc : String = ""// 提示信息
    var repaymentType : String = ""// 立即还款类型 HTML类型为网页地址 API为请求地址 NONE 不支持立即还款
    var repaymentURL : String = ""// 立即还款url HTML类型为网页地址 API为请求地址 NONE 显示文案
    var tips : String = ""// 提示信息
    var totalAmount : String = ""// 借款金额
    var totalPeriod : String = ""// 总笔数
    var totalRepayAmount : String = ""// 总还款金额
    var xdyFlag : String = ""// 信贷云产品标识，不包含此字段则为非信贷云产品
    var loanId : String = ""// 贷款id
    var loanUser : String = ""// 借款人账户
    
    static func customClassMapping() -> [String : String]? {
        return["planList":"PlanModel"]
    }
}
