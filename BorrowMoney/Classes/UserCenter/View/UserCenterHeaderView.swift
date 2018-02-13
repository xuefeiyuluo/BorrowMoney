//
//  UserCenterHeaderView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/11.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit
import Kingfisher

typealias UserHeaderBlock = (Int) -> Void
class UserCenterHeaderView: UIView {

    var userName : UILabel?// 姓名
    var headerImage : UIImageView?// 头像
    var userHeaderBlock : UserHeaderBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 创建UI
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // 创建UI
    func createUI() -> Void {
        let backImageView = UIImageView()
        backImageView.image = UIImage (named: "UserHeaderBg.png")
        backImageView.isUserInteractionEnabled = true
        self .addSubview(backImageView)
        backImageView.snp.makeConstraints({ (make) in
           make.top.right.bottom.left.equalTo(self)
        })
        
        
        // 头像
        let headerBackImageView = UIImageView()
        headerBackImageView .image = UIImage (named: "UserHeaderBg")
        backImageView .addSubview(headerBackImageView)
        headerBackImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(backImageView.snp.centerY)
            make.width.height.equalTo(52 * WIDTH_SCALE)
            make.left.equalTo(backImageView.snp.left).offset(10 * WIDTH_SCALE)
        }
        
        let headerImageView = UIImageView()
        headerImageView.image = UIImage (named: "avatarHeader.png")
        headerImageView.layer.cornerRadius = 46 * WIDTH_SCALE / 2
        headerImageView.layer.masksToBounds = true
        self.headerImage = headerImageView
        headerBackImageView .addSubview(self.headerImage!)
        self.headerImage?.snp.makeConstraints { (make) in
            make.center.equalTo(headerBackImageView.snp.center)
            make.width.height.equalTo(46 * WIDTH_SCALE)
        }
        
        // 登录信息
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 16 * WIDTH_SCALE)
        nameLabel.text = "点击登录"
        nameLabel.textColor = UIColor.white
        nameLabel.isUserInteractionEnabled = true
        self.userName = nameLabel
        backImageView .addSubview(self.userName!)
        self.userName?.snp.makeConstraints({ (make) in
            make.left.equalTo(backImageView.snp.left).offset(70 * WIDTH_SCALE)
            make.centerY.equalTo(backImageView.snp.centerY)
        })
        let tapClick : UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(headerClick))
        self.userName?.addGestureRecognizer(tapClick)
        
        // 完善信息
        let perfectBtn : UIButton = UIButton()
        perfectBtn .setTitle("完善信息 >", for: UIControlState.normal)
        perfectBtn .addTarget(self, action: #selector(perfectClick), for: UIControlEvents.touchUpInside)
        perfectBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16 * WIDTH_SCALE)
        backImageView .addSubview(perfectBtn)
        perfectBtn.snp.makeConstraints { (make) in
            make.right.equalTo(backImageView.snp.right).offset(-10 * WIDTH_SCALE)
            make.centerY.equalTo(backImageView.snp.centerY)
            make.width.equalTo(80 * WIDTH_SCALE)
            make.height.equalTo(30 * HEIGHT_SCALE)
        }
        
        // 完善信息图标
        let perfectIconBtn : UIButton = UIButton()
        perfectIconBtn .setTitle("提升额度", for: UIControlState.normal)
        perfectIconBtn.setImage(UIImage (named: "perfectIcon.png"), for: UIControlState.normal)
        perfectIconBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        backImageView .addSubview(perfectIconBtn)
        perfectIconBtn.snp.makeConstraints { (make) in
            make.right.equalTo(backImageView.snp.right).offset(-10 * WIDTH_SCALE)
            make.top.equalTo(perfectBtn.snp.bottom)
            make.width.equalTo(perfectBtn.snp.width)
            make.height.equalTo(14 * HEIGHT_SCALE)
        }
        
    }
    
    
    // 数据更新
    func updateHeadeView(userCenter : UserCenterModel) -> Void {
        
        // 头像
        self.headerImage?.kf.setImage(with: URL (string: userCenter.headImage!), placeholder: UIImage (named: ""), options: [KingfisherOptionsInfoItem.forceRefresh], progressBlock: nil, completionHandler: nil)
        
        // 姓名
        if !self.isEmptyAndNil(str: userCenter.name!) {
            self.userName?.text = userCenter.name
        } else {
            if !self.isEmptyAndNil(str: userCenter.mobile!) {
                self.userName?.text = userCenter.mobile
            } else {
                if ASSERLOGIN! {
                    self.userName?.text = ""
                } else {
                    self.userName?.text = "点击登录"
                }
            }
        }
    }
    
    
    // 退出登录的界面
    func loginOutUpdateView() -> Void {
        self.headerImage?.image = UIImage (named: "avatarHeader.png")
        self.userName?.text = "点击登录"
    }
    

    // 头像的点击事件
    func headerClick() -> Void {
        if self.userHeaderBlock != nil {
            userHeaderBlock!(100)
        }
    }
    
    // 完善信息的点击事件
    func perfectClick() -> Void {
        if self.userHeaderBlock != nil {
            userHeaderBlock!(200)
        }
    }
}
