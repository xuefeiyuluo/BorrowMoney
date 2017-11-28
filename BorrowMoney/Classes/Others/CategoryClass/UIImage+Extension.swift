//
//  UIImage+Extension.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/13.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import Foundation
extension UIImage {
    
    func imageCustom(color: UIColor,size : CGSize) -> UIImage? {
        return imageCustomOpaque(color: color, size: size, opaque: false)
    }
    
    
    func imageCustomOpaque(color: UIColor,size : CGSize,opaque : Bool) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, opaque, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? nil
    }
}
