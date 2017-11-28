//
//  BorrowMoney.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/10/11.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit
import SnapKit

// ******************************* 屏幕尺寸 ***************************************
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let WIDTH_SCALE = getScreenHightscale()
let HEIGHT_SCALE = getScreenWidthscale()


// ********************************* 颜色 *****************************************
let MAIN_COLOR = UIColor().colorWithHexString(hex: "F2F2F2")
let NAVIGATION_COLOR = UIColor().colorWithHexString(hex: "16c2ac")
let TEXT_BLACK_COLOR = UIColor().colorWithHexString(hex: "585858")
let TEXT_LIGHT_COLOR = UIColor().colorWithHexString(hex: "888888")
let LINE_COLOR1 = UIColor().colorWithHexString(hex: "D8D8D8")
let LINE_COLOR2 = UIColor().colorWithHexString(hex: "D9D9D9")
let LINE_COLOR3 = UIColor().colorWithHexString(hex: "999999")


// ******************************** 当前版本 ***************************************
let CURRENTVERSION = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String


// ********************************* URL ******************************************
let SERVERURL = ""


// ***************************** UserDefaults *************************************
let USERDEFAULT : UserDefaults = UserDefaults .standard


/**
 *  获取屏幕高比例
 *
 *  @return 屏幕高比例
 */
func getScreenHightscale() -> CGFloat {
    let standard : CGFloat = 667.0
    switch (SCREEN_WIDTH,SCREEN_HEIGHT) {
    case (320, 480),(480, 320):
        return 480 / standard
    case (320, 568),(568, 320):
        return 568 / standard
    case (375, 667),(667, 375):
        return 667 / standard
    case (414, 736),(736, 414):
        return 736 / standard
    case (375, 812),(812, 375):
        return 812 / standard
    default:
        return 667 / standard
    }
}


/**
 *  获取屏幕宽比例
 *
 *  @return 屏幕高比例
 */
func getScreenWidthscale() -> CGFloat {
    let standard : CGFloat = 375.0
    switch (SCREEN_WIDTH,SCREEN_HEIGHT) {
    case (320, 480),(480, 320):
        return 320 / standard
    case (320, 568),(568, 320):
        return 320 / standard
    case (375, 667),(667, 375),(375, 812),(812, 375):
        return 375 / standard
    case (414, 736),(736, 414):
        return 414 / standard
    default:
        return 375 / standard
    }
}
















