//
//  HomePageVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/10/12.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class HomePageVC: BasicVC, UITableViewDelegate, UITableViewDataSource {

    var navigationView : CustomNavigationView?//
    var tableHeaderView : UIView?// 头部view
    var tablefooterView : UIView?// 底部View
    var homeTableView : UITableView?//
    var productTypeView : ProductTypeView?// 产品类别
    var rollPictureView : RollPictureView?// 滚动图
    var fixedAdverView : FixedAdverView?// 固定广告
    var bannerArray : [BannerModel] = [BannerModel]()// 全部广告数据
    var hotArray : [HotLoanModel] = [HotLoanModel]()// 热门贷款数据
    var messageTimer : Timer?// 消息的定时器
    var hotText : NSDictionary?// 最近热搜的标签
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 隐藏导航栏
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // 获取热门贷款信息
        self.requestHotLoanInfo()
        
        // 请求消息数据
        self.requestMessageList()
        
        // 消息中心的定时器
        createTimer()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建自定义导航栏
        createCustomNavigationView()
        
        // 创建界面
        createUI()
        
        // 添加下拉刷新
        createRefresh()
        
        // 获取首页广告信息(只请求一次)
        requestBannerInfo()
        
        // 最近热搜标签
        requestHotText()
    }

    
    // 消息的定时器
    func createTimer() -> Void {
//        if self.messageTimer == nil {
//            self.messageTimer = Timer (timeInterval: 5, target: self, selector: #selector(requestMessageList), userInfo: nil, repeats: true)
//            RunLoop.main.add(self.messageTimer!, forMode: RunLoopMode.commonModes)
//        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.messageTimer?.invalidate()
        self.messageTimer = nil
        
        // 显示导航栏
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // 添加下拉刷新
    func createRefresh() -> Void {
        var imageArray : [UIImage] = [UIImage]()
        for i in 0 ..< 6 {
            let imageName : String = String (format: "BorrowMoney%d", i)
            
            let image : UIImage = UIImage (named: imageName)!
            imageArray.append(image)
        }
        
        self.homeTableView?.mj_header = MJRefreshGifHeader(refreshingBlock: { () -> Void in
            self.homeTableView?.mj_header.endRefreshing()
            // 获取首页广告信息
            self.requestBannerInfo()
            
            // 获取热门贷款信息
            self.requestHotLoanInfo()
            
            // 请求消息数据
            self.requestMessageList()
        })
        
        var imageArray2 : [UIImage] = [UIImage]()
        let image2 : UIImage = UIImage (named: "Money")!
        imageArray2.append(image2)
        
        let header : MJRefreshGifHeader = self.homeTableView?.mj_header as! MJRefreshGifHeader
        header.setImages(imageArray2, for: MJRefreshState.idle)
        header.setImages(imageArray, for: MJRefreshState.pulling)
        header.setImages(imageArray, for: MJRefreshState.refreshing)
        header.lastUpdatedTimeLabel.isHidden = true
    }
    
    
    // 创建界面
    func createUI() -> Void {
        // 主界面
        let tableView :UITableView  = UITableView.init(frame: CGRect (x: 0, y: 64 + (30 * HEIGHT_SCALE), width: SCREEN_WIDTH, height: SCREEN_HEIGHT - (64 + (30 * HEIGHT_SCALE)) - 44), style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = MAIN_COLOR
        tableView.separatorStyle = .none
        tableView.register(LoanBrandCell.self, forCellReuseIdentifier: "loanBrand")
        self.homeTableView = tableView
        self.view .addSubview(self.homeTableView!)

        
        let headerView : UIView = UIView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 280 * HEIGHT_SCALE))
        self.tableHeaderView = headerView
        
        // 产品类别
        let productTypeView : ProductTypeView = ProductTypeView()
        self.productTypeView = productTypeView
        self.tableHeaderView?.addSubview(self.productTypeView!)
        self.productTypeView?.snp.makeConstraints({ (make) in
            make.top.left.right.equalTo(self.tableHeaderView!)
            make.height.equalTo(95 * HEIGHT_SCALE)
        })
        self.productTypeView?.imageBlock = { (index) in
            self.navigationController?.pushViewController(largeLoan(), animated: true)
        }
        
        
        // 滚动图
        let rollPictureView : RollPictureView = RollPictureView()
        self.rollPictureView = rollPictureView
        self.tableHeaderView?.addSubview(self.rollPictureView!)
        self.rollPictureView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self.tableHeaderView!)
            make.top.equalTo((self.productTypeView?.snp.bottom)!)
            make.height.equalTo(95 * HEIGHT_SCALE)
        })
        self.rollPictureView?.rollImageBlock = { (index) in
        
        }
        
        // 固定广告
        let fixedAdverView : FixedAdverView = FixedAdverView()
        self.fixedAdverView = fixedAdverView
        self.tableHeaderView?.addSubview(self.fixedAdverView!)
        self.fixedAdverView?.snp.makeConstraints({ (make) in
            make.right.left.equalTo(self.tableHeaderView!)
            make.top.equalTo((self.rollPictureView?.snp.bottom)!)
            make.height.equalTo(90 * HEIGHT_SCALE)
        })
        self.fixedAdverView?.adverClickBlock = { (url) in
            
        }
        self.homeTableView?.tableHeaderView = self.tableHeaderView
        
        let footerView : UIView = UIView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 40 * HEIGHT_SCALE))
        let moreBtn : UIButton = UIButton (type: UIButtonType.custom)
        moreBtn.setTitle("更多贷款产品>", for: UIControlState.normal)
        moreBtn.titleLabel?.font = UIFont .systemFont(ofSize: 14 * WIDTH_SCALE)
        moreBtn.setTitleColor(NAVIGATION_COLOR, for: UIControlState.normal)
        moreBtn.addTarget(self, action: #selector(moreClick), for: UIControlEvents.touchUpInside)
        footerView.addSubview(moreBtn)
        moreBtn.snp.makeConstraints { (make) in
            make.left.bottom.right.top.equalTo(footerView)
        }
        self.tablefooterView = footerView
        self.homeTableView?.tableFooterView = self.tablefooterView
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.hotArray.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 30 * HEIGHT_SCALE
        }
        return 0.01
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let temphot : HotLoanModel = self.hotArray[indexPath.section] as HotLoanModel
        if (temphot.descriptions?.isEmpty)! {
            return 75 * HEIGHT_SCALE
        } else {
            return 105 * HEIGHT_SCALE
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView : UIView?//
        if section == 0 {
            if headerView == nil {
                headerView = UIView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 30 * HEIGHT_SCALE))
                let imageView : UIImageView = UIImageView()
                imageView.image = UIImage (named: "lineImage.png")
                imageView.contentMode = .center
                headerView?.addSubview(imageView)
                imageView.snp.makeConstraints({ (make) in
                    make.top.bottom.equalTo(headerView!)
                    make.left.equalTo((headerView?.snp.left)!).offset(6 * WIDTH_SCALE)
                    make.width.equalTo(2 * WIDTH_SCALE)
                })
                
                let label : UILabel = UILabel()
                label.text = "热门贷款"
                label.textColor = TEXT_BLACK_COLOR
                label.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
                headerView?.addSubview(label)
                label.snp.makeConstraints({ (make) in
                    make.top.bottom.equalTo(headerView!)
                    make.left.equalTo(imageView.snp.right).offset(5 * WIDTH_SCALE)
                })
            }
        }
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : LoanBrandCell = tableView.dequeueReusableCell(withIdentifier: "loanBrand") as! LoanBrandCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.hotModel = self.hotArray[indexPath.section] as HotLoanModel
        cell.fastLoan?.tag = indexPath.section
        cell.fastLoan?.addTarget(self, action: #selector(fastClick(sender:)), for: UIControlEvents.touchUpInside)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hotLoan : HotLoanModel = self.hotArray[indexPath.section]
        self.navigationController?.pushViewController(loanDetail(hotLoan: hotLoan), animated: true)
    }
    
    
    // 创建自定义导航栏
    func createCustomNavigationView() -> Void {
        let navigationView : CustomNavigationView = CustomNavigationView()
        self.navigationView = navigationView
        self.view.addSubview(self.navigationView!)
        self.navigationView?.snp.makeConstraints({ (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(64 + (30 * HEIGHT_SCALE))
        })
        
        weak var weakSelf = self
        self.navigationView?.navigationBlock = {(tag) in
            // 100消息的点击事件  200搜索的点击事件
            if tag == 100 {
                weakSelf?.navigationController?.pushViewController(messageCenter(), animated: true)
            } else {
                weakSelf?.navigationController?.pushViewController(searchResult(dataDict: (weakSelf?.hotText!)!), animated: true)
            }
        }
    }
    

    override func setUpNavigationView() {
        super.setUpNavigationView()
        self.navigationItem.titleView = NaviBarView() .setUpNaviBarWithTitle(title: "首页");
        self.navigationItem.leftBarButtonItem = nil
        
    }
    
    
    // 更新广告信息
    func updateBannerInfo() -> Void {
        // 数据处理
        var productArray : [BannerModel] = [BannerModel]()
        var rollArray : [BannerModel] = [BannerModel]()
        var fixedArray : [BannerModel] = [BannerModel]()
        for i in 0 ..< self.bannerArray.count {
            let tempBanner : BannerModel = self.bannerArray[i]
            if tempBanner.location == "top_banner_50" {
                rollArray.append(tempBanner)
            } else if tempBanner.location == "loan_type_banner_50" {
                productArray.append(tempBanner)
            } else if tempBanner.location == "loan_left_banner_50" {
                fixedArray.append(tempBanner)
            } else if tempBanner.location == "loan_right_banner_50" {
                fixedArray.append(tempBanner)
                let basicModel : BasicModel = BASICINFO!
                basicModel.lightningLoanUrl = tempBanner.address
                USERDEFAULT.saveCustomObject(customObject: basicModel as NSCoding, key: "basicInfo")
            }
        }
        
        
        // 界面更新
        // 产品类别
        var productHeight : CGFloat = 0.0
        if productArray.count > 0 && productArray.count <= 5  {
            productHeight = 10
            self.productTypeView?.lineView?.isHidden = true
            self.productTypeView?.snp.updateConstraints({ (make) in
                make.height.equalTo(85 * HEIGHT_SCALE)
                
            })
        } else if productArray.count > 5 {
            self.productTypeView?.lineView?.isHidden = false
            self.productTypeView?.snp.updateConstraints({ (make) in
                make.height.equalTo(95 * HEIGHT_SCALE)
            })
        } else {
            productHeight = 95
        }
        
        if productArray.count > 0 {
            self.productTypeView?.updateProductData(dataArray: productArray as NSArray)
        }
        
        
        // 滚动图
        var rollHeight : CGFloat = 0.0
        if rollArray.count > 0 {
            self.rollPictureView?.updateRollImageDate(dateArray: rollArray as NSArray)
        } else {
            rollHeight = 95
        }
        
        
        // 固定广告
        var fixedHeight : CGFloat = 0.0
        if fixedArray.count > 0 {
            self.fixedAdverView?.updateFixedAdverData(dataArray: fixedArray as NSArray)
        } else {
            fixedHeight = 90
        }
        
        // 更新头部的高度
        self.tableHeaderView?.frame = CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: (280 - productHeight - rollHeight - fixedHeight) * HEIGHT_SCALE)
        
        // 更改头部高度后，刷新界面（解决多余的高度仍然显示的问题）
        self.homeTableView?.reloadData()
    }
    
    
    // 更多贷款产品的点击事件
    func moreClick() -> Void {
        // 跳转贷款大全
        APPDELEGATE.tabBarControllerSelectedIndex(index: 1)
    }
    
    
    // 一键申请点击事件
    func fastClick(sender: UIButton) -> Void {
        let hotLoan : HotLoanModel = self.hotArray[sender.tag]
            hotLoan.source = "1"
        if hotLoan.targetType == "APPLY_NOW" {
            // 跳转url
        } else {
            self.navigationController?.pushViewController(loanDetail(hotLoan: hotLoan), animated: true)
        }
    }
    
    
    // 获取首页广告信息
    func requestBannerInfo() -> Void {
        HomePageService.homeInstance.requestBannerInfo(success: { (responseObject) in
            
            let dataArray : NSArray = responseObject as! NSArray
            self.bannerArray = BannerModel.objectArrayWithKeyValuesArray(array: dataArray) as! [BannerModel]
            
            // 更新广告信息
            self.updateBannerInfo()
        }) { (errorInfo) in
            
        }
    }
    
    
    // 获取热门贷款信息
    func requestHotLoanInfo() -> Void {
        HomePageService.homeInstance.requestHotLoanList(success: { (responseObject) in
            let dataArray : NSArray = responseObject as! NSArray
            self.hotArray = HotLoanModel.objectArrayWithKeyValuesArray(array: dataArray) as! [HotLoanModel]
            // 刷新界面
            self.homeTableView?.reloadData()
        }) { (errorInfo) in
            
        }
    }
    
    
    // 请求消息数据
    func requestMessageList() -> Void {
        UserCenterService.userInstance.requestMessageSate(success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            if (dataDict["newMessageCount"] as! Int) > 0 {
                self.navigationView?.messageBtn?.setImage(UIImage (named: "newMessage.png"), for: UIControlState.normal)
            } else {
                self.navigationView?.messageBtn?.setImage(UIImage (named: "message.png"), for: UIControlState.normal)
            }
            
        }) { (errorInfo) in
        }
    }
    
    
    // 最近热搜标签
    func requestHotText() -> Void {
        HomePageService.homeInstance.requestHotKeyText(success: { (responseObject) in
            self.hotText = responseObject as? NSDictionary
        }) { (errorInfo) in
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
