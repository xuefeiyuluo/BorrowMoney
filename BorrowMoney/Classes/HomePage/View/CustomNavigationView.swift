//
//  CustomNavigationView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/30.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

typealias HomeNavigationBlock = (Int) -> Void
class CustomNavigationView: UIView {
    var messageBtn : UIButton?// 消息icon
    var promptLabel : UILabel?//
    var navigationBlock : HomeNavigationBlock?// 头部按钮的点击事件
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = NAVIGATION_COLOR
        
        // 创建界面
        createUI()
    }
    
    
    // 创建界面
    func createUI() -> Void {
        // 消息图标
        let messageBtn : UIButton = UIButton (type: UIButtonType.custom)
        messageBtn.setImage(UIImage (named: "message.png"), for: UIControlState.normal)
        messageBtn .addTarget(self, action: #selector(tapClick(sender:)), for: UIControlEvents.touchUpInside)
        messageBtn.tag = 100
        self.messageBtn = messageBtn
        self.addSubview(messageBtn)
        messageBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-10 * WIDTH_SCALE)
            make.top.equalTo(self.snp.top).offset(20)
            make.height.equalTo(40)
            make.width.equalTo(30 * WIDTH_SCALE)
        }
        

        // 搜索框
        let searchBtn : UIButton = UIButton (type: UIButtonType.custom)
        searchBtn.backgroundColor = MAIN_COLOR
        searchBtn .addTarget(self, action: #selector(tapClick), for: UIControlEvents.touchUpInside)
        searchBtn.setTitle("搜索产品/关键字", for: UIControlState.normal)
        searchBtn.titleLabel?.font = UIFont .systemFont(ofSize: 12)
        searchBtn.layer.cornerRadius = 14
        searchBtn.tag = 200
        searchBtn.layer.masksToBounds = true
        searchBtn.setTitleColor(TEXT_LIGHT_COLOR, for: UIControlState.normal)
        searchBtn.imageEdgeInsets = UIEdgeInsetsMake(3, 0, 3, 5 * WIDTH_SCALE)
        searchBtn.setImage(UIImage (named: "searchIcon.png"), for: UIControlState.normal)
        self .addSubview(searchBtn)
        searchBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(10 * WIDTH_SCALE)
            make.top.equalTo(self.snp.top).offset(25)
            make.right.equalTo((self.messageBtn?.snp.left)!).offset(-5 * WIDTH_SCALE)
            make.height.equalTo(30)
        }
        
        let radioImage : UIImageView = UIImageView()
        radioImage.image = UIImage (named: "notice.png")
        radioImage.contentMode = .center
        self.addSubview(radioImage)
        radioImage.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(6 * WIDTH_SCALE)
            make.bottom.equalTo(self.snp.bottom).offset(-2 * WIDTH_SCALE)
            make.width.height.equalTo(30 * HEIGHT_SCALE)
        }
        
        let promptLabel : UILabel = UILabel()
        promptLabel.text = "的双顶径时刻贷款恶女阿萨单纯的发大多数的超大大的撒从第三大厦从的v反倒是传达多撒吃撒放点水爱啦啦"
        promptLabel.textColor = UIColor.white
        promptLabel.font = UIFont .systemFont(ofSize: 13 * WIDTH_SCALE)
        self.promptLabel = promptLabel
        self.addSubview(promptLabel)
        promptLabel.snp.makeConstraints { (make) in
            make.left.equalTo(radioImage.snp.right)
            make.bottom.equalTo(self.snp.bottom).offset(-2 * WIDTH_SCALE)
            make.right.equalTo((self.messageBtn?.snp.right)!)
            make.height.equalTo(30 * HEIGHT_SCALE)
        }
    }
    
    
    // 100消息的点击事件  200搜索的点击事件
    func tapClick(sender : UIButton) -> Void {
        
        if self.navigationBlock != nil {
            self.navigationBlock!(sender.tag)
        }
    }
    
}
