//
//  BillDetailVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/29.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class BillDetailVC: BasicVC, UITableViewDelegate, UITableViewDataSource {
    var headerView : BillDetailHeaderView = BillDetailHeaderView()// 头部信息
    var detailTableView : UITableView?// 账单详情界面
    var loanModel : LoanManageData?//
    var detailModel : BillDetailModel = BillDetailModel()// 账单详情数据
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建ui
        createUI()
        
        // 设置下拉刷新
        setUpRefresh()
    }
    
    
    // 设置下拉刷新
    func setUpRefresh() -> Void {
        // 下拉刷新
        var imageArray : [UIImage] = [UIImage]()
        for i in 0 ..< 6 {
            let imageName : String = String (format: "BorrowMoney%d", i)
            
            let image : UIImage = UIImage (named: imageName)!
            imageArray.append(image)
        }
        
        self.detailTableView!.mj_header = MJRefreshGifHeader(refreshingBlock: { () -> Void in
            self.requestBillDetailDate()
        })
        var imageArray2 : [UIImage] = [UIImage]()
        let image2 : UIImage = UIImage (named: "Money")!
        imageArray2.append(image2)
        let header : MJRefreshGifHeader = self.detailTableView!.mj_header as! MJRefreshGifHeader
        header.setImages(imageArray2, for: MJRefreshState.idle)
        header.setImages(imageArray, for: MJRefreshState.pulling)
        header.setImages(imageArray, for: MJRefreshState.refreshing)
        header.lastUpdatedTimeLabel.isHidden = true
        
        // 刚进来就请求数据
        self.detailTableView?.mj_header.beginRefreshing()
    }
    
    
    // 创建ui
    func createUI() -> Void {
        
        // 账单详情详情列表
        let tableView :UITableView  = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = MAIN_COLOR
        tableView.separatorStyle = .none
        tableView.register(PlanViewCell.self, forCellReuseIdentifier: "planCell")
        self.detailTableView = tableView
        self.view.addSubview(self.detailTableView!)
        self.detailTableView?.snp.makeConstraints({ (make) in
            make.top.left.right.bottom.equalTo(self.view)
        })
        
        weak var weakSelf = self
        self.headerView.backgroundColor = UIColor.white
        self.headerView.frame = CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 160 * HEIGHT_SCALE)
        self.detailTableView?.tableHeaderView = self.headerView
        // 设为已还的回调
        self.headerView.repaidBlock = { (ids) in
            weakSelf?.requestMakeRepaid(ids: ids)
        }
    }
    
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.detailModel.planList.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40 * HEIGHT_SCALE
        } else {
            return 0.01 * HEIGHT_SCALE
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createSectionHeaderView()
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PlanViewCell = tableView.dequeueReusableCell(withIdentifier: "planCell") as! PlanViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor.white
        } else {
            cell.contentView.backgroundColor = UIColor().colorWithHexString(hex: "fafafa")
        }
        cell.planModel = self.detailModel.planList[indexPath.row] as PlanModel
        return cell
    }
    
    
    func createSectionHeaderView() -> UIView {
        let headerView : UIView = UIView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 40 * HEIGHT_SCALE))
        headerView.backgroundColor = UIColor().colorWithHexString(hex: "f4fbfc")
        
        // 期数/总期数
        let termLabel : UILabel = UILabel()
        termLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        termLabel.textColor = TEXT_SECOND_COLOR
        termLabel.text = "期数/总期数"
        headerView.addSubview(termLabel)
        termLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(headerView)
            make.left.equalTo(headerView.snp.left).offset(15 * WIDTH_SCALE)
            make.width.equalTo((SCREEN_WIDTH - 30 * WIDTH_SCALE) / 4)
        }
        
        // 还款金额
        let amountLabel : UILabel = UILabel()
        amountLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        amountLabel.textColor = TEXT_SECOND_COLOR
        amountLabel.text = "还款金额(元)"
        headerView.addSubview(amountLabel)
        amountLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(headerView)
            make.left.equalTo(termLabel.snp.right)
            make.width.equalTo((SCREEN_WIDTH - 30 * WIDTH_SCALE) / 4)
        }
        
        // 还款日
        let dateLabel : UILabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        dateLabel.textColor = TEXT_SECOND_COLOR
        dateLabel.text = "还款日"
        dateLabel.textAlignment = NSTextAlignment.center
        headerView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(headerView)
            make.left.equalTo(amountLabel.snp.right)
            make.width.equalTo(((SCREEN_WIDTH - 30 * WIDTH_SCALE) / 2) / 5 * 3)
        }
        
        // 还款情况
        let stateLabel : UILabel = UILabel()
        stateLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        stateLabel.textColor = TEXT_SECOND_COLOR
        stateLabel.text = "还款情况"
        stateLabel.textAlignment = NSTextAlignment.right
        headerView.addSubview(stateLabel)
        stateLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(headerView)
            make.right.equalTo(headerView.snp.right).offset(-15 * WIDTH_SCALE)
            make.width.equalTo(((SCREEN_WIDTH - 30 * WIDTH_SCALE) / 2) / 5 * 2)
        }
        
        return headerView
    }
    
    
    // 滚动到还款的列
    func scrollToRepaymentList() -> Void
    {
        var row : Int = 0
        DispatchQueue.global().async {
            for i in 0 ..< self.detailModel.planList.count {
                let model : PlanModel = self.detailModel.planList[i]
                if model.status == "1" || model.status == "4" {
                    row = i
                    break
                }
            }
            
            // 主线程
            DispatchQueue.main.async {
                let scrollIndexPath : IndexPath = IndexPath (row: row, section: 0)
                self.detailTableView?.scrollToRow(at: scrollIndexPath, at: UITableViewScrollPosition.middle, animated: true)
            }
        }
    }
    
    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "账单详情");
    }
    
    
    // 获取账单详情
    func requestBillDetailDate() -> Void {
        UserCenterService.userInstance.requestBillDetailData(loanId: (self.loanModel?.recordId)!, loanType: (self.loanModel?.loanType)!, success: { (responseObject) in
            self.detailTableView?.mj_header.endRefreshing()
            
            let tempDict : NSDictionary = responseObject as! NSDictionary
            
            self.detailModel = BillDetailModel.objectWithKeyValues(dict: tempDict) as! BillDetailModel
            
            // 刷新界面
            self.detailTableView?.reloadData()
            self.headerView.updateHeaderView(detailModel: self.detailModel)
            // 滚动到还款的列
            self.scrollToRepaymentList()
        }) { (errorInfo) in
            self.detailTableView?.mj_header.endRefreshing()
        }
    }
    
    
    // 设为已还
    func requestMakeRepaid(ids : String) -> Void {
        UserCenterService.userInstance.requestBillMakeRepaid(ids: ids, success: { (responseObject) in
            // 获取账单详情
            self.requestBillDetailDate()
        }) { (errorInfo) in
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
