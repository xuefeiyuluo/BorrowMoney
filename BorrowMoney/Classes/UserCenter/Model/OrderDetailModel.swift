//
//  OrderDetailModel.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/14.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit


class ProtocolModel: NSObject {
    var contract_name : String = ""// 合同名称
    var url : String = ""// 合同url
}


class PlanModel: NSObject {
    var period : String = ""// 当前期数
    var planId : String = ""//
    var repayAmount : String = ""// 金额
    var repayDate : String = ""// 日期
    var status : String = ""// 状态  0=未出账 1=待还款 2=正常结清 3=逾期结清 4=逾期
    var statusStr : String = ""// 状态文案
    var selectedId : Bool = false// 是否选中   YES为选中   NO未选中
    
    
    
    
}


class OrderDetailModel: NSObject {

    var orderId : String = ""//
    var loanApplyUrl : String = ""// 去还款按钮的html5页面
    var canRepay : String = ""// 去还款按钮
    var orderDesc : String = ""// 订单状态下面文案
    var status : String = ""// 1订单取消，2审核中，3审核失败，4审核成功，5放款失败， 6正常还款中，7逾期待还，8已还清
    var loanOrderId : String = ""//
    var recommendationList : NSArray = []// 已无效
    var loanName : String = ""// 贷款产品名称
    var loanChannelLogo : String = ""// 机构的icon
    var updateTime : String = ""//
    var loanId : String = ""//
    var loanAmount : String = ""// 贷款金额
    var withdraw : String = ""// 签约提现的按钮
    var loanType : String = ""// 贷款产品类型
    var protocols : [ProtocolModel] = [ProtocolModel]()// 协议列表
    var loanChannelId : String = ""//
    var tips : String = ""// 账单列表的提示文案
    var loanTerms : String = ""// 申请期限
    var hasComment : String = ""// "0"显示评价
    var loanApplyId : String = ""//
    var statusDesc : String = ""// 状态文案
    var orderTime : String = ""// 订单时间
    var loanChannelName : String = ""// 机构名称
    var loanChannelTel : String = ""// 机构电话
    var planList : NSArray = []// 出帐列表
    var capitalDrawUrl : String = ""// 存管账户提款url
    var memberCard : String = ""// 会员服务
    var needRepayAmount : String = ""// 应还金额
    var needRepayTime : String = ""// 距离还款日期
    
    override func replacedKeyFromPropertyName() -> NSDictionary {
        return ["protocols":"protocol"]
    }
    
    static func customClassMapping() -> [String : String]? {
        return["protocols":"ProtocolModel","planList":"PlanModel"]
    }
}
