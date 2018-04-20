//
//  LoanBooksVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/10/12.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class LoanBooksVC: BasicVC, UITableViewDataSource, UITableViewDelegate {
    lazy var headerView : LoanBooksHeaderView = LoanBooksHeaderView()// 选择框
    lazy var dropdownView : DropdownView = DropdownView()// 下拉弹框
    lazy var backBtn : UIButton = UIButton (type: UIButtonType.custom)// 背景点击事件
    var mainView : UIView = UIView()// 下拉弹框
    var booksTableView : UITableView = UITableView()// 列表界面
    var dropViewState : Bool = false// 记录下拉框的状态
    var dropViewHeight : CGFloat = 105;// 默认下拉框的高度为105
    var selectedHeaderTag : Int = 0;// 当前选中的头部按钮
    var sameTag = 0;// 判断在下拉列表显示点击的是否为同一个tag
    var amountArray : [LoanAmountType] = [LoanAmountType]()// 贷款金额区间
    var typeArray : [LoanAmountType] = [LoanAmountType]()// 贷款类型区间
    var sortArray : [LoanAmountType] = [LoanAmountType]()// 贷款排序区间
    var amountSelectrd : LoanAmountType?// 金额选中
    var typeSelectrd : LoanAmountType?// 类型选中
    var sortSelectrd : LoanAmountType?// 排名选中
    var booksArray : [HotLoanModel] = [HotLoanModel]()// 列表数据
    var currentPage : Int = 1;// 列表的当前页数
    var first = 0;// 首次进入该界面
    var homeToBooks : String = "-1"// 默认值为-1 从首页跳转贷款大全
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建界面
        createUI()
        
        // 获取金额区间
        requestLoanAmountRang()

        // 获取贷款类型
        requestLoanType()
    }

    
    // 创建界面
    func createUI() -> Void {
        weak var weakSelf = self
        
        // 创建蒙层View
        createBackGroundView()
        
        let view : UIView = UIView (frame: CGRect (x: 0, y: 40, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64 - 40))
        view.backgroundColor = MAIN_COLOR
        self.mainView = view
        self.view.addSubview(view)
        
        // 头部点击框
        self.view.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(40 * HEIGHT_SCALE)
        }
        // "amount"  "loanType" "sort"
        self.headerView.tapClickType = { (type) in
            weakSelf?.view.insertSubview(self.backBtn, belowSubview: (weakSelf?.headerView)!)
            
            if type == "amount" {
                weakSelf?.selectedHeaderTag = 0
                weakSelf?.dropViewHeight = 105 * HEIGHT_SCALE
                weakSelf?.dropdownView.dropViewHeight = (weakSelf?.dropViewHeight)!
            } else if type == "loanType" {
                weakSelf?.selectedHeaderTag = 1
                weakSelf?.dropViewHeight = 185 * HEIGHT_SCALE
                weakSelf?.dropdownView.dropViewHeight = (weakSelf?.dropViewHeight)!
            } else if type == "sort" {
                weakSelf?.selectedHeaderTag = 2
                weakSelf?.dropViewHeight = 200 * HEIGHT_SCALE
                weakSelf?.dropdownView.dropViewHeight = (weakSelf?.dropViewHeight)!
            }
            // 显示动画
            weakSelf?.animationShowView()
        }
        
        // 下拉框
        self.dropdownView.frame = CGRect (x: 0, y: -self.dropViewHeight * HEIGHT_SCALE, width: SCREEN_WIDTH, height: self.dropViewHeight * HEIGHT_SCALE)
        self.view.addSubview(self.dropdownView)
        self.dropdownView.dataBlock = { (loanType : LoanAmountType,tag : Int) in
            let type : String = loanType.type!
            if type == "amount" {
                weakSelf?.amountSelectrd = loanType
                // 更新头部数据
                weakSelf?.updateHeaderViewData(dataArray: (weakSelf?.amountArray)!, tag: tag)
                // 更新头部文案
                weakSelf?.headerView.changeHeaderButtonText(tag : (weakSelf?.selectedHeaderTag)!, titleText:loanType.desc!)
            } else if type == "type" {
                weakSelf?.typeSelectrd = loanType
                // 更新头部数据
                weakSelf?.updateHeaderViewData(dataArray: (weakSelf?.typeArray)!, tag: tag)
                // 更新头部文案
                weakSelf?.headerView.changeHeaderButtonText(tag : (weakSelf?.selectedHeaderTag)!, titleText:loanType.tagName!)
            } else if type == "sort" {
                weakSelf?.sortSelectrd = loanType
                // 更新头部数据
                weakSelf?.updateHeaderViewData(dataArray: (weakSelf?.sortArray)!, tag: tag)
                // 更新头部文案
                weakSelf?.headerView.changeHeaderButtonText(tag : (weakSelf?.selectedHeaderTag)!, titleText:loanType.sortName!)
            }
            
            // 取消蒙层页
            weakSelf?.backClick()
            
            weakSelf?.currentPage = 1
            // 获取贷款列表
            weakSelf?.requestLoanList()
        }
        
        // 创建列表界面
        createTableView()
        
        // 添加下拉刷新 上拉加载更多
        setUpRefresh()
    }
    
    
    // 创建列表界面
    func createTableView() -> Void {
        let tableView : UITableView = UITableView (frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(LoanBrandCell.self, forCellReuseIdentifier: "loanBrand")
        self.booksTableView = tableView
        self.mainView.addSubview(self.booksTableView)
        self.booksTableView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.mainView)
            make.bottom.equalTo(self.mainView.snp.bottom).offset(-49)
        }
    }
    
    
    // 添加下拉刷新 上拉加载更多
    func setUpRefresh() -> Void {
        // 下拉刷新
        var imageArray : [UIImage] = [UIImage]()
        for i in 0 ..< 6 {
            let imageName : String = String (format: "BorrowMoney%d", i)
            
            let image : UIImage = UIImage (named: imageName)!
            imageArray.append(image)
        }
        
        self.booksTableView.mj_header = MJRefreshGifHeader(refreshingBlock: { () -> Void in
            self.currentPage = 1
            self.requestLoanList()
        })
        var imageArray2 : [UIImage] = [UIImage]()
        let image2 : UIImage = UIImage (named: "Money")!
        imageArray2.append(image2)
        let header : MJRefreshGifHeader = self.booksTableView.mj_header as! MJRefreshGifHeader
        header.setImages(imageArray2, for: MJRefreshState.idle)
        header.setImages(imageArray, for: MJRefreshState.pulling)
        header.setImages(imageArray, for: MJRefreshState.refreshing)
        header.lastUpdatedTimeLabel.isHidden = true
        
        // 上拉加载更多
        self.booksTableView.mj_footer = MJRefreshAutoNormalFooter (refreshingBlock: {
            self.requestLoanList()
        })
        let footer : MJRefreshAutoNormalFooter = self.booksTableView.mj_footer as! MJRefreshAutoNormalFooter
        footer.setTitle("接小二努力加载产品中...", for: .idle)
        footer.setTitle("接小二努力加载产品中...", for: .refreshing)
        footer.setTitle("没有没有更多数据了", for: .noMoreData)
    }
    
    
    // MARK: UITableViewDataSource, UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.booksArray.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let temphot : HotLoanModel = self.booksArray[indexPath.section] as HotLoanModel
        if (temphot.descriptions?.isEmpty)! {
            return 75 * HEIGHT_SCALE
        } else {
            return 105 * HEIGHT_SCALE
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40 * HEIGHT_SCALE
        }
        return 0.01
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let prompt : UIButton = UIButton (type: UIButtonType.custom)
            prompt.setTitle("申请多个产品，可大幅提高贷款成功率", for: UIControlState.normal)
            prompt.setImage(UIImage (named: "booksTips.png"), for: UIControlState.normal)
            prompt.frame = CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 40 * HEIGHT_SCALE)
            prompt.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5)
            prompt.titleLabel?.font = UIFont.systemFont(ofSize: 12 * HEIGHT_SCALE)
            prompt.setTitleColor(LINE_COLOR3, for: UIControlState.normal)
            return prompt
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : LoanBrandCell = tableView.dequeueReusableCell(withIdentifier: "loanBrand") as! LoanBrandCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.hotModel = self.booksArray[indexPath.section] as HotLoanModel
        cell.fastLoan?.tag = indexPath.section
        cell.fastLoan?.addTarget(self, action: #selector(fastClick(sender:)), for: UIControlEvents.touchUpInside)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let loanMode : HotLoanModel = self.booksArray[indexPath.section]
        loanMode.source = "2"
        self.navigationController?.pushViewController(loanDetail(hotLoan:loanMode), animated: true)
    }
    
    
    // 创建蒙层View
    func createBackGroundView() -> Void {
        let cover : UIButton = UIButton(type: UIButtonType.custom)
        cover.addTarget(self, action: #selector(backClick), for: UIControlEvents.touchUpInside)
        cover.backgroundColor = UIColor.init(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 0.5)
        self.backBtn = cover
        self.backBtn.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        self.view.addSubview(self.backBtn)
        self.view.insertSubview(self.backBtn, belowSubview: self.mainView)
    }
    
    
    // 设置标题栏
    override func setUpNavigationView() {
        super.setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "贷款大全");
        self.navigationItem.leftBarButtonItem = nil
    }
    
    
    // 一键申请点击事件
    func fastClick(sender: UIButton) -> Void {
//        let hotLoan : HotLoanModel = self.hotArray[sender.tag]
//        self.navigationController?.pushViewController(loanDetail(hotLoan: hotLoan), animated: true)
    }
    
    
    // 取消蒙层页
    func backClick() -> Void {
        self.headerView.animationForBtnTag(tag:self.selectedHeaderTag)
        // 隐藏下拉框
        animationHiddleView()
    }
    
    
    // 动画显示View
    func animationShowView() -> Void {
        if self.sameTag != self.selectedHeaderTag && self.dropViewState {
            animationHiddleAndShow()
            return
        }
        if self.dropViewState {
            animationHiddleView()
            self.view.insertSubview(self.backBtn, belowSubview: self.mainView)
            return
        }
        
        updateDropViewData()
        self.view.insertSubview(self.dropdownView, belowSubview: self.headerView)
        UIView.animate(withDuration: 0.3, animations: {
            self.dropdownView.frame = CGRect (x: 0, y: 40 * HEIGHT_SCALE, width: SCREEN_WIDTH, height: self.dropViewHeight * HEIGHT_SCALE)
        }) { (finished) in
            self.dropViewState = true
            self.sameTag = self.selectedHeaderTag
        }
    }
    
    
    // 动画隐藏View
    func animationHiddleView() -> Void {
        if !self.dropViewState {
            return
        }
        self.view.insertSubview(self.backBtn, belowSubview: self.mainView)
        UIView.animate(withDuration: 0.3, animations: {
            self.dropdownView.frame = CGRect (x: 0, y: -self.dropViewHeight * HEIGHT_SCALE, width: SCREEN_WIDTH, height: self.dropViewHeight * HEIGHT_SCALE)
        }) { (finished) in
            self.dropViewState = false
        }
    }
    
    
    // 隐藏再次显示的动画
    func animationHiddleAndShow() -> Void {
        UIView.animate(withDuration: 0.15, animations: {
            self.view.insertSubview(self.backBtn, belowSubview: self.dropdownView)
            self.dropdownView.frame = CGRect (x: 0, y: -self.dropViewHeight * HEIGHT_SCALE, width: SCREEN_WIDTH, height: self.dropViewHeight * HEIGHT_SCALE)
        }) { (finished) in
            self.view.insertSubview(self.dropdownView, belowSubview: self.headerView)
            self.updateDropViewData()
            UIView.animate(withDuration: 0.15, animations: {
                self.dropdownView.frame = CGRect (x: 0, y: 40 * HEIGHT_SCALE, width: SCREEN_WIDTH, height: self.dropViewHeight * HEIGHT_SCALE)
            }) { (finished) in
                self.dropViewState = true
                self.sameTag = self.selectedHeaderTag
            }
        }
    }
    
    
    // 更新头部数据
    func updateHeaderViewData(dataArray : [LoanAmountType],tag : Int) -> Void {
        for i in 0 ..< dataArray.count {
            let loanType : LoanAmountType = dataArray[i]
            if i == tag {
                loanType.typeSelected = true
            } else {
                loanType.typeSelected = false
            }
        }
    }
    

    // 更新下拉框数据
    func updateDropViewData() -> Void {
        if self.selectedHeaderTag == 0 {
            // 更新金额数据
            self.dropdownView.updateDropViewData(dataArray: self.amountArray)
        } else if self.selectedHeaderTag == 1 {
            // 更新类型数据
            self.dropdownView.updateDropViewData(dataArray: self.typeArray)
        } else {
            // 更新排序数据
            self.dropdownView.updateDropViewData(dataArray: self.sortArray)
        }
    }
    
    
    // 初始化数据
    override func initializationData() {
        let sortNameArray : [String] = ["默认排序","贷款成功率","贷款速度","贷款利率","贷款额度"]
        let sortSubmitArray : [String] = ["default","successRate","speed","interestRate","amount"]
        for i in 0 ..< 5 {
            let sortType : LoanAmountType = LoanAmountType()
            sortType.sortName = sortNameArray[i]
            sortType.sortSubmit = sortSubmitArray[i]
            sortType.type = "sort";
            if i == 0 {
                sortType.typeSelected = true
                self.sortSelectrd = sortType
            } else {
                sortType.typeSelected = false
            }
            self.sortArray.append(sortType)
        }
    }
    
    
    // 首次请求数据
    func firstRequestLoanData() -> Void {
        if self.first == 2 {
            // 从首页跳转贷款大全时，对头部数据的处理
            requestLoanListData()
        }
    }
    
    
    // 从首页跳转贷款大全页面
    func fromHomeToLoanBooks(loanType : String) -> Void {
        self.homeToBooks = loanType
        if self.first == 2 {
            // 从首页跳转贷款大全时，对头部数据的处理
            requestLoanListData()
        } else {
            // 获取金额区间
            requestLoanAmountRang()
            
            // 获取贷款类型
            requestLoanType()
        }
    }
    
    
    // 首页跳转贷款大全后，更新头部下拉框的数据
    func updateHeaderDateFromHome() -> Void {
        if self.homeToBooks != "-1" {
            
            // 金额数据
            updateHeaderViewData(dataArray: self.amountArray, tag: 0)
            self.amountSelectrd = self.amountArray[0]
            self.headerView.changeHeaderButtonText(tag : 0, titleText:(self.amountSelectrd?.desc)!)
            
            // 贷款类型
            for i in 0 ..< self.typeArray.count {
                let model : LoanAmountType = self.typeArray[i]
                if model.tagId == self.homeToBooks {
                    model.typeSelected = true
                    self.typeSelectrd = model
                } else {
                    model.typeSelected = false
                }
            }
            self.headerView.changeHeaderButtonText(tag : 1, titleText:(self.typeSelectrd?.tagName)!)
            
            // 排序
            updateHeaderViewData(dataArray: self.sortArray, tag: 0)
            self.sortSelectrd = self.sortArray[0]
            self.headerView.changeHeaderButtonText(tag : 2, titleText:(self.sortSelectrd?.sortName)!)
            
            // 重置为初始状态
            self.homeToBooks = "-1"
        }
    }
    
    
    // 从首页跳转贷款大全时，对头部数据的处理
    func requestLoanListData() -> Void {
        // 首页跳转贷款大全后，更新头部下拉框的数据
        updateHeaderDateFromHome()
        
        // 获取贷款列表
        requestLoanList()
    }
    
    
    
    
    // 获取贷款类型
    func requestLoanType() -> Void {
        LoanBooksService.loanInstance.requestLoanType(success: { (responseObject) in
            self.typeArray = LoanAmountType.objectArrayWithKeyValuesArray(array: responseObject as! NSArray) as! [LoanAmountType]
            for amountType : LoanAmountType in self.typeArray {
                amountType.type = "type"
            }
            if self.typeArray.count > 0 {
                let allType : LoanAmountType = LoanAmountType()
                allType.typeSelected = true
                allType.tagName = "所有贷款类型"
                allType.type = "type";
                // 将所有类型插入第一个
                self.typeArray.insert(allType, at: 0)
                self.typeSelectrd = allType
            }
            self.first += 1
            self.firstRequestLoanData()
        }) { (errorInfo) in
        }
    }
    
    
    // 获取金额区间
    func requestLoanAmountRang() -> Void {
        LoanBooksService.loanInstance.requestLoanAmontRank(success: { (responseObject) in
            self.amountArray = LoanAmountType.objectArrayWithKeyValuesArray(array: responseObject as! NSArray) as! [LoanAmountType]
            for amountType : LoanAmountType in self.amountArray {
                amountType.type = "amount"
            }
            
            if self.amountArray.count >= 1 {
                let amountType : LoanAmountType = self.amountArray.first!
                self.amountSelectrd = amountType
                amountType.typeSelected = true
            }
            self.first += 1
            self.firstRequestLoanData()
        }) { (errorInfo) in
        }
    }

    
    // 获取贷款列表
    func requestLoanList() -> Void {
        LoanBooksService.loanInstance.requestLoanBooksList(rankType: (self.sortSelectrd?.sortSubmit)!, loanTagId: (self.typeSelectrd?.tagId)!, leftRange: (self.amountSelectrd?.leftRange)!, rightRange: (self.amountSelectrd?.rightRange)!, offset: String.init(format: "%i", self.currentPage), success: { (responseObject) in
            // 取消上拉 下拉动画
            self.booksTableView.mj_header.endRefreshing()
            self.booksTableView.mj_footer.endRefreshing()
            
            let tempDict : NSDictionary = responseObject as! NSDictionary
            
            let tempArray : [HotLoanModel] = HotLoanModel.objectArrayWithKeyValuesArray(array: tempDict["allList"] as! NSArray) as! [HotLoanModel]
            
            if self.currentPage == 1 {
                self.booksArray.removeAll()
            }
            
            if tempArray.count < 10 {
                self.booksTableView.mj_footer.endRefreshingWithNoMoreData()
            }
            
            self.booksArray += tempArray
            self.currentPage += 1
            
            self.booksTableView.reloadData()
        }) { (errorInfo) in
            // 取消上拉 下拉动画
            self.booksTableView.mj_header.endRefreshing()
            self.booksTableView.mj_footer.endRefreshing()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
