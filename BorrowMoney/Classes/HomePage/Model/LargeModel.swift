//
//  LargeModel.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/4.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit


class LoanOfficeModel: NSObject {
    var providerId : String? = ""// 信贷经理ID
    var headImageUrl : String? = ""// 信贷经理头像
    var channelName : String? = ""// 信贷经理所在的公司
    var providerName : String? = ""// 信贷经理的名称
}



class LoanTypeModel: NSObject {
    var providerList : [LoanOfficeModel] = [LoanOfficeModel]()// 该类型信贷经理的数组
    var spreadTypeName : String? = ""// 贷款名称
    var spreadType : String? = ""// 贷款名称Id
    var providerCount : String? = ""// 该类型信贷经理的数量
    var providerNum : Int  = 0// 当前是第几个
    var channelName : String{ // 信贷经理所在的公司
        set {
        }
        get {
            if self.providerList.count > 0 {
                return (self.providerList[self.providerNum] as LoanOfficeModel).channelName!
            }
            return ""
        }
    }
    var providerName : String {// 信贷经理的名称
        set {
        }
        get {
            if self.providerList.count > 0 {
                return (self.providerList[self.providerNum] as LoanOfficeModel).providerName!
            }
            return ""
        }
    }
    var providerUrl : String {// 信贷经理的url
        set {
        }
        get {
            if self.providerList.count > 0 {
                return (self.providerList[self.providerNum] as LoanOfficeModel).headImageUrl!
            }
            return ""
        }
    }
    var providerId : String {// 信贷经理的id
        set {
        }
        get {
            if self.providerList.count > 0 {
                return (self.providerList[self.providerNum] as LoanOfficeModel).providerId!
            }
            return ""
        }
    }
    
    
    static func customClassMapping() -> [String : String]? {
        return["providerList":"LoanOfficeModel"]
    }
}


class LargeModel: NSObject {
    var cityName : String? = ""// 城市名称
    var totalCount : String? = ""// 一共有多少位信贷经理
    var serviceTypeList : [LoanTypeModel] = [LoanTypeModel]()// 贷款类型列表
    var thirdPhoneNumber : String? = ""// 第三方电话号码
    
    static func customClassMapping() -> [String : String]? {
        return["serviceTypeList":"LoanTypeModel"]
    }
}


// 头部信息model
class LargeInfoModel: NSObject {
    var cityName : String? = ""// 城市名称
    var amountText : String? = "50000"// 申请金额
    var termText : String? = "12"// 申请期限
    var nameText : String? = ""// 姓名
    var cardText : String? = ""// 身份证
    var loanNumText : String? = ""// 当前信贷经理数量
    var verify : String = ""// 是否通过审核 1已审核
    var url : String = ""// 头像
    var providerId : String? = ""// 信贷经理的id
    var spreadTypeName : String? = ""// 贷款名称
    var spreadType : String? = ""// 贷款名称Id
    var providerName : String? = ""// 信贷经理的名称
    var recordId : String? = ""// 电话拨打的ID
}
