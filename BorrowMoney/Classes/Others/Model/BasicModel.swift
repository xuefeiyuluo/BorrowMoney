//
//  BasicModel.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/7.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class BasicModel: NSObject, NSCoding {
    var lightningLoanUrl : String?// 首页闪电放款URL
    var uuid : String?// 请求的uuid
    
    
    override init() {
        super.init()
    }
    
    required init(coder decoder: NSCoder) {
        super.init()
        
        lightningLoanUrl = decoder.decodeObject(forKey: "lightningLoanUrl") as? String
        uuid = decoder.decodeObject(forKey: "uuid") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(lightningLoanUrl, forKey: "lightningLoanUrl")
        aCoder.encode(uuid, forKey: "uuid")
    }
}
