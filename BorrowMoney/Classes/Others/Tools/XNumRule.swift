//
//  HEFoundation.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/20.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import Foundation
import AVFoundation
import Photos

class XNumRule: NSObject {
    
    // 手机号码验证
    func phoneRule(phoneNum : String) -> Bool {
        if phoneNum.count == 11 {
            let index = phoneNum.index(phoneNum.startIndex, offsetBy: 1)
            let prefix : String = phoneNum.substring(to: index)
            if prefix == "1" {
                return true
            }
            return false
        } else {
            return false
        }
    }
    
    
    // 身份证号码验证
    func cardRule(cardNum : String) -> Bool {
        //判断位数
        if cardNum.count != 15 && cardNum.count != 18 {
            return false
        }
        
        var carid = cardNum
        var lSumQT = 0
        
        //加权因子
        let R = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]
        
        //校验码
        let sChecker: [Int8] = [49,48,88, 57, 56, 55, 54, 53, 52, 51, 50]
        
        //将15位身份证号转换成18位
        let mString = NSMutableString.init(string: carid)

        if carid.count == 15 {
            mString.insert("19", at: 6)
            var p = 0
            let pid = mString.utf8String
            for i in 0...16 {
                p += (pid![i] - 48) * R[i]
            }
            let o = p % 11
            let stringContent = NSString(format: "%c", sChecker[o])
            mString.insert(stringContent as String, at: mString.length)
            carid = mString as String
        }

        //判断地区码
        let sProvince : String = carid.substringInRange(0...1) as String
        if (!areaCodeAt(code: sProvince)) {
            return false
        }

        //判断年月日是否有效
        //年份
        let strYear = Int(carid.substringInRange(6...9))
        
        //月份
        let strMonth = Int(carid.substringInRange(10...11))
        //日
        let strDay = Int(carid.substringInRange(12...13))

        let localZone = NSTimeZone.local

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = localZone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: "\(String(format: "%02d",strYear!))-\(String(format: "%02d",strMonth!))-\(String(format: "%02d",strDay!)) 12:01:01")

        if date == nil {
            return false
        }

        let paperId = carid.utf8CString
        //检验长度
        if 18 != carid.count {
            return false
        }
        //校验数字
        func isDigit(c: Int8) -> Bool {
            return 0 <= c && c <= 9
        }
        for i in 0...18 {
            if isDigit(c: paperId[i]) && !(88 == paperId[i] || 120 == paperId[i]) && 17 == i {
                return false
            }
        }

        //验证最末的校验码
        for i in 0...16 {
            lSumQT += (paperId[i] - 48) * R[i]
        }
        if sChecker[lSumQT%11] != paperId[17] {
            return false
        }
        return true
    }
    
    
    func areaCodeAt(code: String) -> Bool {
        var dic: [String: String] = [:]
        dic["11"] = "北京"
        dic["12"] = "天津"
        dic["13"] = "河北"
        dic["14"] = "山西"
        dic["15"] = "内蒙古"
        dic["21"] = "辽宁"
        dic["22"] = "吉林"
        dic["23"] = "黑龙江"
        dic["31"] = "上海"
        dic["32"] = "江苏"
        dic["33"] = "浙江"
        dic["34"] = "安徽"
        dic["35"] = "福建"
        dic["36"] = "江西"
        dic["37"] = "山东"
        dic["41"] = "河南"
        dic["42"] = "湖北"
        dic["43"] = "湖南"
        dic["44"] = "广东"
        dic["45"] = "广西"
        dic["46"] = "海南"
        dic["50"] = "重庆"
        dic["51"] = "四川"
        dic["52"] = "贵州"
        dic["53"] = "云南"
        dic["54"] = "西藏"
        dic["61"] = "陕西"
        dic["62"] = "甘肃"
        dic["63"] = "青海"
        dic["64"] = "宁夏"
        dic["65"] = "新疆"
        dic["71"] = "台湾"
        dic["81"] = "香港"
        dic["82"] = "澳门"
        dic["91"] = "国外"
        if (dic[code] == nil) {
            return false;
        }
        return true;
    }
}
