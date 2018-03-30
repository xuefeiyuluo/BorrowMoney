//
//  PersonHeaderView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/26.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class PersonHeaderView: BasicView {
    let backBtn : UIButton = UIButton()// 返回按钮
    var gifView : UIView = UIView()
    var promptLabel : UILabel = UILabel()// 提示信息
    var amountLabel : UILabel = UILabel()// 金额信息
    var imageCount : Int = 0// gif图片一共多少帧
    var currentIndex : Int = 0// 当前的帧数
    var animationTimer: Timer?// 动画定时器
    var gifSource : CGImageSource?// gif资源
    var average : CGFloat = 0.0// 图片每一帧的数值
    
    // 创建UI
    override func createUI() {
        super.createUI()

        let backImage : UIImageView = UIImageView()
        backImage.image = UIImage (named: "PersonHeaderBg.png")
        backImage.isUserInteractionEnabled = true
        self.addSubview(backImage)
        backImage.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self)
        }
        
    
        // 标题view
        let titleView : UIView = UIView()
        self.addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.right.equalTo(self)
            make.height.equalTo(44)
        }
        
        
        let titleLabel : UILabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 18 * WIDTH_SCALE)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "我的预估额度"
        titleLabel.textAlignment = NSTextAlignment.center
        titleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(titleView)
        }
        
        // 返回按钮
        self.backBtn.setImage(UIImage (named: "nav_btn_back"), for: .normal)
        self.backBtn.setImage(UIImage (named: "nav_btn_back"), for: .highlighted)
        self.backBtn.setTitle("返回", for: .normal)
        self.backBtn.titleLabel?.font = UIFont .systemFont(ofSize: 14 * WIDTH_SCALE)
        self.backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        titleView.addSubview(self.backBtn)
        self.backBtn.snp.makeConstraints { (make) in
            make.top.bottom.left.equalTo(titleView)
            make.width.equalTo(60 * WIDTH_SCALE)
        }
        
        
        let amountView : UIView = UIView()
        self.addSubview(amountView)
        amountView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(titleView.snp.bottom)
            make.height.equalTo(120)
        }
        
        
        amountView.addSubview(self.gifView)
        self.gifView.snp.makeConstraints { (make) in
            make.centerX.top.bottom.equalTo(amountView)
            make.width.equalTo(238)
        }
        let gifurl : NSURL = Bundle.main.url(forResource: "personInfo", withExtension: "gif") as NSURL!
        let url:CFURL = gifurl as CFURL!
        // 获取gif资源
        self.gifSource = CGImageSourceCreateWithURL(url, nil)
        self.imageCount = CGImageSourceGetCount(gifSource!)
        let imageRef = CGImageSourceCreateImageAtIndex(gifSource!, self.currentIndex, nil)
        self.gifView.layer.contents = imageRef
        
        
        // 金额
        self.amountLabel.font = UIFont.systemFont(ofSize: 35 * WIDTH_SCALE)
        self.amountLabel.textColor = UIColor.white
        self.amountLabel.text = "3425432"
        amountView.addSubview(self.amountLabel)
        self.amountLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(amountView.snp.centerX).offset(-6 * WIDTH_SCALE)
            make.bottom.equalTo(amountView.snp.bottom)
        }
        
        
        let unitLabel : UILabel = UILabel()
        unitLabel.text = "元"
        unitLabel.textColor = UIColor.white
        unitLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        amountView.addSubview(unitLabel)
        unitLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(amountView.snp.bottom).offset(-6 * WIDTH_SCALE)
            make.left.equalTo(self.amountLabel.snp.right)
        }
        
        self.promptLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.promptLabel.textColor = UIColor.white
        self.promptLabel.textAlignment = .center
        self.promptLabel.text = "VB发送VB发送案件的卡夫卡到家啊绢豆腐"
        self.addSubview(self.promptLabel)
        self.promptLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.left.equalTo(self.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.snp.right).offset(-10 * WIDTH_SCALE)
            make.top.equalTo(amountView.snp.bottom).offset(10 * WIDTH_SCALE)
        }
        
        showAnimation()
    }
    
    
    // 显示GIF动画
    func showAnimation()
    {
        self.animationTimer = Timer.scheduledTimer(timeInterval: 0.025, target: self, selector: #selector(updateImage), userInfo: nil, repeats: true)
    }
    
    
    // 更新图片
    func updateImage() -> Void {
        self.currentIndex += 1
        self.amountLabel.text = NSString (format: "%.0f", CGFloat(self.currentIndex) * 2143.9) as String
        if self.currentIndex % self.imageCount == 0 {
//            self.amountLabel.text =
            self.animationTimer?.invalidate()
            self.animationTimer = nil
        } else {
            let imageRef = CGImageSourceCreateImageAtIndex(self.gifSource!, self.currentIndex, nil)
            self.gifView.layer.contents = imageRef
        }
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        self.animationTimer?.invalidate()
        self.animationTimer = nil
        self.gifSource = nil
    }
}
