//
//  LoanDetailVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/12/2.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class LoanDetailVC: BasicVC, UITableViewDataSource, UITableViewDelegate {
    var hotLoan : HotLoanModel?// 贷款列表界面带过来的值
    var loanBottomView : LoanDetailBottomView = LoanDetailBottomView()// 提交申请View
    var sheetView : BankSheetView = BankSheetView()// 弹框
    var loanDetailTableView : UITableView?//
    var sectionArray : NSArray = NSArray()// 界面结构数组
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建UI
        createUI()

        // 添加下拉刷新
        createRefresh()
    }
    
    
    // 添加下拉刷新
    func createRefresh() -> Void {
        var imageArray : [UIImage] = [UIImage]()
        for i in 0 ..< 6 {
            let imageName : String = String (format: "BorrowMoney%d", i)
            
            let image : UIImage = UIImage (named: imageName)!
            imageArray.append(image)
        }
        
        self.loanDetailTableView?.mj_header = MJRefreshGifHeader(refreshingBlock: { () -> Void in
            // 获取贷款详情
            self.requestLoanDetailInfo()
            self.loanDetailTableView?.mj_header.endRefreshing()
        })
        
        var imageArray2 : [UIImage] = [UIImage]()
        let image2 : UIImage = UIImage (named: "Money")!
        imageArray2.append(image2)
        
        let header : MJRefreshGifHeader = self.loanDetailTableView?.mj_header as! MJRefreshGifHeader
        header.setImages(imageArray2, for: MJRefreshState.idle)
        header.setImages(imageArray, for: MJRefreshState.pulling)
        header.setImages(imageArray, for: MJRefreshState.refreshing)
        header.lastUpdatedTimeLabel.isHidden = true
        
        // 获取信贷员列表
        self.loanDetailTableView?.mj_header.beginRefreshing()
    }
    
    
    // 创建UI
    func createUI() -> Void {
        weak var weakSelf = self
        
        // 创建底部“提交申请”view
        self.view.addSubview(self.loanBottomView)
        self.loanBottomView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self.view)
            make.height.equalTo(55 * HEIGHT_SCALE)
        }
        
        // 接口期限的弹框
        self.sheetView.backgroundColor = UIColor.white
        self.sheetView.frame = CGRect (x:0 , y: SCREEN_HEIGHT - 64, width: SCREEN_WIDTH, height: 200 * HEIGHT_SCALE)
        self.view.addSubview(self.sheetView)
        self.sheetView.bankSheetBlock = { (tag) in
            
        }
        self.sheetView.bankPickBlock = {(model) in
            
        }
        
        
        // 还款管理列表
        let tableView :UITableView  = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = MAIN_COLOR
        tableView.separatorStyle = .none
        tableView.register(LoanDetailAmountCell.self, forCellReuseIdentifier: "amountCell")// 贷款信息View
        tableView.register(LoanDetailConditionCell.self, forCellReuseIdentifier: "conditionCell")// 贷款条件View
        tableView.register(LoanDetailConditionCell.self, forCellReuseIdentifier: "jxrCell")// 借小二亲测View
        tableView.register(LoanDetailSegmentedCell.self, forCellReuseIdentifier: "segmentedCell")// 申请资料/用户评价View
        tableView.register(LoanEvaluateHeaderCell.self, forCellReuseIdentifier: "evaluateHeaderCell")// 评价头部View
        tableView.register(LoanEvaluateCell.self, forCellReuseIdentifier: "evaluateCell")// 评价cellView
        tableView.register(LoanApplicantTypeCell.self, forCellReuseIdentifier: "typeCell")// 申请资料的cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        self.loanDetailTableView = tableView
        self.view.addSubview(self.loanDetailTableView!)
        self.loanDetailTableView?.snp.makeConstraints({ (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(self.loanBottomView.snp.top)
        })
    }
    
    
    // MARK: UITableViewDataSource, UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionArray.count + 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section > 2 {
            return 1
        } else {
            let tempArray : NSArray = self.sectionArray[section] as! NSArray
            return tempArray.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 2 {
            return 45 * HEIGHT_SCALE
        } else {
            return 0.01 * HEIGHT_SCALE
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section > 1 {
            return 0.01 * HEIGHT_SCALE
        } else {
            return 10 * HEIGHT_SCALE
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section > 2 {
            weak var weakSelf = self
            let headerView : LoanApplicantHeaderView = LoanApplicantHeaderView()
            headerView.tag = section - 3
            headerView.frame = CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 45 * HEIGHT_SCALE)
            headerView.headerBlock = { (index) in
                // 刷新界面
                weakSelf?.loanDetailTableView?.reloadData()
            }
            return headerView
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section <= 2 {
            let rowString : String = (self.sectionArray[indexPath.section] as! NSArray)[indexPath.row] as! String
            
            if rowString == "LoanDetailAmount" {
                return 170 * HEIGHT_SCALE
            } else if rowString == "LoanDetailJXR" {
                let str : String = "1、20-40岁\n2、在职员工\n3、工作周期满6个月\n4、20-40岁\n5、在职员工打别介啊阿茶"
                return calculationConditionViewHeight(text: str)
            }  else if rowString == "LoanDetailCondition" {
                let str : String = "1、20-40岁\n2、在职员工\n3、工作周期满6个月\n4、20-40岁\n5、在职员工h女打卡咔擦和女开始\n6、工作周期满6个月"
                return calculationConditionViewHeight(text: str)
            } else if rowString == "LoanDetailSegmented" {
                return 50 * HEIGHT_SCALE
            }
        } else {
            return 144 * HEIGHT_SCALE
        }
        return 44 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        weak var weakSelf = self
        if indexPath.section <= 2 {
            let rowString : String = (self.sectionArray[indexPath.section] as! NSArray)[indexPath.row] as! String
            if rowString == "LoanDetailAmount" {
                let cell : LoanDetailAmountCell = tableView.dequeueReusableCell(withIdentifier: "amountCell") as! LoanDetailAmountCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                // 接口期限回调
                cell.tremsBlock = { () in
                    weakSelf?.sheetView.isHidden = true
                }
                
                // 疑问的回调
                cell.questionBlock = { () in
                    
                }
                return cell
            } else if rowString == "LoanDetailJXR" {
                let cell : LoanDetailConditionCell = tableView.dequeueReusableCell(withIdentifier: "jxrCell") as! LoanDetailConditionCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                let str : String = "1、20-40岁\n2、在职员工\n3、工作周期满6个月\n4、20-40岁\n5、在职员工打别介啊阿茶"
                cell.updateConditionView(title: "接小二亲测：", text: str)
                // 条件显示全部的回调
                cell.conditionBlock = { () in
                    
                }
                return cell
            }  else if rowString == "LoanDetailCondition" {
                let cell : LoanDetailConditionCell = tableView.dequeueReusableCell(withIdentifier: "conditionCell") as! LoanDetailConditionCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                let str : String = "1、20-40岁\n2、在职员工\n3、工作周期满6个月\n4、20-40岁\n5、在职员工h女打卡咔擦和女开始\n6、工作周期满6个月"
                cell.updateConditionView(title: "申请条件：", text: str)
                // 条件显示全部的回调
                cell.conditionBlock = { () in
                    
                }
                return cell
            } else if rowString == "LoanDetailSegmented" {
                let cell : LoanDetailSegmentedCell = tableView.dequeueReusableCell(withIdentifier: "segmentedCell") as! LoanDetailSegmentedCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.loanDetailSegmentBlock = { (tag) in
                    XPrint(tag)
                    // 500申请资料  600用户评价
                    
                    
                }
                return cell
            }
        } else {
//            let cell : LoanApplicantTypeCell = tableView.dequeueReusableCell(withIdentifier: "typeCell") as! LoanApplicantTypeCell
//            cell.selectionStyle = UITableViewCellSelectionStyle.none
//            return cell
            
//            let cell : LoanEvaluateHeaderCell = tableView.dequeueReusableCell(withIdentifier: "evaluateHeaderCell") as! LoanEvaluateHeaderCell
//            cell.selectionStyle = UITableViewCellSelectionStyle.none
//            return cell
            
            
            let cell : LoanEvaluateCell = tableView.dequeueReusableCell(withIdentifier: "evaluateCell") as! LoanEvaluateCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.textLabel?.text = "67890-098765"
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // 计算申请条件与借小二亲测的高度
    func calculationConditionViewHeight(text : String) -> CGFloat {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4 * HEIGHT_SCALE
        let size : CGSize = self.sizeWithAttributeText(text: text, font: UIFont.systemFont(ofSize: 14 * WIDTH_SCALE), maxSize: CGSize.init(width: SCREEN_WIDTH - 60 * WIDTH_SCALE, height: CGFloat(MAXFLOAT)), paragraphStyle: paragraphStyle)
//        XPrint(size.height)
        if size.height < 105 * HEIGHT_SCALE {
            return 35 * HEIGHT_SCALE + size.height + 10 * HEIGHT_SCALE
        } else {
            return 35 * HEIGHT_SCALE + 100 * HEIGHT_SCALE + 35 * HEIGHT_SCALE + 20 * HEIGHT_SCALE
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (self.hotLoan?.backFrom)! {
            // 解决第一个navigation为隐藏时跳页面navigation为显示，返回上一个界面时navigation有一闪而过的现象
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    
    // 初始化数据
    override func initializationData() {
        super.initializationData()
        self.sectionArray = [["LoanDetailAmount"],["LoanDetailJXR","LoanDetailCondition"],["LoanDetailSegmented"]]
    }
    
    
    override func setUpNavigationView() {
        super.setUpNavigationView()
        
        // title “贷款详情”
        self.navigationItem.titleView = NaviBarView() .setUpNaviBarWithTitle(title: String (format: "%@-%@", (hotLoan?.channelName)!,(hotLoan?.name)!));
        
        let rightBtn = UIButton (type: UIButtonType.custom)
        rightBtn.setTitle("贷款攻略", for: UIControlState.normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        rightBtn.setTitleColor(TEXT_LIGHT_COLOR, for:  UIControlState.normal)
        rightBtn.frame = CGRect (x: 0, y: 0, width: 60 * WIDTH_SCALE, height: 30)
        rightBtn .addTarget(self, action: #selector(rightNavClick), for: UIControlEvents.touchUpInside)
        rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20 * WIDTH_SCALE)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (customView: rightBtn)
    }
    
    
    // 贷款攻略的点击事件
    func rightNavClick() -> Void {
        
    }
    
    
    // 获取贷款详情
    func requestLoanDetailInfo() -> Void {
        LoanBooksService.loanInstance.requestLoanDetailInfo(productId: (self.hotLoan?.loan_id)!, rzj: (self.hotLoan?.source)!, success: { (responseObject) in
            // 取消上拉 下拉动画
            self.loanDetailTableView?.mj_header.endRefreshing()
            
            
            
            
            
        }) { (errorInfo) in
            // 取消上拉 下拉动画
            self.loanDetailTableView?.mj_header.endRefreshing()
        }
    }
    
    
    // 获取评价列表
    func requestEvaluateList() -> Void {
        LoanBooksService.loanInstance.requestEvaluateList(productId: (self.hotLoan?.loan_id)!, pageNo: "1", success: { (responseObject) in
            
        }) { (errorInfo) in
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
