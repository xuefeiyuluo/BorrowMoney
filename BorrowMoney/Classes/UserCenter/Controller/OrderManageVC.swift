//
//  OrderManageVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/15.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class OrderManageUI: NSObject {
    var tableView : UITableView?// 界面
    var dataArray : [OrderManageModel] = [OrderManageModel]()// 数据
    var state : String = ""// "1"未放款  “2”待还款  “”全部
    var pageNo : Int = 1// 当前页数
}


class OrderManageVC: BasicVC, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    var headerView : OrderHeaderView = OrderHeaderView()// 头部view
    var orderScrollView : UIScrollView = UIScrollView()
    var uiArray : [OrderManageUI] = [OrderManageUI]()// ui数组
    var modelSelected : Int = 0// 默认为已选中“未放款”
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建UI
        createUI()
        
        // 设置下拉刷新 上拉加载更多
        setUpRefresh()
    }
    
    
    // 创建UI
    func createUI() -> Void {
        weak var weakSelf = self
        
        self.headerView.backgroundColor = UIColor.white
        self.view.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(40 * HEIGHT_SCALE)
        }
        self.headerView.orderClickBlock = { tag in
            // 滚动到对应界面
            weakSelf?.orderScrollView.setContentOffset(CGPoint (x: CGFloat(tag) * SCREEN_WIDTH, y: 0), animated: true)
        }
        
        self.orderScrollView.contentSize = CGSize.init(width: 3 * SCREEN_WIDTH, height: 0)
        self.orderScrollView.delegate = self
        self.orderScrollView.isPagingEnabled = true
        self.orderScrollView.showsVerticalScrollIndicator = false
        self.orderScrollView.showsHorizontalScrollIndicator = false
        self.orderScrollView.bounces = false
        self.view.addSubview(self.orderScrollView)
        self.orderScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom)
            make.left.right.bottom.equalTo(self.view)
        }
        
        for i in 0 ..< 3 {
            let uiModel : OrderManageUI = OrderManageUI()
            let tableView :UITableView  = UITableView.init(frame: CGRect (x: CGFloat(i) * SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64 - 40 * HEIGHT_SCALE), style: UITableViewStyle.grouped)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.backgroundColor = MAIN_COLOR
            tableView.separatorStyle = .none
            tableView.register(OrderManageCell.self, forCellReuseIdentifier: "orderManage")
            tableView.register(OrderManageCell2.self, forCellReuseIdentifier: "orderManage2")
            self.orderScrollView.addSubview(tableView)
            uiModel.tableView = tableView
            if i == 0 {
                uiModel.state = "1"
            } else if i == 1 {
                uiModel.state = "2"
            } else {
                uiModel.state = ""
            }
            // 添加到ui数组中
            self.uiArray.append(uiModel)
        }
    }
    
    
    // 设置下拉刷新 上拉加载更多
    func setUpRefresh() -> Void {
        for i in 0 ..< self.uiArray.count {
            let model : OrderManageUI = self.uiArray[i]
            
            // 下拉刷新
            var imageArray : [UIImage] = [UIImage]()
            for i in 0 ..< 6 {
                let imageName : String = String (format: "BorrowMoney%d", i)
                
                let image : UIImage = UIImage (named: imageName)!
                imageArray.append(image)
            }
            
            model.tableView?.mj_header = MJRefreshGifHeader(refreshingBlock: { () -> Void in
                model.pageNo = 1
                self.requestOrderManageListData(pageNo: model.pageNo,state:model.state)
            })
            var imageArray2 : [UIImage] = [UIImage]()
            let image2 : UIImage = UIImage (named: "Money")!
            imageArray2.append(image2)
            let header : MJRefreshGifHeader = model.tableView!.mj_header as! MJRefreshGifHeader
            header.setImages(imageArray2, for: MJRefreshState.idle)
            header.setImages(imageArray, for: MJRefreshState.pulling)
            header.setImages(imageArray, for: MJRefreshState.refreshing)
            header.lastUpdatedTimeLabel.isHidden = true
            
            // 上拉加载更多
            model.tableView?.mj_footer = MJRefreshAutoNormalFooter (refreshingBlock: {
                self.requestOrderManageListData(pageNo: model.pageNo,state: model.state)
            })
            let footer : MJRefreshAutoNormalFooter = model.tableView?.mj_footer as! MJRefreshAutoNormalFooter
            footer.setTitle("接小二努力加载产品中...", for: .idle)
            footer.setTitle("接小二努力加载产品中...", for: .refreshing)
            footer.setTitle("已经到了我的底线", for: .noMoreData)
            
            // 刚进入就刷新
            if i == 0 {
                // 获取未放款的数据
                model.tableView?.mj_header.beginRefreshing()
            }
        }
    }
    
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        let orderUI : OrderManageUI = self.uiArray[self.modelSelected]
        return orderUI.dataArray.count
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
        let orderUI : OrderManageUI = self.uiArray[self.modelSelected]
        let orderModel : OrderManageModel = orderUI.dataArray[indexPath.section]
        if orderModel.cellSate == "2" {
            return 130 * HEIGHT_SCALE
        } else {
            return 100 * HEIGHT_SCALE
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderUI : OrderManageUI = self.uiArray[self.modelSelected]
        let orderModel : OrderManageModel = orderUI.dataArray[indexPath.section]
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
        let orderUI : OrderManageUI = self.uiArray[self.modelSelected]
        let orderModel : OrderManageModel = orderUI.dataArray[indexPath.section]
        self.navigationController?.pushViewController(orderDetail(orderModel: orderModel), animated: true)
    }
    
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.orderScrollView {
            let index : Int = Int(scrollView.contentOffset.x / SCREEN_WIDTH)
            let offset : Float = Float(scrollView.contentOffset.x / SCREEN_WIDTH)
//            XPrint("index = \(index)+++++ offect = \(offset)")
            if Float(index) == offset {
                self.modelSelected = index
                let orderUI : OrderManageUI = self.uiArray[self.modelSelected]
                if orderUI.dataArray.count > 0 {
                    orderUI.tableView?.reloadData()
                } else {
                    // 请求数据
                    orderUI.tableView?.mj_header.beginRefreshing()
                }
                
                // 改变头部按钮的状态
                self.headerView.changeBtnStates(tag: index)
            }
        }
    }
    
    override func setUpNavigationView() {
        super.setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "订单管理")
    }

    
    // state状态为“6”或“7”时 跳转 账单详情
    func operationClick2(sender : UIButton) -> Void {
        let orderUI : OrderManageUI = self.uiArray[self.modelSelected]
        let orderModel : OrderManageModel = orderUI.dataArray[sender.tag]
        let loanModel : LoanManageData = LoanManageData()
        loanModel.loanType = orderModel.loanType
        loanModel.recordId = orderModel.orderId
        
        // 账单详情
        self.navigationController?.pushViewController(billDetail(model: loanModel), animated: true)
    }
    
    
    // cell的btn的点击事件
    func operationClick(sender : UIButton) -> Void {
        let orderUI : OrderManageUI = self.uiArray[self.modelSelected]
        let orderModel : OrderManageModel = orderUI.dataArray[sender.tag]
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
                if (BASICINFO?.lightningLoanUrl != nil && !self.isEmptyAndNil(str: (BASICINFO?.lightningLoanUrl)!)){
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
    
    
    // 订单管理列表数据
    func requestOrderManageListData(pageNo : Int,state : String) -> Void {
        UserCenterService.userInstance.requestOrderManageList(state: state, pageNo: String(pageNo), success: { (responseObject) in
            let tempArray : NSArray = responseObject as! NSArray
            let modelArray : [OrderManageModel] = OrderManageModel.objectArrayWithKeyValuesArray(array: tempArray) as! [OrderManageModel]
            let orderUI : OrderManageUI = self.uiArray[self.modelSelected]
            if orderUI.state == state {
                // 取消上拉 下拉动画
                orderUI.tableView?.mj_header.endRefreshing()
                orderUI.tableView?.mj_footer.endRefreshing()
                
                if orderUI.pageNo == 1 {
                    orderUI.dataArray.removeAll()
                }
                
                if modelArray.count < 10 {
                    orderUI.tableView?.mj_footer.endRefreshingWithNoMoreData()
                }
                
                orderUI.dataArray += modelArray
                orderUI.pageNo += 1
                
                // 刷新界面
                orderUI.tableView?.reloadData()
            }
        }) { (error) in
            let orderUI : OrderManageUI = self.uiArray[self.modelSelected]
            // 取消上拉 下拉动画
            orderUI.tableView?.mj_header.endRefreshing()
            orderUI.tableView?.mj_footer.endRefreshing()
        }
    }
    
}

