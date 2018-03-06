//
//  MyIntegralVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/2/27.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class MyIntegralVC: BasicVC, UITableViewDelegate, UITableViewDataSource {
    var integralLabel : UILabel = UILabel()// 积分
    var integralArray : [IntergralModel] = [IntergralModel]()// 列表
    var intergralTableView : UITableView?//

    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建UI
        createUI()
        
        // 获取积分
        requestInteralAmount()
        
        // 积分信息
        requestIntegralInfo()
    }

    
    // 创建UI
    func createUI() -> Void {
        let headeView : UIView = UIView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 134 * HEIGHT_SCALE))
        
        let backImageView : UIImageView = UIImageView()
        backImageView.isUserInteractionEnabled = true
        backImageView.image = UIImage (named: "integralHeaderBg")
        headeView.addSubview(backImageView)
        backImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(headeView)
        }

        let iconImageView : UIImageView = UIImageView()
        iconImageView.isUserInteractionEnabled = true
        iconImageView.contentMode = UIViewContentMode.center
        iconImageView.image = UIImage (named: "integralHeaderIcon")
        backImageView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.centerX.height.equalTo(backImageView)
            make.width.equalTo(240 * WIDTH_SCALE)
            make.height.equalTo(backImageView)
        }
        let tapClick : UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(integralClick))
        iconImageView.addGestureRecognizer(tapClick)
        
        // 积分数
        self.integralLabel.textColor = UIColor.white
        self.integralLabel.font = UIFont.systemFont(ofSize: 33 * WIDTH_SCALE)
        iconImageView.addSubview(self.integralLabel)
        integralLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconImageView)
            make.bottom.equalTo(iconImageView.snp.bottom).offset(-35 * HEIGHT_SCALE)
        }
        
        // 列表界面
        let tableView : UITableView = UITableView (frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(IntegralViewCell.self, forCellReuseIdentifier: "integralView")
        self.intergralTableView = tableView
        self.view.addSubview(self.intergralTableView!)
        self.intergralTableView?.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self.view)
        }
        self.intergralTableView?.tableHeaderView = headeView
    }
    
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 3
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10 * HEIGHT_SCALE
        } else {
            return 0.01
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view : UIView = UIView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 30 * HEIGHT_SCALE))
        view.backgroundColor = UIColor.white
        
        let headerLabel : UILabel = UILabel()
        headerLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        headerLabel.textColor = UIColor().colorWithHexString(hex: "777777")
        headerLabel.frame = CGRect (x: 15 * WIDTH_SCALE, y: 0, width: SCREEN_WIDTH - 30 * WIDTH_SCALE, height: 30 * HEIGHT_SCALE)
        if section == 0 {
            headerLabel.text = "每日任务"
        } else {
            headerLabel.text = "更多任务"
        }
        view.addSubview(headerLabel)
        return view
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : IntegralViewCell = tableView.dequeueReusableCell(withIdentifier: "integralView") as! IntegralViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // 积分换礼物
    func integralClick() -> Void {
        
    }
    
    
    // 积分明细
    func integralDetail() -> Void {
        self.navigationController?.pushViewController(intergralDetail(), animated: true)
    }
    
    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "我要攒积分");
        
        let rightBtn = UIButton (type: UIButtonType.custom)
        rightBtn.frame = CGRect (x: 0, y: 0, width: 60 * WIDTH_SCALE, height: 30)
        rightBtn.addTarget(self, action: #selector(integralDetail), for: UIControlEvents.touchUpInside)
        rightBtn.setTitle("积分明细", for: UIControlState.normal)
        rightBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15 * WIDTH_SCALE)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (customView: rightBtn)
    }
    
    
    // 获取积分
    func requestInteralAmount() -> Void {
        UserCenterService.userInstance.requestIntegralAmount(success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            
            // 更新UI
            let amount : String = (dataDict["totalGoldValue"] as! NSNumber).stringValue
            self.integralLabel.text = amount
        }) { (error) in
        }
    }
    
    
    // 积分信息
    func requestIntegralInfo() -> Void {
        UserCenterService.userInstance.requestIntegralInfo(success: { (responseObject) in
            let tempArray : NSArray = responseObject as! NSArray
            self.integralArray = IntergralModel.objectArrayWithKeyValuesArray(array: tempArray) as! [IntergralModel]
        }) { (error) in
            
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
