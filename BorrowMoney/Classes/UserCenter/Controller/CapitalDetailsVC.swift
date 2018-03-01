//
//  CapitalDetailsVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/2/27.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class CapitalDetailsVC: BasicVC, UITableViewDelegate, UITableViewDataSource {
    var nullView : CaptialNullDataView = CaptialNullDataView()// 无数据界面
    var headerView : CapitalDetailHeaderView = CapitalDetailHeaderView()// 头部选择
    var capitalTableView : UITableView?// 资金明细列表
    var allArray : [CapitalModel] = [CapitalModel]()// 全部列表
    var incomeArray : [CapitalModel] = [CapitalModel]()// 收入列表
    var expenditureArray : [CapitalModel] = [CapitalModel]()// 支出列表
    var selectType : Int = 0;// 默认选中全部   0全部 1收入 2支出
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 获取列表数据
        requestCapitalDetailList()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建UI
        createUI()
    }

    
    // 创建UI
    func createUI() -> Void {
        weak var weakSelf = self
        
        self.nullView.isHidden = true
        self.view.addSubview(self.nullView)
        self.nullView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self.view)
        }
        
        self.view.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view.snp.top).offset(10 * HEIGHT_SCALE)
            make.height.equalTo(50 * HEIGHT_SCALE)
        }
        self.headerView.capitalClick = {(tag) in
            // 0全部 1收入 2支出
            weakSelf?.selectType = tag
            // 刷新数据
            weakSelf?.capitalTableView?.reloadData()
        }

        let tableView : UITableView = UITableView (frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(CapitalViewCell.self, forCellReuseIdentifier: "capitalView")
        self.capitalTableView = tableView
        self.view.addSubview(self.capitalTableView!)
        self.capitalTableView?.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.headerView.snp.bottom)
        }
    }
    
    
    // MARK: UITableViewDataSource, UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.selectType == 0 {
            return self.allArray.count
        } else if self.selectType == 1 {
            return self.incomeArray.count
        } else {
            return self.expenditureArray.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CapitalViewCell = tableView.dequeueReusableCell(withIdentifier: "capitalView") as! CapitalViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        var capitalModel : CapitalModel?
        
        if self.selectType == 0 {
            capitalModel = self.allArray[indexPath.row]
        } else if self.selectType == 1 {
            capitalModel =  self.incomeArray[indexPath.row]
        } else {
            capitalModel =  self.expenditureArray[indexPath.row]
        }
        cell.captialModel = capitalModel
        return cell
    }
    
    
    override func setUpNavigationView() -> () {
        super.setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "资金明细");
    }
    
    
    // 获取列表数据
    func requestCapitalDetailList() -> Void {
        UserCenterService.userInstance.requestCaptialList(success: { (responseObject) in
            let tempArray : NSArray = responseObject as! NSArray
            // 全部列表
            self.allArray = CapitalModel.objectArrayWithKeyValuesArray(array: tempArray) as! [CapitalModel]
            
            if self.allArray.count > 0 {
                self.headerView.isHidden = false
                self.capitalTableView?.isHidden = false
                self.nullView.isHidden = true
                for capitalModel : CapitalModel in self.allArray {
                    if capitalModel.recordType == "收入" {
                        self.incomeArray.append(capitalModel)
                    } else {
                        self.expenditureArray.append(capitalModel)
                    }
                }
                
                // 刷新数据
                self.capitalTableView?.reloadData()
            } else {
                self.headerView.isHidden = true
                self.capitalTableView?.isHidden = true
                self.nullView.isHidden = false
            }
        }) { (errorInfo) in
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
