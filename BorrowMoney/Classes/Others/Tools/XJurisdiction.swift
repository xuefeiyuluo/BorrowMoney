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

class XJurisdiction: NSObject {
    
    // 相机权限
    func iPhoneCamera() -> Bool{
        let authStatus:AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        if(authStatus == AVAuthorizationStatus.denied || authStatus == AVAuthorizationStatus.restricted) {
            return false
        }else {
            return true
        }
    }
    
    
    // 相册权限
    func iPhonePhoto() -> Bool {
        let library : PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        if(library == PHAuthorizationStatus.denied || library == PHAuthorizationStatus.restricted){
            return false
        }else {
            return true
        }
    }
}
