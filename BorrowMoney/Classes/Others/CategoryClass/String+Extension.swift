//
//  UIColor+Extension.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/10/13.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import Foundation
extension String {
    // MD5加密
    var md5 : String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        
        return String(format: hash .lowercased as String)
    }
    
    
    // string -> Int
    func intValue() -> Int {
        var intNumber : Int = 0
        if  self.isEmpty {
            intNumber = 0
        } else {
            let intArray : [String] = self.components(separatedBy: ".") as [String]
            intNumber = Int(intArray.first!)!
        }
        return intNumber
    }
    
    
    // string -> CGFloat
    func floatValue() -> Double {
        var floatNumber : Double = 0.00
        if self.isEmpty {
            floatNumber = 0.00
        } else {
            floatNumber = Double(self)!
        }
        return floatNumber
    }
    
    
    // string -> BOOL
    func boolValue() -> Bool {
        if self.isEmpty {
            return false
        } else {
            if self == "1" {
                return true
            } else {
                return false
            }
        }
    }
    
    
    
    
    // url编码
    func stringToUrlEncoded() -> String {
        let encodeWord = self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet(charactersIn:"`#%^{}\"[]|\\<> ").inverted)
        return encodeWord!
    }
    
    
    // Utf8编码 string -> utf8
    func stringToUTF8Encoded() -> Data {
        let data : Data = self.data(using: String.Encoding.utf8)!
        return data
    }
    
    
    // 某个闭区间内的字符
    func substringInRange(_ range: CountableClosedRange<Int>) -> String {
        
        guard range.lowerBound >= 0 else {
            assertionFailure("lowerBound of the Range can't be lower than 0")
            return ""
        }
        
        guard range.upperBound < self.count else {
            assertionFailure("upperBound of the Range beyound the length of the string")
            return ""
        }
        let start = self.index(self.startIndex, offsetBy: range.lowerBound)
        let end = self.index(self.startIndex, offsetBy: range.upperBound + 1)
        let strRange = Range.init(uncheckedBounds: (lower: start, upper: end))
        
        return self.substring(with: strRange)
    }
}
