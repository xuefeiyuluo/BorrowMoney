//
//  AccountManageVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/2/27.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class AccountManageVC: BasicVC, UITableViewDelegate, UITableViewDataSource {
    var footerView : UIView = UIView()// 底部"添加机构"View
    var accountTableView : UITableView?// 账号管理列表
    var accounArray : [AccountModel] = [AccountModel]()// 账号管理列表
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 获取账号管理列表
        requestAccountManagelistData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建界面
        createUI()
    }

    
    // 创建界面
    func createUI() -> Void {
        // 账号管理列表
        let tableView :UITableView  = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = MAIN_COLOR
        tableView.separatorStyle = .none
        tableView.register(AccountManageCell.self, forCellReuseIdentifier: "accountCell")
        self.accountTableView = tableView
        self.view.addSubview(self.accountTableView!)
        self.accountTableView?.snp.makeConstraints({ (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.bottom).offset(-44 * HEIGHT_SCALE)
        })
        
        self.footerView.frame = CGRect (x: 0, y: SCREEN_HEIGHT - 64 - 44 * HEIGHT_SCALE, width: SCREEN_WIDTH, height: 44 * HEIGHT_SCALE)
        footerView.backgroundColor = NAVIGATION_COLOR
        self.view.addSubview(self.footerView)
        let btn : UIButton = UIButton (type: UIButtonType.custom)
        btn.setTitle("添加贷款机构", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17 * WIDTH_SCALE)
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -10 * WIDTH_SCALE, 0, 0)
        btn.setImage(UIImage (named: "accountAdd.png"), for: UIControlState.normal)
        btn.setImage(UIImage (named: "accountAdd.png"), for: UIControlState.highlighted)
        btn.addTarget(self, action: #selector(addMoreClick), for: UIControlEvents.touchUpInside)
        self.footerView.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self.footerView)
        }
    }
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.accounArray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AccountManageCell = tableView.dequeueReusableCell(withIdentifier: "accountCell") as! AccountManageCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.accountModel = self.accounArray[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let account : AccountModel = self.accounArray[indexPath.row]
        self.navigationController?.pushViewController(organDetail(accountModel: account), animated: true)
    }
    
    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "账号管理");
    }
    
    
    // 添加贷款机构
    func addMoreClick() -> Void
    {
        self.navigationController?.pushViewController(addOrganList(), animated: true)
    }
    
    // 获取账号管理列表
    func requestAccountManagelistData() -> Void {
        UserCenterService.userInstance.requestAccountManage(success: { (responseObject) in
            let tempDict : NSDictionary = responseObject as! NSDictionary
            
            self.accounArray = AccountModel.objectArrayWithKeyValuesArray(array: tempDict["accounts"] as! NSArray) as! [AccountModel]
            
            // 刷新界面
            self.accountTableView?.reloadData()
        }) { (error) in
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
