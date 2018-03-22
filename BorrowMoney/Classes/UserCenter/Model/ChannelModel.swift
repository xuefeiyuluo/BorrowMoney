//
//  ChannelModel.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/22.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class ChannelModel: NSObject {
    var channelId = "";//
    var name = "";//
    var nameTip = "";// 机构登录名的提示信息
    var pwdTip = "";// 机构登录密码的提示信息
    var status = "";//
    
    override func replacedKeyFromPropertyName() -> NSDictionary {
        return ["channelId":"id"]
    }
}
