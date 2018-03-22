//
//  AddOrganVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/21.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class AddOrganVC: BasicVC, UITableViewDelegate, UITableViewDataSource {
    var organTableView : UITableView?// 添加机构列表
    var organArray : [OrganListModel] = [OrganListModel]()// 机构列表
    var titleArray : [String] = [String]()// 列表边上显示
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 获取机构列表
        requestOrganListData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建UI
        createUI()
    }
    
    // 创建UI
    func createUI() -> Void {
        // 添加机构列表
        let tableView :UITableView  = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = MAIN_COLOR
        tableView.separatorStyle = .none
        tableView.register(AddOrganCell.self, forCellReuseIdentifier: "addCell")
        self.organTableView = tableView
        self.view.addSubview(self.organTableView!)
        self.organTableView?.snp.makeConstraints({ (make) in
            make.top.left.right.bottom.equalTo(self.view)
        })
    }
    
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.organArray.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let organ : OrganListModel = self.organArray[section]
        return organ.orderList.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView : UIView = UIView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 25 * HEIGHT_SCALE))
        let label : UILabel = UILabel()
        label.text = self.titleArray[section]
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
        headerView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(headerView)
            make.left.equalTo(15 * WIDTH_SCALE)
        }
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55 * HEIGHT_SCALE
    }
    
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.titleArray
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AddOrganCell = tableView.dequeueReusableCell(withIdentifier: "addCell") as! AddOrganCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let organ : OrganListModel = self.organArray[indexPath.section]
        cell.organModel = organ.orderList[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let organ : OrganListModel = self.organArray[indexPath.section]
        let model : OrganModel = organ.orderList[indexPath.row]
        model.entryType = "1"
        self.navigationController?.pushViewController(organLogin(organModel: model), animated: true)
    }
    
    
    override func setUpNavigationView() {
        super.setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "添加贷款机构")
    }
    
    
    // 获取机构列表
    func requestOrganListData() -> Void {
        UserCenterService.userInstance.requestAddOrganList(success: { (responseObject) in
            let tempArray : NSArray = responseObject["result"] as! NSArray
            self.organArray = OrganListModel.objectArrayWithKeyValuesArray(array: tempArray) as! [OrganListModel]
            
            self.titleArray.removeAll()
            for organ : OrganListModel in self.organArray {
                self.titleArray.append(organ.firstLetter)
            }
            
            // 刷新数据
            self.organTableView?.reloadData()
        }) { (error) in
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
