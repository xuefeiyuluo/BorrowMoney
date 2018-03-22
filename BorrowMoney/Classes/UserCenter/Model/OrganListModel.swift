//
//  OrganModel.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/21.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit


class OrganModel: NSObject {
    var logo = "";// 机构的图标
    var channelId = "";// 机构的id
    var name = "";// 机构的名称
    var entryType = ""// 进入该界面的不同入口 "1"个人中心添加贷款机构列表界面 "3"还款管理界面
    var account = ""// 用户账号
    
    
}


class OrganListModel: NSObject {
    var firstLetter = "";// 机构的手字母
    var orderList : [OrganModel] = [OrganModel]()// 机构列表
    
    static func customClassMapping() -> [String : String]? {
        return["orderList":"OrganModel"]
    }
}




