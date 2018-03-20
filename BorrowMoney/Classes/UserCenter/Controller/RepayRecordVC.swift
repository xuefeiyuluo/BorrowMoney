//
//  RepayRecordVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/29.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class RepayRecordVC: BasicVC, UITableViewDelegate, UITableViewDataSource {
    var repayRecomView : RepayRecomView = RepayRecomView()// 推荐（无数据）数据界面
    var recordTableView : UITableView?// 还款记录列表
    var recordArray : [OrderManageModel] = [OrderManageModel]()// 数据
    var pageNo : Int = 1// 当前页数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建UI
        createUI()
        
        // 设置下拉刷新 上拉加载更多
        setUpRefresh()
    }

    
    // 创建UI
    func createUI() -> Void {
        // 推荐列表
        self.repayRecomView.backgroundColor = MAIN_COLOR
        self.repayRecomView.isHidden = true
        self.view.addSubview(self.repayRecomView)
        self.repayRecomView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.view)
        }

        // 点击列表的回调
        self.repayRecomView.recommendDetail = { (loanModel : HotLoanModel) in
            self.navigationController?.pushViewController(loanDetail(hotLoan:loanModel), animated: true)
        }
        // “一键申请”的回调
        self.repayRecomView.recommendFast = { (loanModel : HotLoanModel) in

        }
        
        
        let tableView :UITableView  = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = MAIN_COLOR
        tableView.separatorStyle = .none
        tableView.register(OrderManageCell.self, forCellReuseIdentifier: "orderManage")
        tableView.register(OrderManageCell2.self, forCellReuseIdentifier: "orderManage2")
        self.recordTableView = tableView
        self.view.addSubview(self.recordTableView!)
        self.recordTableView!.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.view)
        }
    }
    
    
    // 设置下拉刷新 上拉加载更多
    func setUpRefresh() -> Void {
            
        // 下拉刷新
        var imageArray : [UIImage] = [UIImage]()
        for i in 0 ..< 6 {
            let imageName : String = String (format: "BorrowMoney%d", i)
            
            let image : UIImage = UIImage (named: imageName)!
            imageArray.append(image)
        }
        
        self.recordTableView!.mj_header = MJRefreshGifHeader(refreshingBlock: { () -> Void in
            self.pageNo = 1;
            self.requestRecordListData()
        })
        var imageArray2 : [UIImage] = [UIImage]()
        let image2 : UIImage = UIImage (named: "Money")!
        imageArray2.append(image2)
        let header : MJRefreshGifHeader = self.recordTableView!.mj_header as! MJRefreshGifHeader
        header.setImages(imageArray2, for: MJRefreshState.idle)
        header.setImages(imageArray, for: MJRefreshState.pulling)
        header.setImages(imageArray, for: MJRefreshState.refreshing)
        header.lastUpdatedTimeLabel.isHidden = true
        
        // 上拉加载更多
        self.recordTableView!.mj_footer = MJRefreshAutoNormalFooter (refreshingBlock: {
            self.requestRecordListData()
        })
        let footer : MJRefreshAutoNormalFooter = self.recordTableView!.mj_footer as! MJRefreshAutoNormalFooter
        footer.setTitle("接小二努力加载产品中...", for: .idle)
        footer.setTitle("接小二努力加载产品中...", for: .refreshing)
        footer.setTitle("已经到了我的底线", for: .noMoreData)
        
        // 刚进入就请求数据
        self.recordTableView?.mj_header.beginRefreshing()
    }
    
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.recordArray.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let orderModel : OrderManageModel = self.recordArray[indexPath.section]
        if orderModel.cellSate == "2" {
            return 130 * HEIGHT_SCALE
        } else {
            return 100 * HEIGHT_SCALE
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderModel : OrderManageModel = self.recordArray[indexPath.section]
        if orderModel.cellSate == "2" {
            let cell : OrderManageCell2 = tableView.dequeueReusableCell(withIdentifier: "orderManage2") as! OrderManageCell2
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.orderModel = orderModel
            cell.operationBtn.tag = indexPath.section
            cell.operationBtn.addTarget(self, action: #selector(operationClick2(sender:)), for: UIControlEvents.touchUpInside)
            return cell
        } else {
            let cell : OrderManageCell = tableView.dequeueReusableCell(withIdentifier: "orderManage") as! OrderManageCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.orderModel = orderModel
            cell.operationBtn.tag = indexPath.section
            cell.operationBtn.addTarget(self, action: #selector(operationClick(sender:)), for: UIControlEvents.touchUpInside)
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderModel : OrderManageModel = self.recordArray[indexPath.section]
        self.navigationController?.pushViewController(orderDetail(orderModel: orderModel), animated: true)
    }
    
    
    // state状态为“6”或“7”时 跳转 账单详情
    func operationClick2(sender : UIButton) -> Void {
        let orderModel : OrderManageModel = self.recordArray[sender.tag]
        let loanModel : LoanManageData = LoanManageData()
        loanModel.loanType = orderModel.loanType
        loanModel.recordId = orderModel.orderId

        // 账单详情
        self.navigationController?.pushViewController(billDetail(model: loanModel), animated: true)
    }
    
    
    
    // cell的btn的点击事件
    func operationClick(sender : UIButton) -> Void {
        let orderModel : OrderManageModel = self.recordArray[sender.tag]
        if sender.titleLabel?.text ==  "去还款" {
            let loanModel : LoanManageData = LoanManageData()
            loanModel.loanType = orderModel.loanType
            loanModel.recordId = orderModel.orderId

            // 账单详情
            self.navigationController?.pushViewController(billDetail(model: loanModel), animated: true)
        } else if sender.titleLabel?.text ==  "再贷一笔" {
            // 贷款详情
            let loanMode : HotLoanModel = HotLoanModel()
            loanMode.loan_id = orderModel.loanId
            loanMode.name = orderModel.loanName
            loanMode.channelName = orderModel.loanChannelName
            loanMode.source = "8"
            self.navigationController?.pushViewController(loanDetail(hotLoan:loanMode), animated: true)
        } else if sender.titleLabel?.text ==  "签约提现" {
            let loanOrder : LoanOrderModel = LoanOrderModel()
            loanOrder.channelName = orderModel.loanChannelName
            loanOrder.channel_id = orderModel.loanChannelId
            loanOrder.application_id = orderModel.loanOrderId
            loanOrder.loan_id = orderModel.loanId
            self.navigationController?.pushViewController(loanResult(loanModel: loanOrder), animated: true)
        } else if sender.titleLabel?.text ==  "查看其它产品" {
            if orderModel.loanType == "API" {
                if (BASICINFO?.lightningLoanUrl != nil && !(BASICINFO?.lightningLoanUrl?.isEmpty)!){
                    self.navigationController?.pushViewController(userCenterWebViewWithUrl(url: (BASICINFO?.lightningLoanUrl)!), animated: true)
                } else {
                    // 贷款大全
                    APPDELEGATE.tabBarControllerSelectedIndex(index: 1)
                    self.comeBack()
                }
            } else {
                APPDELEGATE.tabBarControllerSelectedIndex(index: 1)
                self.comeBack()
            }
        }
    }
    
    
    
    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "还款记录");
    }

    
    
    // 订单管理列表数据
    func requestRecordListData() -> Void {
        UserCenterService.userInstance.requestOrderManageList(state: "3", pageNo: String (format: "%i",self.pageNo), success: { (responseObject) in
            let tempArray : NSArray = responseObject as! NSArray
            let modelArray : [OrderManageModel] = OrderManageModel.objectArrayWithKeyValuesArray(array: tempArray) as! [OrderManageModel]
            // 取消上拉 下拉动画
            self.recordTableView?.mj_header.endRefreshing()
            self.recordTableView?.mj_footer.endRefreshing()
            
            if self.pageNo == 1 {
                self.recordArray.removeAll()
            }
            
            if modelArray.count < 10 {
                self.recordTableView?.mj_footer.endRefreshingWithNoMoreData()
            }
            
            self.recordArray += modelArray
            
            if self.recordArray.count > 0 {
                self.repayRecomView.isHidden = true
            } else {
                // 数据请求推荐列表
                self.repayRecomView.requestRecommendListData()
                self.repayRecomView.isHidden = false
            }
            
            self.pageNo += 1
            
            // 刷新界面
            self.recordTableView?.reloadData()
            
        }) { (error) in
            // 取消上拉 下拉动画
            self.recordTableView?.mj_header.endRefreshing()
            self.recordTableView?.mj_footer.endRefreshing()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
