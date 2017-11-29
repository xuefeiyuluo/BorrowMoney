//
//  RepayManageVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/15.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class RepayManageVC: BasicVC, UITableViewDelegate, UITableViewDataSource {
    
    var repayTableView : UITableView?//
    var headerView : RepayManageHeaderView?// 头部View
    var loaoManage : LoanManageModel?// 获取的数据
    var loanArray : NSArray = []// 还款管理列表
    var selectedSection : Int?//


    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建UI
        createUI()
        
        // 添加下拉刷新
        createRefresh()
    }
    
    
    // 添加下拉刷新,下拉加载更多
    func createRefresh() -> Void {
        
        self.repayTableView?.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            self.repayTableView?.mj_header.endRefreshing()
            // 获取还款管理列表
            self.requestRepayManageData()
        })
        
        self.repayTableView?.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { () -> Void in
            self.repayTableView?.mj_footer.endRefreshing()
        })
        let footer : MJRefreshBackNormalFooter = self.repayTableView?.mj_footer as! MJRefreshBackNormalFooter
        footer.setTitle("已经到了我的底线", for: MJRefreshState.noMoreData)
        // 刚进入就刷新数据
        self.repayTableView?.mj_header.beginRefreshing()
    }

    
    // 创建UI
    func createUI() -> Void {
        let tableView :UITableView  = UITableView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = MAIN_COLOR
        tableView.separatorStyle = .none
        tableView.register(RepayManageCell.self, forCellReuseIdentifier: "repayManage")
        self.repayTableView = tableView
        self.view .addSubview(self.repayTableView!)
        
        let headerView : RepayManageHeaderView = RepayManageHeaderView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 95 * HEIGHT_SCALE))
        self.headerView = headerView
        self.repayTableView?.tableHeaderView = self.headerView
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.loanArray.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10 * HEIGHT_SCALE
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model : LoanManageData = self.loanArray[indexPath.section] as! LoanManageData
        var buttomHeight : CGFloat = 0.00
        if model.status == "UPDATING" {
            buttomHeight = 30 * HEIGHT_SCALE;
        }
        if indexPath.section == 1 {
            let model : LoanManageData = self.loanArray[indexPath.section] as! LoanManageData
            model.loanType = "API"
        }
        // 立即还款按钮
        if model.loanType == "API" && model.repaymentType != "NONE" {
            return 227 * HEIGHT_SCALE - buttomHeight
        } else {
            return 177 * HEIGHT_SCALE - buttomHeight
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : RepayManageCell = tableView.dequeueReusableCell(withIdentifier: "repayManage") as! RepayManageCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        if indexPath.section == 1 {
            let model : LoanManageData = self.loanArray[indexPath.section] as! LoanManageData
            model.loanType = "API"
        }
        cell.loanData = self.loanArray[indexPath.section] as? LoanManageData
        cell.repaymentBtn?.tag = indexPath.section
        cell.loanRepaid?.tag = indexPath.section
        cell.bottomBtn?.tag = indexPath.section
        
        cell.repaymentBtn?.addTarget(self, action: #selector(repaymentClick(sender:)), for: UIControlEvents.touchUpInside)
        cell.loanRepaid?.addTarget(self, action: #selector(repaidClick(sender:)), for: UIControlEvents.touchUpInside)
        cell.bottomBtn?.addTarget(self, action: #selector(bottombClick(sender:)), for: UIControlEvents.touchUpInside)
        
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let loanModel : LoanManageData = self.loanArray[indexPath.section] as! LoanManageData
        
        if loanModel.status == "NORMAL_REPAY" || loanModel.status == "HAD_OVERDUED"{
            self.navigationController?.pushViewController(billDetail(model: loanModel), animated: true)
        } else if loanModel.status == "UPDATING" {
            SVProgressHUD.showInfo(withStatus: "数据到入中，请稍后查看")
        } else if loanModel.status == "PASSWORD_ERROR" {
            SVProgressHUD.showInfo(withStatus: "用户名或密码错误")
        }
    }

    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "还款管理");
        
        let rightBtn = UIButton (type: UIButtonType.custom)
        rightBtn.frame = CGRect (x: 0, y: 0, width: 60 * WIDTH_SCALE, height: 30)
        rightBtn.titleLabel?.font = UIFont .systemFont(ofSize: 13)
        rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20)
        rightBtn.setTitle("还款记录", for: UIControlState.normal)
        rightBtn.setTitleColor(LINE_COLOR2, for: UIControlState.normal)
        rightBtn.addTarget(self, action: #selector(repayClick), for: UIControlEvents.touchUpInside)
        rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -25)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (customView:rightBtn)
    }

    
    // 立即还款的点击事件
    func repaymentClick(sender : UIButton) -> Void {
        let loanData : LoanManageData = self.loanArray[sender.tag] as! LoanManageData
        if !loanData.repaymentSate {
            // 跳转h5界面
            if loanData.repaymentType == "HTML" {
                
            } else if loanData.repaymentType == "API" {
                // 发送一个连接
            }
            loanData.repaymentSate = true
            self.repayTableView?.reloadSections([sender.tag], with: UITableViewRowAnimation.none)
        }
    }

    
    // 设为已还的点击事件
    func repaidClick(sender : UIButton) -> Void {
        let loanData : LoanManageData = self.loanArray[sender.tag] as! LoanManageData
        UserCenterService.userInstance.requestMakeRepaids(planId: loanData.planId!, success: { (responseObject) in
            // 获取还款管理数据
            self.requestRepayManageData()
        }) { (errorInfo) in
            
        }
    }

    
    // 刷新图标与重新导入的点击事件
    func bottombClick(sender : UIButton) -> Void {
        self.selectedSection = sender.tag
        let loanData : LoanManageData = self.loanArray[sender.tag] as! LoanManageData
        if loanData.status == "PASSWORD_ERROR" {
            
        } else if loanData.status == "DATA_EXCEPTION" {
            requestFlushStatus(accountId: loanData.accountId!)
        }
        //        if([self.selectedData.status isEqualToString:@"PASSWORD_ERROR"]) {
        //            LoanPlatformDetails *detail = [[LoanPlatformDetails alloc] init];
        //            detail.channelName = self.selectedData.loanChannelName;
        //            detail.logo = self.selectedData.productLogo;
        //            detail.loan_channel_id = self.selectedData.loanChannelId;
        //            detail.entryType = @"3";
        //            [self.navigationController pushViewController:[HTUIControlCenter addAccountControllerWithLoanPlatformDetails:detail accounts:@""] animated:YES];
        //        } else if([self.selectedData.status isEqualToString:@"DATA_EXCEPTION"]) {
        //            // 刷新订单状态
        //            [self requestFlushStatus];
        //        }
    }

    
    //获取刷新订单状态
    func requestFlushStatus(accountId : String) -> Void {
        UserCenterService.userInstance.requestAccountError(accountId: accountId, success: { (responseObject) in
            let loanData : LoanManageData = self.loanArray[self.selectedSection!] as! LoanManageData
            loanData.refreshImageSate = true
            // 刷新当前Section
            self.repayTableView?.reloadSections([self.selectedSection!], with: UITableViewRowAnimation.none)
        }) { (errorInfo) in
            
        }
    }

    
    // 获取还款管理数据
    func requestRepayManageData() -> Void {
        UserCenterService.userInstance.requestRepayManageListData(success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            self.loaoManage = LoanManageModel.objectWithKeyValues(dict: dataDict) as? LoanManageModel
            
            self.loanArray = (self.loaoManage?.loanList)!
            
            self.repayTableView?.mj_footer.endRefreshingWithNoMoreData()
            
            // 界面刷新
            self.repayTableView?.reloadData()
            
        }) { (errorInfo) in
            
        }
    }

    
    // 还款记录点击事件
    func repayClick() -> Void {
        self.navigationController?.pushViewController(repayRecord(), animated: true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
