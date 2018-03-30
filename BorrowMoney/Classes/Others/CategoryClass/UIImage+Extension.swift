//
//  UIImage+Extension.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/13.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import Foundation

public enum DirectionEnum : Int {
    case leftToRight
    case topToBottom
}

extension UIImage {
    
    // 根据颜色值创建图片
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
    
    
    // 获取渐变的图片
    func imageGradientPicture(gradientColors:[UIColor],size:CGSize,direction:DirectionEnum) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        let context = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = gradientColors.map {(color: UIColor) -> AnyObject! in return color.cgColor as AnyObject! } as NSArray
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil)
        // 第二个参数是起始位置，第三个参数是终止位置
        if direction == DirectionEnum.leftToRight {
            context!.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: size.width, y: 0), options: CGGradientDrawingOptions(rawValue: 0))
        } else {
            context!.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: size.height), options: CGGradientDrawingOptions(rawValue: 0))
        }
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            XPrint("创建图片失败")
            return UIImage()
        }

        UIGraphicsEndImageContext()
        return image
    }
}
