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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 隐藏导航栏
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建自定义导航栏
        createCustomNavigationView()
        
        // 创建界面
        createUI()
        
        // 添加下拉刷新
        createRefresh()
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
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
            // 获取首页信息
//            self.requestHomeInfo()
            self.homeTableView?.mj_header.endRefreshing()
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
        fixedAdverView.backgroundColor = UIColor.gray
        self.fixedAdverView = fixedAdverView
        self.tableHeaderView?.addSubview(self.fixedAdverView!)
        self.fixedAdverView?.snp.makeConstraints({ (make) in
            make.right.left.equalTo(self.tableHeaderView!)
            make.top.equalTo((self.rollPictureView?.snp.bottom)!)
            make.height.equalTo(90 * HEIGHT_SCALE)
        })
        self.fixedAdverView?.adverClickBlock = { (index) in
            // 300左边的点击事件  400右边的点击事件
            if index == 300 {
                
            } else {
                
            }
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
        return 5
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
        return 100 * HEIGHT_SCALE
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
//        cell.messageModel = self.messageArray[indexPath.row] as? MessageCenterModel
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
        
        self.navigationView?.navigationBlock = {(tag) in
            // 100消息的点击事件  200搜索的点击事件
            if tag == 100 {
                self.navigationController?.pushViewController(messageCenter(), animated: true)
            } else {
                self.navigationController?.pushViewController(searchResult(), animated: true)
            }
        }
    }
    

    override func setUpNavigationView() {
        super.setUpNavigationView()
        self.navigationItem.titleView = NaviBarView() .setUpNaviBarWithTitle(title: "首页");
        self.navigationItem.leftBarButtonItem = nil
    }
    
    
    // 获取首页信息
    func requestHomeInfo() -> Void {
        
    }
    
    
    // 更多贷款产品的点击事件
    func moreClick() -> Void {
        // 跳转贷款大全
        APPDELEGATE.tabBarControllerSelectedIndex(index: 1)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
