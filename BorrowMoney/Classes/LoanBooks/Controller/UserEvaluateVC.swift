//
//  UserEvaluateVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/12.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class UserEvaluateVC: BasicVC, UITableViewDataSource, UITableViewDelegate {
    var loanDetailModel : LoanDetailModel?// 贷款详情
    var evaluateTableView : UITableView?// 用户评价列表
    var evaluateArray : [EvaluateModel] = [EvaluateModel]()// 用户评论的数据
    var pageNo : Int = 1;// 当前页 默认为1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建UI
        createUI()
        
        // 添加下拉刷新 上拉加载更多
        setUpRefresh()
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
        
        self.evaluateTableView?.mj_header = MJRefreshGifHeader(refreshingBlock: { () -> Void in
            self.pageNo = 1
            self.requestEvaluatteListData()
        })
        var imageArray2 : [UIImage] = [UIImage]()
        let image2 : UIImage = UIImage (named: "Money")!
        imageArray2.append(image2)
        let header : MJRefreshGifHeader = self.evaluateTableView!.mj_header as! MJRefreshGifHeader
        header.setImages(imageArray2, for: MJRefreshState.idle)
        header.setImages(imageArray, for: MJRefreshState.pulling)
        header.setImages(imageArray, for: MJRefreshState.refreshing)
        header.lastUpdatedTimeLabel.isHidden = true
        
        // 上拉加载更多
        self.evaluateTableView?.mj_footer = MJRefreshAutoNormalFooter (refreshingBlock: {
            self.requestEvaluatteListData()
        })
        let footer : MJRefreshAutoNormalFooter = self.evaluateTableView!.mj_footer as! MJRefreshAutoNormalFooter
        footer.setTitle("接小二努力加载产品中...", for: .idle)
        footer.setTitle("接小二努力加载产品中...", for: .refreshing)
        footer.setTitle("没有没有更多数据了", for: .noMoreData)
        
        // 刚进入就刷新
        self.evaluateTableView?.mj_header.beginRefreshing()
    }
    
    
    // 创建UI
    func createUI() -> Void {
        // 用户评价列表
        let tableView :UITableView  = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = MAIN_COLOR
        tableView.separatorStyle = .none
        tableView.register(LoanEvaluateCell.self, forCellReuseIdentifier: "evaluateCell")// 评价cellView
        self.evaluateTableView = tableView
        self.view.addSubview(self.evaluateTableView!)
        self.evaluateTableView?.snp.makeConstraints({ (make) in
            make.top.left.right.bottom.equalTo(self.view)
        })
    }
    
    
    // MARK: UITableViewDataSource, UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.evaluateArray.count
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
        let evaluateModel : EvaluateModel = self.evaluateArray[indexPath.row]
        return 95 * HEIGHT_SCALE + evaluateModel.contentHeight
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : LoanEvaluateCell = tableView.dequeueReusableCell(withIdentifier: "evaluateCell") as! LoanEvaluateCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.evluateModel = self.evaluateArray[indexPath.row]
        return cell
    }
    
    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "用户评价");
    }
    
    
    // 获取用户评价数据
    func requestEvaluatteListData() -> Void {
        LoanBooksService.loanInstance.requestEvaluateList(productId: (self.loanDetailModel?.product_id)!, pageNo: self.pageNo.stringValue(), success: { (responseObject) in
            // 取消上拉 下拉动画
            self.evaluateTableView?.mj_header.endRefreshing()
            self.evaluateTableView?.mj_footer.endRefreshing()
            
            let tempDict : NSDictionary = responseObject as! NSDictionary
            let evaluateModel : LoanEvaluateModel = LoanEvaluateModel.objectWithKeyValues(dict: tempDict) as! LoanEvaluateModel
            if self.pageNo == 1 {
                self.evaluateArray.removeAll()
            }
            
            if evaluateModel.commentList.count < 10 {
                self.evaluateTableView?.mj_footer.endRefreshingWithNoMoreData()
            }
            
            self.evaluateArray += evaluateModel.commentList
            self.pageNo += 1
            
            // 刷新数据
            self.evaluateTableView?.reloadData()
        }) { (errorInfo) in
            // 取消上拉 下拉动画
            self.evaluateTableView?.mj_header.endRefreshing()
            self.evaluateTableView?.mj_footer.endRefreshing()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
