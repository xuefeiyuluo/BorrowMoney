//
//  ObtainLocationInfo.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/2.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit
import CoreLocation

// 获取定位信息
typealias LocationBlock = (Bool,String) -> Void
class ObtainLocationInfo: NSObject, CLLocationManagerDelegate {
    static let locationManager = CLLocationManager()
    var locationBlock : LocationBlock?// 定位的回调
    
    override init() {
        super.init()
        
        ObtainLocationInfo.locationManager.delegate = self
        ObtainLocationInfo.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        ObtainLocationInfo.locationManager.distanceFilter = 500
        // 弹出用户授权对话框，使用程序期间授权
        ObtainLocationInfo.locationManager.requestWhenInUseAuthorization()
    }
    
    
    // 开始定位
    func startLocation() -> Void {
        // 判断定位的权限是否已开启
        if CLLocationManager.authorizationStatus() == .denied {
            if self.locationBlock != nil {
                self.locationBlock!(false,"定位服务未开启,请进入系统设置>隐私>定位服务中打开开关")
            }
            return
        }
        
        // 开启定位
        ObtainLocationInfo.locationManager.startUpdatingLocation()
    }
    
    // MARK: CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        weak var weakSelf = self
        let geoCoder:CLGeocoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(locations.last!) { (placemarks, error) in
            if placemarks == nil {
                if weakSelf?.locationBlock != nil {
                    weakSelf?.locationBlock!(false,"啊哦，定位失败：( 请重新选择")
                }
                return
            }
            
            let placeMark : CLPlacemark = placemarks![0];
            let cityName : String = placeMark.locality!
            weakSelf?.requestCityInfo(city: cityName)
            if weakSelf?.locationBlock != nil {
                weakSelf?.locationBlock!(true,cityName)
            }
        }
        
        // 停止定位
        ObtainLocationInfo.locationManager.stopUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if self.locationBlock != nil {
            self.locationBlock!(false,"啊哦，定位失败：( 请重新选择")
        }
    }
    
    
    // 获取定位城市信息
    func requestCityInfo(city:String) -> Void {
        PublicService.publicServiceInstance.requestLocationCityInfo(city: "上海市", success: { (responseObject) in
            
        }) { (errorInfo) in
        }
    }
}
