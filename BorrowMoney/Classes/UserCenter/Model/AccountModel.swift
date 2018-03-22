//
//  AccounManageModel.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/21.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class AccountModel: NSObject {
    var accountStatus = "";//
    var apiUpdateTime = "";//
    var errorCode = "";//
    var accountId = "";//
    var loanChannelId = "";//
    var loanChannelName = "";//
    var loanUserName = "";//
    var planId = "";//
    var productLogo = "";//
    var recordId = "";//
    var status = "";//

    override func replacedKeyFromPropertyName() -> NSDictionary {
        return ["accountId":"id"]
    }
}
