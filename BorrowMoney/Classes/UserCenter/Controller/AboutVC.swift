//
//  AboutVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/21.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class AboutVC: BasicVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
    }
    
    
    // 创建UI
    func createUI() -> Void {

        let infoDict : NSDictionary = Bundle.main.infoDictionary! as NSDictionary
        let imageName = (infoDict.value(forKeyPath: "CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles") as! NSArray) .lastObject as! String
        
        let iconImageView : UIImageView = UIImageView()
        iconImageView.image = UIImage (named: imageName)
        iconImageView.contentMode = .center
        self.view.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.top.right.left.equalTo(self.view)
            make.height.equalTo(90 * HEIGHT_SCALE)
        }
        
        
        let versionLabel : UILabel = UILabel()
        versionLabel.textColor = TEXT_LIGHT_COLOR
        versionLabel.textAlignment = NSTextAlignment.center
        versionLabel.font = UIFont .systemFont(ofSize: 12 * HEIGHT_SCALE)
        versionLabel.text = String (format: "当前版本%@", Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! CVarArg)
        self.view .addSubview(versionLabel)
        versionLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(iconImageView.snp.bottom).offset(5 * HEIGHT_SCALE)
        }
    
        
        let contentLabel : UILabel = UILabel()
        contentLabel.textColor = TEXT_LIGHT_COLOR
        contentLabel.textAlignment = NSTextAlignment.center
        contentLabel.numberOfLines = 0
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = 4 * HEIGHT_SCALE
        let attributes = [NSParagraphStyleAttributeName: paraph]
        contentLabel.font = UIFont .systemFont(ofSize: 12 * HEIGHT_SCALE)
        contentLabel.text = String (format: "    【%@App】是上海融之家推出的国内领先的个人及小微企业贷款智能搜索平台，平台依托庞大的征信数据资源、先进的数据挖掘技术和智能搜索技术，致力于为广大借款人提供高效、便捷、安全的贷款服务，轻松实现借款需求！",infoDict.object(forKey: "CFBundleDisplayName") as! CVarArg)
        contentLabel.attributedText = NSAttributedString (string:contentLabel.text!, attributes: attributes)
        self.view .addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(15 * WIDTH_SCALE)
            make.right.equalTo(self.view.snp.right).offset(-15 * WIDTH_SCALE)
            make.top.equalTo(versionLabel.snp.bottom).offset(10 * HEIGHT_SCALE)
        }
        
        
        let label1 : UILabel = UILabel()
        label1.textColor = TEXT_LIGHT_COLOR
        label1.textAlignment = NSTextAlignment.center
        label1.font = UIFont .systemFont(ofSize: 12 * HEIGHT_SCALE)
        label1.text = "融之家版权所有"
        self.view .addSubview(label1)
        label1.snp.makeConstraints { (make) in
            make.right.equalTo(self.view.snp.right).offset(-15 * WIDTH_SCALE)
            make.top.equalTo(contentLabel.snp.bottom).offset(10 * HEIGHT_SCALE)
        }
        
        
        let label2 : UILabel = UILabel()
        label2.textColor = TEXT_LIGHT_COLOR
        label2.textAlignment = NSTextAlignment.center
        label2.font = UIFont .systemFont(ofSize: 12 * HEIGHT_SCALE)
        label2.text = "Copyright © 2015 www.rongzhijia.com . All Rights Reserved"
        self.view .addSubview(label2)
        label2.snp.makeConstraints { (make) in
            make.right.left.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.bottom).offset(-10 * HEIGHT_SCALE)
        }
        
        let label3 : UILabel = UILabel()
        label3.textColor = TEXT_LIGHT_COLOR
        label3.textAlignment = NSTextAlignment.center
        label3.font = UIFont .systemFont(ofSize: 12 * HEIGHT_SCALE)
        label3.text = "融之家"
        self.view .addSubview(label3)
        label3.snp.makeConstraints { (make) in
            make.right.left.equalTo(self.view)
            make.bottom.equalTo(label2.snp.top).offset(-3 * HEIGHT_SCALE)
        }
    }
    
    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "关于");
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
