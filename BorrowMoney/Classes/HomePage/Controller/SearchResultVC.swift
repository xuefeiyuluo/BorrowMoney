//
//  SearchResultVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/30.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class SearchResultVC: BasicVC, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    var navigationView : SearchNavigationView?// 头部搜索
    var resultTableView : UITableView?// 搜索列表
    var hotView : UIView = UIView()// 热搜View
    var dataDict : NSDictionary?// 热门搜索标签的数据源
    var hotArray : [String] = [String]()// 热门搜索标签列表
    var resultData : [HotLoanModel] = [HotLoanModel]()// 搜索结果列表
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 隐藏导航栏
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建自定义导航栏
        createCustomNavigationView()

        // 创建热搜UI
        createHotView()
        
        // 创建搜索结果列表
        createResultListUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 隐藏导航栏
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 显示导航栏
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    // 创建自定义导航栏
    func createCustomNavigationView() -> Void
    {
        let navigationView : SearchNavigationView = SearchNavigationView()
        navigationView.cancelBtn?.addTarget(self, action: #selector(cancelClick), for: UIControlEvents.touchUpInside)
        navigationView.searchBar?.layer.cornerRadius = 34 * HEIGHT_SCALE / 2
        navigationView.searchBar?.layer.masksToBounds = true
        navigationView.searchBar?.delegate = self
        self.navigationView = navigationView
        self.view.addSubview(self.navigationView!)
        self.navigationView?.snp.makeConstraints({ (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(64)
        })
        
    }
    
    
    // 创建热搜UI
    func createHotView() -> Void
    {
        self.view.addSubview(self.hotView)
        self.hotView.snp.makeConstraints { (make) in
            make.top.equalTo((self.navigationView?.snp.bottom)!).offset(15 * HEIGHT_SCALE)
            make.left.right.equalTo(self.view)
            make.height.equalTo(300 * HEIGHT_SCALE)
        }
        
        let titleLabel : UILabel = UILabel()
        titleLabel.text = self.dataDict?["defaultKeyword"] as? String
        titleLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        titleLabel.textColor = LINE_COLOR3
        self.hotView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.hotView)
            make.left.equalTo(self.hotView.snp.left).offset(8 * WIDTH_SCALE)
        }
        
        weak var weakSelf = self
        let keyView : HotSearchView = HotSearchView()
        keyView.frame = CGRect (x: 8 * WIDTH_SCALE, y: 20, width: SCREEN_WIDTH - 2 * 8 * WIDTH_SCALE, height: 200)
        self.hotView.addSubview(keyView)
        keyView.tagBlock = { (tag) in
            weakSelf?.navigationView?.searchBar?.text = (weakSelf?.hotArray[tag])!
        }
        
        
        let tempArray : [NSDictionary] = self.dataDict!["hotKeywordList"] as! [NSDictionary]
        for dict : NSDictionary in tempArray {
            self.hotArray.append(dict["keyword"] as! String)
        }
        // 更新数据
        keyView.createUI(dataArray: hotArray)
    }
    
    
    // 创建搜索结果列表
    func createResultListUI() -> Void
    {
        
        let resultTableView : UITableView = UITableView (frame: CGRect.zero, style: UITableViewStyle.grouped)
        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.isHidden = true
        resultTableView.separatorStyle = .none
        resultTableView.register(LoanBrandCell.self, forCellReuseIdentifier: "loanBrand")
        self.resultTableView = resultTableView
        self.view.addSubview(self.resultTableView!)
        self.resultTableView?.snp.makeConstraints({ (make) in
            make.top.right.left.bottom.equalTo(self.view)
        })
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.resultData.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let temphot : HotLoanModel = self.resultData[indexPath.section] as HotLoanModel
        if (temphot.descriptions?.isEmpty)! {
            return 75 * HEIGHT_SCALE
        } else {
            return 105 * HEIGHT_SCALE
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 10 * HEIGHT_SCALE
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.01 * HEIGHT_SCALE
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        return nil
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : LoanBrandCell = tableView.dequeueReusableCell(withIdentifier: "loanBrand") as! LoanBrandCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.hotModel = self.resultData[indexPath.section] as HotLoanModel
        cell.fastLoan?.tag = indexPath.section
        cell.fastLoan?.addTarget(self, action: #selector(fastClick(sender:)), for: UIControlEvents.touchUpInside)
        return cell
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let loanMode : HotLoanModel = self.resultData[indexPath.section]
        self.navigationController?.pushViewController(loanDetail(hotLoan:loanMode), animated: true)
    }
    
    
    // MARK: UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        requestKeywordLoanlist(keyword: searchBar.text!)
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty {
            XPrint("fdsvjkfs")
        }
    }
    
    
    // 一键申请点击事件
    func fastClick(sender: UIButton) -> Void
    {
//        let hotLoan : HotLoanModel = self.hotArray[sender.tag]
//        self.navigationController?.pushViewController(loanDetail(hotLoan: hotLoan), animated: true)
    }
    
    
    // 取消按钮
    func cancelClick() -> Void
    {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // 根据输入的关键词搜索
    func requestKeywordLoanlist(keyword:String) -> Void
    {
        HomePageService.homeInstance.requestSearchText(keyword: (self.navigationView?.searchBar?.text)!, success: { (responseObject) in
            let tempDict : NSDictionary = responseObject as! NSDictionary
            
//            self.resultData = HotLoanModel.objectArrayWithKeyValuesArray(array: tempDict["allList"] as! NSArray) as! [HotLoanModel]
            
        }) { (errorInfo) in
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
