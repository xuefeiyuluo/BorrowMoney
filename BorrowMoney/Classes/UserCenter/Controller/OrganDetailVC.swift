//
//  OrganDetailVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/21.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class OrganDetailVC: BasicVC {
    var accountModel : AccountModel?// 上一个界面
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建UI
        createUI()
    }

    // 创建UI
    func createUI() -> Void
    {
        // 贷款机构
        let channelView : UIView = UIView()
        channelView.backgroundColor = UIColor.white
        self.view.addSubview(channelView)
        channelView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(40 * HEIGHT_SCALE)
        }
        
        let channelLabel : UILabel = UILabel()
        channelLabel.text = "贷款机构"
        channelLabel.textColor = TEXT_SECOND_COLOR
        channelLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        channelView.addSubview(channelLabel)
        channelLabel.snp.makeConstraints { (make) in
            make.bottom.top.equalTo(channelView)
            make.left.equalTo(channelView.snp.left).offset(15 * WIDTH_SCALE)
        }
        
        let nameLabel : UILabel = UILabel()
        nameLabel.text = self.accountModel?.loanChannelName
        nameLabel.textColor = LINE_COLOR3
        nameLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        channelView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.bottom.top.equalTo(channelView)
            make.right.equalTo(channelView.snp.right).offset(-15 * WIDTH_SCALE)
        }
        
        let lineView1 : UIView = UIView()
        lineView1.backgroundColor = LINE_COLOR2
        channelView.addSubview(lineView1)
        lineView1.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(channelView)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        
        // 账号
        let accountView : UIView = UIView()
        accountView.backgroundColor = UIColor.white
        self.view.addSubview(accountView)
        accountView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(channelView.snp.bottom)
            make.height.equalTo(40 * HEIGHT_SCALE)
        }

        let accountLabel : UILabel = UILabel()
        accountLabel.text = "账号"
        accountLabel.textColor = TEXT_SECOND_COLOR
        accountLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        accountView.addSubview(accountLabel)
        accountLabel.snp.makeConstraints { (make) in
            make.bottom.top.equalTo(accountView)
            make.left.equalTo(accountView.snp.left).offset(15 * WIDTH_SCALE)
        }

        let nameLabel1 : UILabel = UILabel()
        nameLabel1.text = self.accountModel?.loanUserName
        nameLabel1.textColor = LINE_COLOR3
        nameLabel1.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        accountView.addSubview(nameLabel1)
        nameLabel1.snp.makeConstraints { (make) in
            make.bottom.top.equalTo(accountView)
            make.right.equalTo(accountView.snp.right).offset(-15 * WIDTH_SCALE)
        }

        let lineView2 : UIView = UIView()
        lineView2.backgroundColor = LINE_COLOR2
        accountView.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(accountView)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        // 创建底部vIEW
        createFooterView()
    }
    
    
    // 创建底部vIEW
    func createFooterView() -> Void
    {
        let promptLabel : UILabel = UILabel()
        promptLabel.text = "如果因你在贷款机构修改了登录密码，而导致了数据导入问题，请重新一键导入"
        promptLabel.textColor = UIColor().colorWithHexString(hex: "5f5f5f")
        promptLabel.font = UIFont.systemFont(ofSize: 13 * HEIGHT_SCALE)
        promptLabel.numberOfLines = 0
        self.view.addSubview(promptLabel)
        promptLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(12.5 * WIDTH_SCALE)
            make.top.equalTo(self.view.snp.top).offset(95 * HEIGHT_SCALE)
            make.width.lessThanOrEqualTo(SCREEN_WIDTH - 42.5 * WIDTH_SCALE)
        }
        
        let imageView : UIImageView = UIImageView()
        imageView.contentMode = UIViewContentMode.center
        imageView.image = UIImage (named: "sighIcon.png")
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(25 * WIDTH_SCALE)
            make.top.bottom.equalTo(promptLabel)
            make.right.equalTo(promptLabel.snp.left)
        }
        
        let reimportBtn : UIButton = UIButton (type: UIButtonType.custom)
        reimportBtn.setTitle("重新一键导入", for: UIControlState.normal)
        reimportBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17 * WIDTH_SCALE)
        reimportBtn.setTitleColor(NAVIGATION_COLOR, for: UIControlState.normal)
        reimportBtn.layer.borderColor = NAVIGATION_COLOR.cgColor
        reimportBtn.layer.borderWidth = 1 * WIDTH_SCALE
        reimportBtn.layer.cornerRadius = 5 * WIDTH_SCALE
        reimportBtn.layer.masksToBounds = true
        reimportBtn.addTarget(self, action: #selector(reimportClick), for: UIControlEvents.touchUpInside)
        self.view.addSubview(reimportBtn)
        reimportBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(15 * WIDTH_SCALE)
            make.right.equalTo(self.view.snp.right).offset(-15 * WIDTH_SCALE)
            make.height.equalTo(40 * HEIGHT_SCALE)
            make.top.equalTo(promptLabel.snp.bottom).offset(15 * HEIGHT_SCALE)
        }
    }
    
    
    override func setUpNavigationView() {
        super.setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: (self.accountModel?.loanUserName)!)
        
        let rightBtn = UIButton (type: UIButtonType.custom)
        rightBtn.frame = CGRect (x: 0, y: 0, width: 60 * WIDTH_SCALE, height: 30)
        rightBtn.titleLabel?.font = UIFont .systemFont(ofSize: 13)
        rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -40 * WIDTH_SCALE)
        rightBtn.setTitle("删除", for: UIControlState.normal)
        rightBtn.addTarget(self, action: #selector(deleteClick), for: UIControlEvents.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (customView: rightBtn)
    }
    
    
    func deleteClick() -> Void {
        let alertView : UIAlertView = UIAlertView (title: "确认删除本账号么？", message: "", delegate: nil, cancelButtonTitle: "取消", otherButtonTitles: "确定")
        weak var weakSelf = self
        alertView.showWithAlertBlock(alertBlock: { (btnIndex, btnTitle) in
            if btnIndex != 0 {
                // 删除该机构
                weakSelf?.requestUpdateChannelState()
            }
        })
    }
    
    
    // 重新导入的点击事件
    func reimportClick() -> Void {
        let organModel : OrganModel = OrganModel()
        organModel.logo = (self.accountModel?.productLogo)!
        organModel.channelId = (self.accountModel?.loanChannelId)!
        organModel.name = (self.accountModel?.loanChannelName)!
        organModel.entryType = ""
        organModel.account = (self.accountModel?.loanUserName)!
        self.navigationController?.pushViewController(organLogin(organModel: organModel), animated: true)
    }
    
    // 删除该机构
    func requestUpdateChannelState() -> Void {
        UserCenterService.userInstance.requestUpdateChannelState(channelId: (self.accountModel?.loanChannelId)!, loanUserName: (self.accountModel?.loanUserName)!, loanPassword: "", delFlag: "1", success: { (responseObject) in
            self.navigationController?.popViewController(animated: true)
        }) { (error) in
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
