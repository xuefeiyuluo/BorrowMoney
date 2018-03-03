//
//  DiscountModel.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/2.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class DiscountModel: NSObject {
    var content : String = ""// 免息卷机构
    var endTime : String = ""// 有效期时间
    var loanChannelId : String = ""//
    var loanChannelLogo : String = ""//
    var loanChannelName : String = ""//
    var name : String = ""// 免息卷名称
    var packetAmount : String = ""// 金额
    var redPacketId : String = ""//
    var startTime : String = ""//
    var status : String = ""//
    var statusCode : String = ""//"0"未打开  “1”已打开  “2”已过期
    var url : String = ""// logo
    var userRedPacketId : String = ""//
}
