//
//  ApplicantModel.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/18.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit


class ApplyRegulaModel: NSObject {
    var categoryId1 : String = ""//
    var verifyAttribute : String = ""//
    var fillAttribute : String = ""//
    var attibute_type : String = ""//
    var selectValue : String = ""//
    var attribute_id : String = ""//
    var selectValueId : String = ""//
    var attribute_name : String = ""//
    var valueName : String = ""//
    var isBankCard : String = ""//
    var authorize : String = ""//
    var address : String = ""//
    var authorizeMsg = ""//
    var allChoice : [NSDictionary] = [NSDictionary]()// 条目名称
}


class ApplicantModel: NSObject, ArrayToModelProtocol {
    var verifyAttribute : String = ""//
    var catName : String = ""// section文案
    var catLogo : String = ""// sectionURL
    var attrList : [ApplyRegulaModel] = [ApplyRegulaModel]()//
    var breif : String = ""//
    var attributeId : String {
        set{}
        get{
            if self.attrList.count > 0 {
                for applyModel : ApplyRegulaModel in self.attrList {
                    if applyModel.attribute_id == "10000" {
                        return applyModel.attribute_id
                    } else {
                        return ""
                    }
                }
            }
            return ""
        }
    }
    var applicantState : Bool = false// 申请资料是否展开状态
    var applicantGroup : Int = 0// 点击了第几组
    
    static func customClassMapping() -> [String : String]? {
        return["attrList":"ApplyRegulaModel"]
    }
}
