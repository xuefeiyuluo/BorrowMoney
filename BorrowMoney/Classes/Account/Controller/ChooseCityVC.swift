//
//  ChooseCityVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/29.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias ChooseCityBlock = (String) -> Void
class ChooseCityVC: BasicVC, UITableViewDelegate, UITableViewDataSource {
    var headerView : SearchView = SearchView()// 搜索View
    var allCityArray : [AllCityModel] = [AllCityModel]()// 所有城市
    var hotCityArray : [CityModel] = [CityModel]()// 热门城市
    var cityTableView : UITableView?// 城市列表
    var titleArray : [String] = [String]()// 列表边上显示
    var chooseCityBlock : ChooseCityBlock?// 选中城市回调
    var searchText : Bool = true// 判断是否为搜索列表
    var cityArray : [CityModel] = [CityModel]()// 所有城市
    var searchArray : [CityModel] = [CityModel]()// 搜索到的城市
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建ui
        createUI()
        
        // 获取城市列表
        requestCityListData()
    }
    
    
    // 创建ui
    func createUI() -> Void {
        weak var weakSelf = self
        
        // 城市列表
        let tableView :UITableView  = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = MAIN_COLOR
        tableView.separatorStyle = .none
        tableView.register(CityPositionCell.self, forCellReuseIdentifier: "positionCell")
        tableView.register(CityHotCell.self, forCellReuseIdentifier: "hotCell")
        tableView.register(CityViewCell.self, forCellReuseIdentifier: "cityCell")
        self.cityTableView = tableView
        self.view.addSubview(self.cityTableView!)
        self.cityTableView?.snp.makeConstraints({ (make) in
            make.top.left.right.bottom.equalTo(self.view)
        })
        
        self.headerView.frame = CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 40 * HEIGHT_SCALE)
        self.view.addSubview(self.headerView)
        self.headerView.cancelBlock = { () in
            weakSelf?.searchText = true
            // 刷新界面
            weakSelf?.cityTableView?.reloadData()
        }
        self.headerView.searchBlock = { (text) in
            weakSelf?.searchText = false
            if text.isEmpty {
                weakSelf?.searchArray.removeAll()
            } else {
                for city : CityModel in (weakSelf?.cityArray)! {
                    if (city.zone_name.range(of: text) != nil) {
                        weakSelf?.searchArray.append(city)
                    } else if (city.en.lowercased().range(of: text.lowercased()) != nil) {
                        weakSelf?.searchArray.append(city)
                    }
                }
            }
            
            // 刷新界面
            weakSelf?.cityTableView?.reloadData()
        }
        self.cityTableView?.tableHeaderView = self.headerView
    }
    
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.searchText {
            return self.titleArray.count + 1
        } else {
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchText {
            if section == 0 || section == 1 {
                return 1
            } else {
                let model : AllCityModel = self.allCityArray[section - 2]
                return model.cityList.count
            }
        } else {
            return self.searchArray.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.searchText {
            return 28 * HEIGHT_SCALE
        } else {
            return 0.01 * HEIGHT_SCALE
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.searchText {
            let headerView : UIView = UIView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 28 * HEIGHT_SCALE))
            headerView.backgroundColor = MAIN_COLOR
            
            let label : UILabel = UILabel()
            if section == 0 {
                label.text = "当前定位城市"
            } else if section == 1 {
                label.text = "热门城市"
            } else {
                label.text = self.titleArray[section - 1]
            }
            
            label.textColor = UIColor.black
            label.font = UIFont.systemFont(ofSize: 15 * WIDTH_SCALE)
            headerView.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.top.bottom.right.equalTo(headerView)
                make.left.equalTo(15 * WIDTH_SCALE)
            }
            return headerView
        } else {
            return nil
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.searchText {
            if indexPath.section == 1 {
                if self.hotCityArray.count % 3 == 0 {
                    return CGFloat(self.hotCityArray.count / 3) * 40 * HEIGHT_SCALE
                } else {
                    return CGFloat((self.hotCityArray.count / 3 + 1)) * 40 * HEIGHT_SCALE
                }
            } else {
                return 45 * HEIGHT_SCALE
            }
        } else {
            return 45 * HEIGHT_SCALE
        }
    }
    
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if self.searchText {
            return self.titleArray
        } else {
            return []
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.searchText {
            weak var weakSelf = self
            if indexPath.section == 0 {
                let cell : CityPositionCell = tableView.dequeueReusableCell(withIdentifier: "positionCell") as! CityPositionCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.repositionBlock = { (cityName) in
                    if weakSelf?.chooseCityBlock != nil {
                        weakSelf?.chooseCityBlock!(cityName)
                    }
                }
                return cell
            } else if indexPath.section == 1 {
                let cell : CityHotCell = tableView.dequeueReusableCell(withIdentifier: "hotCell") as! CityHotCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.hotArray = self.hotCityArray
                cell.hotCityBlock = { (cityName) in
                    if weakSelf?.chooseCityBlock != nil {
                        weakSelf?.chooseCityBlock!(cityName)
                    }
                    weakSelf?.comeBack()
                }
                return cell
            } else {
                let cell : CityViewCell = tableView.dequeueReusableCell(withIdentifier: "cityCell") as! CityViewCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                let model : AllCityModel = self.allCityArray[indexPath.section - 2]
                cell.cityModel = model.cityList[indexPath.row]
                return cell
            }
        } else {
            let cell : CityViewCell = tableView.dequeueReusableCell(withIdentifier: "cityCell") as! CityViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.cityModel = self.searchArray[indexPath.row]
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var cityModel : CityModel = CityModel()
        if self.searchText {
            let model : AllCityModel = self.allCityArray[indexPath.section - 2]
            cityModel = model.cityList[indexPath.row]
        } else {
            cityModel = self.searchArray[indexPath.row]
        }
        
        if self.chooseCityBlock != nil {
            self.chooseCityBlock!(cityModel.zone_name)
        }
        self.comeBack()
    }
    
    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "选择城市");
    }
    
    
    // 获取城市列表
    func requestCityListData() -> Void {
        AccountService.accountInstance.requestCityResultList(success: { (responseObject) in
            let tempDict : NSDictionary = responseObject as! NSDictionary
            self.allCityArray = AllCityModel.objectArrayWithKeyValuesArray(array: tempDict["AllCity"] as! NSArray) as! [AllCityModel]
            self.hotCityArray = CityModel.objectArrayWithKeyValuesArray(array: tempDict["HotCity"] as! NSArray) as! [CityModel]
            
            self.titleArray.append("热")
            for model : AllCityModel in self.allCityArray {
                self.titleArray.append(model.letter)
                for city : CityModel in model.cityList {
                    self.cityArray.append(city)
                }
            }
            
            // 刷新界面
            self.cityTableView?.reloadData()
        }) { (errorInfo) in
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
