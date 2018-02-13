//
//  NSObject+Extension.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/11.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import Foundation
extension UserDefaults {
    
    func saveCustomObject(customObject object : NSCoding, key : String) -> Void {
        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: object)
        self.set(encodedObject, forKey: key)
        self.synchronize()
    }
    
    
    func getCustomObject(key : String) -> AnyObject? {
        let decodedObject = self.object(forKey: key) as? NSData
        
        if let decoded = decodedObject {
            let object = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data)
            return object as AnyObject
        }
        return nil
    }
    

    // 清除所有的存储本地的数据
    func clearUserDefaultsData() -> Void {
        self.removeObject(forKey: "userInfo")
    }
}
