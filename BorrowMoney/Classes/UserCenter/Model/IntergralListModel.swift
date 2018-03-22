//
//  IntergralListModel.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/22.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class IntergralListModel: NSObject {
    var balanceValue = "";//
    var createTime = "";// 时间
    var goldValue = "";// 积分数
    var IntergralId = "";//
    var operatorType = "";// 积分类型
    var recordType = "";//
    var title = "";//
    var userId = "";//
    
    override func replacedKeyFromPropertyName() -> NSDictionary {
        return ["IntergralId":"id"]
    }
}
