//
//  MyInterestFreeVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/2/27.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class MyInterestFreeVC: BasicVC, UITableViewDelegate, UITableViewDataSource {
    var footView : UIView = UIView()// 更多免息卷View
    lazy var nullView : UIView = UIView()// 无数据View
    var discountTableView : UITableView?// 列表View
    var discountArray : [DiscountModel] = [DiscountModel]()// 优惠卷列表
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 获取免息卷列表
        requestDiscountListData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建UI
        createUI()
    }

    
    // 创建UI撩汉出品
    func createUI() -> Void {
        // 列表界面
        let tableView : UITableView = UITableView (frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(DisCountViewCell.self, forCellReuseIdentifier: "disCountView")
        self.discountTableView = tableView
        self.view.addSubview(self.discountTableView!)
        self.discountTableView?.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.bottom).offset(-60 * HEIGHT_SCALE)
        }
        
        // 领取更多免息卷
        createFooterView()
        
        // 无数据界面
        createNullDataView()
    }
    
    
    // 无数据界面
    func createNullDataView() -> Void {
        self.nullView.isHidden = true
        self.view.addSubview(self.nullView)
        self.nullView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(200 * HEIGHT_SCALE)
        }
        
        let label : UILabel = UILabel()
        label.text = "暂无可用免息券，\n赶紧去领取吧~"
        label.textColor = UIColor().colorWithHexString(hex: "777777")
        label.font = UIFont.systemFont(ofSize: 20 * WIDTH_SCALE)
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        self.nullView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self.nullView)
        }
    }
    
    
    // 领取更多免息卷
    func createFooterView() -> Void {
        self.footView.isHidden = false
        self.view.addSubview(self.footView)
        self.footView.snp.makeConstraints { (make) in
            make.right.left.bottom.equalTo(self.view)
            make.height.equalTo(60 * HEIGHT_SCALE)
        }
        
        let moreBtn : UIButton = UIButton (type: UIButtonType.custom)
        moreBtn.setTitle("领取更多免息券", for: UIControlState.normal)
        moreBtn.setTitleColor(NAVIGATION_COLOR, for: UIControlState.normal)
        moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18 * WIDTH_SCALE)
        moreBtn.layer.cornerRadius = 2 * WIDTH_SCALE
        moreBtn.layer.borderColor = NAVIGATION_COLOR.cgColor
        moreBtn.layer.borderWidth = 1 * WIDTH_SCALE
        moreBtn.layer.masksToBounds = true
        moreBtn.addTarget(self, action: #selector(moreClick), for: UIControlEvents.touchUpInside)
        self.footView.addSubview(moreBtn)
        moreBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.footView.snp.left).offset(15 * WIDTH_SCALE)
            make.right.equalTo(self.footView.snp.right).offset(-15 * WIDTH_SCALE)
            make.top.equalTo(self.footView.snp.top).offset(10 * WIDTH_SCALE)
            make.bottom.equalTo(self.footView.snp.bottom).offset(-10 * WIDTH_SCALE)
        }
    }
    
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.discountArray.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DisCountViewCell = tableView.dequeueReusableCell(withIdentifier: "disCountView") as! DisCountViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.discountModel = self.discountArray[indexPath.section]
        cell.openBtn.tag = indexPath.section
        cell.openBtn.addTarget(self, action: #selector(openClick(sender:)), for: UIControlEvents.touchUpInside)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model : DiscountModel = self.discountArray[indexPath.section]
        if model.statusCode == "0" {
            weak var weakSelf = self
            let alertView : UIAlertView = UIAlertView (title: "暂不满足拆开红包的条件哦！", message: "", delegate: nil, cancelButtonTitle: "取消", otherButtonTitles: "去借款")
            alertView.showWithAlertBlock(alertBlock: { (btnIndex, btnTitle) in
                if btnIndex != 0 {
                    // 跳转贷款大全
                    APPDELEGATE.tabBarControllerSelectedIndex(index: 1)
                    
                    // 返回上个界面
                    weakSelf?.comeBack()
                }
            })
        }
    }
    
    
    // 领取更多免息卷
    func moreClick() -> Void {
        self.navigationController?.pushViewController(userCenterWebViewWithUrl(url: LuckDraw), animated: true)
    }
    
    
    // 右边的点击事件
    func openClick(sender : UIButton) -> Void {
        let model : DiscountModel = self.discountArray[sender.tag]
        if model.statusCode == "0" || model.statusCode == "1" {
            // 跳转贷款大全
            APPDELEGATE.tabBarControllerSelectedIndex(index: 1)
        }
    }
    
    
    // 使用说明
    func instructionsClick() -> Void {
        let path = Bundle.main.path(forResource: "redPackExplain", ofType: "html")
        self.navigationController?.pushViewController(localWebView(path: path!), animated: true)
    }

    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "我的免息卷");
        
        let rightBtn = UIButton (type: UIButtonType.custom)
        rightBtn.frame = CGRect (x: 0, y: 0, width: 60 * WIDTH_SCALE, height: 30)
        rightBtn.addTarget(self, action: #selector(instructionsClick), for: UIControlEvents.touchUpInside)
        rightBtn.setTitle("使用说明", for: UIControlState.normal)
        rightBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15 * WIDTH_SCALE)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (customView: rightBtn)
    }
    
    
    // 获取免息卷列表
    func requestDiscountListData() -> Void {
        UserCenterService.userInstance.requestDiscountList(success: { (responseObject) in
            let tempArray : NSArray = responseObject as! NSArray
            // 优惠卷列表
            self.discountArray = DiscountModel.objectArrayWithKeyValuesArray(array: tempArray) as! [DiscountModel]
            
            if self.discountArray.count > 0 {
                self.discountTableView?.isHidden = false
                self.footView.isHidden = false
                self.nullView.isHidden = true

                // 刷新数据
                self.discountTableView?.reloadData()
            } else {
                self.discountTableView?.isHidden = true
                self.footView.isHidden = true
                self.nullView.isHidden = false
            }
        }) { (error) in
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
