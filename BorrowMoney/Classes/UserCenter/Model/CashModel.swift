//
//  CashModel.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/2/27.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class CashModel: NSObject {
    var auditAmount : NSString?// 可以提现最低金额
    var balance : NSString?// 金额
    var canWithdraw : NSString?//
    var cardInfo : NSString = ""// 银行卡号
    var hasCard : NSString?// 是否有银行卡 "1"有卡
    var status : NSString?//
    var totalWithdrawAmount : NSString?//
}
