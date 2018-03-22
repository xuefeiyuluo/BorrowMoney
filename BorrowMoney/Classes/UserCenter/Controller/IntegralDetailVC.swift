//
//  IntegralDetailVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/4.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class IntegralDetailVC: BasicVC, UITableViewDelegate, UITableViewDataSource {
    var detailTableView : UITableView?// 添加机构列表
    var integralArray : [IntergralListModel] = [IntergralListModel]()// 明细列表

    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建UI
        createUI()
        
        // 获取积分明细列表
        requestIntergralDetailList()
    }

    // 创建UI
    func createUI() -> Void
    {
        // 添加机构列表
        let tableView :UITableView  = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = MAIN_COLOR
        tableView.separatorStyle = .none
        tableView.register(IntegralDetailCell.self, forCellReuseIdentifier: "integralCell")
        self.detailTableView = tableView
        self.view.addSubview(self.detailTableView!)
        self.detailTableView?.snp.makeConstraints({ (make) in
            make.top.left.right.bottom.equalTo(self.view)
        })
    }
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.integralArray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : IntegralDetailCell = tableView.dequeueReusableCell(withIdentifier: "integralCell") as! IntegralDetailCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.integralModel = self.integralArray[indexPath.row]
        return cell
    }
    

    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "积分明细");
    }
    
    
    // 获取积分明细列表
    func requestIntergralDetailList() -> Void {
        UserCenterService.userInstance.requestIntergralDetailList(success: { (responseObject) in
            let tempArray : NSArray = responseObject as! NSArray
            self.integralArray = IntergralListModel.objectArrayWithKeyValuesArray(array: tempArray) as! [IntergralListModel]
            
            // 刷新数据
            self.detailTableView?.reloadData()
        }) { (error) in
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
