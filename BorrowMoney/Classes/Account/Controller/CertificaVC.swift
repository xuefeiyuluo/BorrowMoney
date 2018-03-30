//
//  CertificaVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/29.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class CertificaVC: BasicVC {
    var certificaBaseView : CertificaBaseView = CertificaBaseView()// 基本信息
    var certificaFamilyView : CertificaFamilyView = CertificaFamilyView()// 家庭信息
    var certificaContactsView : CertificaContactsView = CertificaContactsView()// 联系人信息
    var certificaOperatorView : CertificaOperatorView = CertificaOperatorView()// 运营商授权
    var certificaCardView : CertificaCardView = CertificaCardView()// 身份证
    var certificaBankView : CertificaBankView = CertificaBankView()// 银行卡
    var certificaOccupaView : CertificaOccupaView = CertificaOccupaView()// 职业信息
    var certificaCreditView : CertificaCreditView = CertificaCreditView()// 网购信用
    var certificaSSAFView : CertificaSSAFView = CertificaSSAFView()// 社保与公积金
    var footerView : UIButton = UIButton()// 底部按钮
    var certificaType : Int = 0// 认证的类型
    var titleTextArray : [String] = [String]()// 认证数组
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建界面
        createUI()
    }

    
    // 创建界面
    func createUI() -> Void {
        // 基本信息
        self.view.addSubview(self.certificaBaseView)
        self.certificaBaseView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(-50 * HEIGHT_SCALE)
        }
        
        
        // 家庭信息
        self.view.addSubview(self.certificaFamilyView)
        self.certificaFamilyView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(-50 * HEIGHT_SCALE)
        }
        
        // 联系人信息
        self.view.addSubview(self.certificaContactsView)
        self.certificaContactsView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(-50 * HEIGHT_SCALE)
        }
        
        // 运营商授权
        self.view.addSubview(self.certificaOperatorView)
        self.certificaOperatorView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(-50 * HEIGHT_SCALE)
        }
        
        // 身份证
        self.view.addSubview(self.certificaCardView)
        self.certificaCardView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(-50 * HEIGHT_SCALE)
        }
        
        // 银行卡
        self.view.addSubview(self.certificaBankView)
        self.certificaBankView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(-50 * HEIGHT_SCALE)
        }
        
        // 职业信息
        self.view.addSubview(self.certificaOccupaView)
        self.certificaOccupaView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(-50 * HEIGHT_SCALE)
        }
        
        // 网购信用
        self.view.addSubview(self.certificaCreditView)
        self.certificaCreditView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(-50 * HEIGHT_SCALE)
        }
        
        // 社保与公积金
        self.view.addSubview(self.certificaSSAFView)
        self.certificaSSAFView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(-50 * HEIGHT_SCALE)
        }
        
        // 显示当前的View
        showCurrentView()
        
        // 按钮
        if self.certificaType == 8 {
            self.footerView.setTitle("完成", for: UIControlState.normal)
        } else {
            self.footerView.setTitle("下一步", for: UIControlState.normal)
        }
        self.footerView.titleLabel?.font = UIFont.systemFont(ofSize: 17 * WIDTH_SCALE)
        self.footerView.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.footerView.backgroundColor = NAVIGATION_COLOR
        self.footerView.addTarget(self, action: #selector(nextClick), for: UIControlEvents.touchUpInside)
        self.view.addSubview(self.footerView)
        self.footerView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(50 * HEIGHT_SCALE)
        }
    }
    
    
    // 显示当前的View
    func showCurrentView() -> Void {
        self.certificaBaseView.isHidden = true
        self.certificaFamilyView.isHidden = true
        self.certificaContactsView.isHidden = true
        self.certificaOperatorView.isHidden = true
        self.certificaCardView.isHidden = true
        self.certificaBankView.isHidden = true
        self.certificaOccupaView.isHidden = true
        self.certificaCreditView.isHidden = true
        self.certificaSSAFView.isHidden = true
        
        if self.certificaType == 0 {
            self.certificaBaseView.isHidden = false
        } else if self.certificaType == 1 {
            self.certificaFamilyView.isHidden = false
        } else if self.certificaType == 2 {
            self.certificaContactsView.isHidden = false
        } else if self.certificaType == 3 {
            self.certificaOperatorView.isHidden = false
        } else if self.certificaType == 4 {
            self.certificaCardView.isHidden = false
        } else if self.certificaType == 5 {
            self.certificaBankView.isHidden = false
        } else if self.certificaType == 6 {
            self.certificaOccupaView.isHidden = false
        } else if self.certificaType == 7 {
            self.certificaCreditView.isHidden = false
        } else if self.certificaType == 8 {
            self.certificaSSAFView.isHidden = false
        }
    }
    
    
    
    
    // 底部按钮的点击事件
    func nextClick() -> Void {
        if self.certificaType == 8 {
            self.navigationController?.popViewController(animated: false)
        } else {
            self.certificaType += 1
            // 显示下一个认证界面
            showCurrentView()
            // 改变标题
            setUpNavigationView()
        }
    }
    
    
    override func initializationData() {
        super.initializationData()
        
        self.titleTextArray = ["基本资料","家庭信息","联系人信息","运营商授权","身份认证","银行卡认证","职业信息","网购信用","社保和公积金"]
    }
    
    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: self.titleTextArray[self.certificaType]);
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
