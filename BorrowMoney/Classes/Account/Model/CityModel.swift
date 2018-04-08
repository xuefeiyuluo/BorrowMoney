//
//  CityMOdel.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/2.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit


class CityModel: NSObject {
    
    var cityId = "";// 城市Id
    var en = "";// 拼音
    var letter = "";// 安字母分组
    var zone_id = "";//
    var zone_name = "";// 城市名称
}


class AllCityModel: NSObject {
    var letter = "";// 安字母分组
    var cityList : [CityModel] = [CityModel]();// 安字母分组后的城市列表
    
    static func customClassMapping() -> [String : String]? {
        return["cityList":"CityModel"]
    }
    
}
