//
//  LoanDetailVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/12/2.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

enum SegmentedStateEnum : Int {
    case segmentedRightState
    case segmentedLeftState
}


class LoanDetailVC: BasicVC, UITableViewDataSource, UITableViewDelegate {
    var hotLoan : HotLoanModel?// 贷款列表界面带过来的值
    var loanBottomView : LoanDetailBottomView = LoanDetailBottomView()// 提交申请View
    var tableViewFooterView : LoanDetailFooterView = LoanDetailFooterView()// 列表尾部View
    var loanDetailTableView : UITableView?//
    var sectionArray : NSArray = NSArray()// 界面结构数组
    var loanDetailModel : LoanDetailModel = LoanDetailModel()// 贷款详情数据
    var segmentType : SegmentedStateEnum = SegmentedStateEnum.segmentedLeftState// 默认选择左边
    var evaluateData : LoanEvaluateModel = LoanEvaluateModel()// 用户评论数据
    var rowEvaluateArray : [String] = [String]()// 评价界面的数据结构
    var applicantArray : [ApplicantModel] = [ApplicantModel]()// 申请资料数据
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hotLoan?.backFrom = true
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
            // 获取评价列表
            self.requestEvaluateList()
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
        
        // 创建底部“提交申请”view
        self.view.addSubview(self.loanBottomView)
        self.loanBottomView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self.view)
            make.height.equalTo(55 * HEIGHT_SCALE)
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
        tableView.register(LoanApplicantType1Cell.self, forCellReuseIdentifier: "type1Cell")// 申请资料的cell
        tableView.register(LoanApplicantType2Cell.self, forCellReuseIdentifier: "type2Cell")// 申请资料的cell
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
        if self.segmentType == SegmentedStateEnum.segmentedLeftState {
            return self.sectionArray.count + self.applicantArray.count
        } else {
            return self.sectionArray.count + 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section > 2 {
            if self.segmentType == SegmentedStateEnum.segmentedLeftState {
                let applicantModel : ApplicantModel = self.applicantArray[section - 3]
                if applicantModel.applicantState {
                    return applicantModel.attrList.count
                } else {
                    return 0
                }
            } else {
                return self.rowEvaluateArray.count
            }
        } else {
            let tempArray : NSArray = self.sectionArray[section] as! NSArray
            return tempArray.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 2 {
            if self.segmentType == SegmentedStateEnum.segmentedLeftState {
                return 45 * HEIGHT_SCALE
            } else {
                return 0.01 * HEIGHT_SCALE
            }
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
            if self.segmentType == SegmentedStateEnum.segmentedLeftState {
                weak var weakSelf = self
                let headerView : LoanApplicantHeaderView = LoanApplicantHeaderView()
                let model : ApplicantModel = self.applicantArray[section - 3]
                model.applicantGroup = section - 3
                headerView.applicantModel = model
                headerView.frame = CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 45 * HEIGHT_SCALE)
                
                headerView.headerBlock = { (index) in
                    for i in 0 ..< self.applicantArray.count {
                        let model : ApplicantModel = (weakSelf?.applicantArray[i])!
                        if i == index {
                            model.applicantState = !model.applicantState
                        } else {
                            model.applicantState = false
                        }
                    }
                    
                    // 刷新数据
                    weakSelf?.loanDetailTableView?.reloadData()
                }
                return headerView
            } else {
                return nil
            }
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            let footerView : UIView = UIView()
            footerView.backgroundColor = UIColor.clear
            footerView.frame = CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 10 * HEIGHT_SCALE)

            let lineView : UIView = UIView()
            lineView.backgroundColor = LINE_COLOR2
            footerView.addSubview(lineView)
            lineView.snp.makeConstraints { (make) in
                make.top.left.right.equalTo(footerView)
                make.height.equalTo(1 * HEIGHT_SCALE)
            }
            return footerView
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section <= 2 {
            let rowString : String = (self.sectionArray[indexPath.section] as! NSArray)[indexPath.row] as! String
            if rowString == "LoanDetailAmount" {
                return 170 * HEIGHT_SCALE
            } else if rowString == "LoanDetailJXR" {
                return calculationConditionViewHeight(text: self.loanDetailModel.systemTips,state: self.loanDetailModel.jxrState)
            }  else if rowString == "LoanDetailCondition" {
                return calculationConditionViewHeight(text: self.loanDetailModel.conditions,state: self.loanDetailModel.conditionState)
            } else if rowString == "LoanDetailSegmented" {
                return 50 * HEIGHT_SCALE
            }
        } else {
            if self.segmentType == SegmentedStateEnum.segmentedLeftState {
                let applicantModel : ApplicantModel = self.applicantArray[indexPath.section - 3]
                let regulaModel : ApplyRegulaModel = applicantModel.attrList[indexPath.row]
                if regulaModel.attibute_type == "contact" {
                    return 88 * HEIGHT_SCALE
                } else {
                    return 44 * HEIGHT_SCALE
                }
            } else {
                let rowString : String = self.rowEvaluateArray[indexPath.row]
                if  rowString == "EvaluateTitleRow" {
                    if self.evaluateData.commentTag.count > 0 {
                        return 35 * HEIGHT_SCALE + self.evaluateData.markHeight
                    } else {
                        if self.evaluateData.commentList.count > 0 {
                            return 35 * HEIGHT_SCALE
                        } else {
                            return 50 * HEIGHT_SCALE
                        }
                    }
                } else if  rowString == "EvaluateFooterRow" {
                    return 50 * HEIGHT_SCALE
                } else {
                    // 评价model
                    let evaluateModel : EvaluateModel = self.evaluateData.commentList[indexPath.row - 1] as EvaluateModel
                    return 95 * HEIGHT_SCALE + evaluateModel.contentHeight
                }
            }
        }
        return 44 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        weak var weakSelf = self
        if indexPath.section <= 2 {
            let sectionString : String = (self.sectionArray[indexPath.section] as! NSArray)[indexPath.row] as! String
            if sectionString == "LoanDetailAmount" {
                let cell : LoanDetailAmountCell = tableView.dequeueReusableCell(withIdentifier: "amountCell") as! LoanDetailAmountCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.loanDetail = self.loanDetailModel
                return cell
            } else if sectionString == "LoanDetailJXR" {
                let cell : LoanDetailConditionCell = tableView.dequeueReusableCell(withIdentifier: "jxrCell") as! LoanDetailConditionCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.updateConditionView(title: "接小二亲测：", text: self.loanDetailModel.systemTips,state: self.loanDetailModel.jxrState)
                // 条件显示全部的回调
                cell.conditionBlock = { () in
                    weakSelf?.loanDetailModel.jxrState = !(weakSelf?.loanDetailModel.jxrState)!
                    // 刷新Section1的数据
                    weakSelf?.loanDetailTableView?.reloadSections([1], with: .none)
                }
                return cell
            }  else if sectionString == "LoanDetailCondition" {
                let cell : LoanDetailConditionCell = tableView.dequeueReusableCell(withIdentifier: "conditionCell") as! LoanDetailConditionCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.updateConditionView(title: "申请条件：", text: self.loanDetailModel.conditions,state: self.loanDetailModel.conditionState)
                // 条件显示全部的回调
                cell.conditionBlock = { () in
                    weakSelf?.loanDetailModel.conditionState = !(weakSelf?.loanDetailModel.conditionState)!
                    // 刷新Section1的数据
                    weakSelf?.loanDetailTableView?.reloadSections([1], with: .none)
                }
                return cell
            } else if sectionString == "LoanDetailSegmented" {
                let cell : LoanDetailSegmentedCell = tableView.dequeueReusableCell(withIdentifier: "segmentedCell") as! LoanDetailSegmentedCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                cell.loanDetailSegmentBlock = { (tag) in
                    // 500申请资料  600用户评价
                    if tag == 500 {
                        self.segmentType = SegmentedStateEnum.segmentedLeftState
                    } else {
                        self.segmentType = SegmentedStateEnum.segmentedRightState
                    }
                    // 刷新界面
                    weakSelf?.loanDetailTableView?.reloadData()
                }
                return cell
            }
        } else {
            if self.segmentType == SegmentedStateEnum.segmentedLeftState {
                let applicantModel : ApplicantModel = self.applicantArray[indexPath.section - 3]
                let regulaModel : ApplyRegulaModel = applicantModel.attrList[indexPath.row]
                if regulaModel.attibute_type == "contact" {
                    let cell : LoanApplicantType2Cell = tableView.dequeueReusableCell(withIdentifier: "type2Cell") as! LoanApplicantType2Cell
                    cell.selectionStyle = UITableViewCellSelectionStyle.none
                    cell.regulaModel = regulaModel
                    cell.applicantType2Block = { () in
                        // 登录界面
                        userLogin(successHandler: { () -> (Void) in
                        }) { () -> (Void) in
                        }
                    }
                    return cell
                } else {
                    let cell : LoanApplicantType1Cell = tableView.dequeueReusableCell(withIdentifier: "type1Cell") as! LoanApplicantType1Cell
                    cell.selectionStyle = UITableViewCellSelectionStyle.none
                    cell.regulaModel = regulaModel
                    cell.applicantType1Block = { () in
                        // 登录界面
                        userLogin(successHandler: { () -> (Void) in
                        }) { () -> (Void) in
                        }
                    }
                    return cell
                }
            } else {
                let rowString : String = self.rowEvaluateArray[indexPath.row]
                if rowString == "EvaluateTitleRow" {
                    let cell : LoanEvaluateHeaderCell = tableView.dequeueReusableCell(withIdentifier: "evaluateHeaderCell") as! LoanEvaluateHeaderCell
                    cell.selectionStyle = UITableViewCellSelectionStyle.none
                    if self.evaluateData.commentList.count > 0 {
                        cell.titleView.isHidden = false
                        cell.markView.isHidden = false
                        cell.promptLabel.isHidden = true
                    } else {
                        cell.titleView.isHidden = true
                        cell.markView.isHidden = true
                        cell.promptLabel.isHidden = false
                    }
                    cell.evaluateModel = self.evaluateData
                    return cell
                } else if rowString == "EvaluateFooterRow" {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
                    let allEvaluateBtn : UIButton = UIButton (type: UIButtonType.custom)
                    allEvaluateBtn.setTitle("查看全部评论", for: UIControlState.normal)
                    allEvaluateBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                    allEvaluateBtn.setTitleColor(NAVIGATION_COLOR, for: UIControlState.normal)
                    allEvaluateBtn.layer.borderColor = NAVIGATION_COLOR.cgColor
                    allEvaluateBtn.layer.borderWidth = 1 * WIDTH_SCALE
                    allEvaluateBtn.layer.cornerRadius = 2 * WIDTH_SCALE
                    allEvaluateBtn.layer.masksToBounds = true
                    allEvaluateBtn.addTarget(self, action: #selector(allEvaluateClick), for: UIControlEvents.touchUpInside)
                    cell.contentView.addSubview(allEvaluateBtn)
                    allEvaluateBtn.snp.makeConstraints { (make) in
                        make.centerX.centerY.equalTo(cell.contentView)
                        make.height.equalTo(30 * HEIGHT_SCALE)
                        make.width.equalTo(100 * WIDTH_SCALE)
                    }
                    cell.selectionStyle = .none
                    return cell
                } else {
                    let cell : LoanEvaluateCell = tableView.dequeueReusableCell(withIdentifier: "evaluateCell") as! LoanEvaluateCell
                    cell.selectionStyle = UITableViewCellSelectionStyle.none
                    cell.evluateModel = self.evaluateData.commentList[indexPath.row - 1] as EvaluateModel
                    return cell
                }
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.textLabel?.text = ""
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section > 2 {
            // 登录界面
            userLogin(successHandler: { () -> (Void) in
            }) { () -> (Void) in
            }
            
            let applicantModel : ApplicantModel = self.applicantArray[indexPath.section - 3]
            let regulaModel : ApplyRegulaModel = applicantModel.attrList[indexPath.row]
            
            // 职业
            if regulaModel.attibute_type == "10000" {
                
                // 弹框选择
            } else if regulaModel.attibute_type == "enum" {
                
                // 连续半年缴纳社保
            } else if regulaModel.attibute_type == "bool" {
                
                // 所在城市
            } else if regulaModel.attibute_type == "city" {
                
                // 居住详细地址
            } else if regulaModel.attibute_type == "area" {
                
                // 运营商验证
            } else if regulaModel.attibute_type == "authVerify" {
                
                // 公积金授权
            } else if regulaModel.attibute_type == "publicFund" {
                
                // 银行卡认证
            } else if regulaModel.attibute_type == "quickVerify" {
                
                // 扫描身份证正面
            } else if regulaModel.attibute_type == "idCardFrontOcr" {
                
                // 扫描身份证反面
            } else if regulaModel.attibute_type == "idCardBackOcr" {
                
                // 人脸识别
            } else if regulaModel.attibute_type == "livenessOcr" {
                
                // 淘宝账号
            } else if regulaModel.attibute_type == "tbLoginCookie" {
                
                // 联系人信息
            } else if regulaModel.attibute_type == "contact" {
                
            }
        }
    }
    
    
    // 计算申请条件与借小二亲测的高度
    func calculationConditionViewHeight(text : String,state : Bool) -> CGFloat {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4 * HEIGHT_SCALE
        let size : CGSize = self.sizeWithAttributeText(text: text, font: UIFont.systemFont(ofSize: 14 * WIDTH_SCALE), maxSize: CGSize.init(width: SCREEN_WIDTH - 60 * WIDTH_SCALE, height: CGFloat(MAXFLOAT)), paragraphStyle: paragraphStyle)
//        XPrint(size.height)
        if size.height < 105 * HEIGHT_SCALE {
            return 35 * HEIGHT_SCALE + size.height + 10 * HEIGHT_SCALE
        } else {
            if state {
                return 35 * HEIGHT_SCALE + size.height + 35 * HEIGHT_SCALE + 20 * HEIGHT_SCALE
            } else {
                return 35 * HEIGHT_SCALE + 100 * HEIGHT_SCALE + 35 * HEIGHT_SCALE + 20 * HEIGHT_SCALE
            }
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (self.hotLoan?.backFrom)! {
            // 解决第一个navigation为隐藏时跳页面navigation为显示，返回上一个界面时navigation有一闪而过的现象
//            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    
    // 初始化数据
    override func initializationData() {
        super.initializationData()
        self.sectionArray = [["LoanDetailAmount"],["LoanDetailJXR","LoanDetailCondition"],["LoanDetailSegmented"]]
        self.rowEvaluateArray = ["EvaluateTitleRow"]
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
    
    
    // 查看全部点击事件
    func allEvaluateClick() -> Void {
        self.hotLoan?.backFrom = false
        self.navigationController?.pushViewController(userEvluate(mode: self.loanDetailModel), animated: true)
    }
    
    
    // 获取贷款详情
    func requestLoanDetailInfo() -> Void {
        LoanBooksService.loanInstance.requestLoanDetailInfo(productId: (self.hotLoan?.loan_id)!, rzj: (self.hotLoan?.source)!, success: { (responseObject) in
            // 取消上拉 下拉动画
            self.loanDetailTableView?.mj_header.endRefreshing()
            
            let tempDict : NSDictionary = responseObject as! NSDictionary
            self.loanDetailModel = LoanDetailModel.objectWithKeyValues(dict: tempDict) as! LoanDetailModel
            
            if self.loanDetailModel.systemTips.isEmpty {
                self.sectionArray = [["LoanDetailAmount"],["LoanDetailCondition"],["LoanDetailSegmented"]]
            } else {
                self.sectionArray = [["LoanDetailAmount"],["LoanDetailJXR","LoanDetailCondition"],["LoanDetailSegmented"]]
            }
            
            if ASSERLOGIN! {
                // 获取贷款用户的基本信息
                self.requestUserBaseInfo()
            } else {
                // 未登录申请资料的接口
                self.requestApplicantLoginOut()
            }
            
            // 刷新界面
            self.loanDetailTableView?.reloadData()
        }) { (errorInfo) in
            // 取消上拉 下拉动画
            self.loanDetailTableView?.mj_header.endRefreshing()
        }
    }
    
    
    // 获取评价列表
    func requestEvaluateList() -> Void {
        LoanBooksService.loanInstance.requestEvaluateList(productId: (self.hotLoan?.loan_id)!, pageNo: "1", success: { (responseObject) in
            let tempDict : NSDictionary = responseObject as! NSDictionary
            self.evaluateData = LoanEvaluateModel.objectWithKeyValues(dict: tempDict) as! LoanEvaluateModel
            if self.evaluateData.commentList.count == 0 {
                self.rowEvaluateArray = ["EvaluateTitleRow"]
            } else if self.evaluateData.commentList.count > 3 {
                self.rowEvaluateArray = ["EvaluateTitleRow","EvaluateRow","EvaluateRow","EvaluateRow","EvaluateFooterRow"]
            } else {
                self.rowEvaluateArray = ["EvaluateTitleRow"]
                for _ in 0 ..< self.evaluateData.commentList.count {
                    self.rowEvaluateArray.append("EvaluateRow")
                }
            }
        }) { (errorInfo) in
        }
    }
    
    
    // 获取贷款用户的基本信息
    func requestUserBaseInfo() -> Void {
        LoanBooksService.loanInstance.requestLoanUserBaseInfo(success: { (responseObject) in
            let tempDict : NSDictionary = responseObject as! NSDictionary
            let userInfo : UserModel = USERINFO!
            userInfo.idCard = tempDict.stringForKey(key: "idCard")
            userInfo.mobile = tempDict.stringForKey(key: "mobilePhone")
            userInfo.verify = tempDict.stringForKey(key: "verify").intValue()
            userInfo.name = tempDict.stringForKey(key: "userName")
            USERDEFAULT.saveCustomObject(customObject: userInfo, key: "userInfo")
            // 获取贷款的角色信息
            self.requestLoanRoleInfo()
        }) { (errorInfo) in
            // 获取贷款的角色信息
            self.requestLoanRoleInfo()
        }
    }
    
    
    // 获取贷款的角色信息
    func requestLoanRoleInfo() -> Void {
        LoanBooksService.loanInstance.requestLoanRoleInfo(success: { (responseObject) in
            let tempDict : NSDictionary = responseObject as! NSDictionary
            let userInfo : UserModel = USERINFO!
            userInfo.roleType = tempDict.stringForKey(key: "roleType")
            USERDEFAULT.saveCustomObject(customObject: userInfo, key: "userInfo")
            // 已登录获取申请资料的接口
            self.requestApplicantLoginIn()
        }) { (errorInfo) in
            // 已登录获取申请资料的接口
            self.requestApplicantLoginIn()
        }
    }
    
    
    // 已登录获取申请资料的接口
    func requestApplicantLoginIn() -> Void {
        LoanBooksService.loanInstance.requestApplicantLoginIn(productId: self.loanDetailModel.product_id, success: { (responseObject) in
            let tempArray : NSArray = responseObject as! NSArray
            let modelArray : [ApplicantModel] = ApplicantModel.objectArrayWithKeyValuesArray(array: tempArray) as! [ApplicantModel]
            
            self.applicantListDate(tempArray: modelArray)
        }) { (errorInfo) in
        }
    }
    
    
    // 未登录时申请资料的接口
    func requestApplicantLoginOut() -> Void {
        LoanBooksService.loanInstance.requestApplicantLoginOut(productId: self.loanDetailModel.product_id, success: { (responseObject) in
            let tempArray : NSArray = responseObject as! NSArray
            let modelArray : [ApplicantModel] = ApplicantModel.objectArrayWithKeyValuesArray(array: tempArray) as! [ApplicantModel]
            self.applicantListDate(tempArray: modelArray)
        }) { (errorInfo) in
        }
    }
    
    
    
    func applicantListDate(tempArray : [ApplicantModel]) -> Void {
        // 清除所有数据
        self.applicantArray.removeAll()
        
        for model : ApplicantModel in tempArray {
            if model.attributeId != "10000" {
                self.applicantArray.append(model)
            } else {
                if model.attrList.count > 0 {
                    var tempArray : [ApplyRegulaModel] = [ApplyRegulaModel]()
                    for applyModel : ApplyRegulaModel in model.attrList {
                        if applyModel.attribute_id != "10000" {
                            tempArray.append(applyModel)
                        }
                    }
                    if tempArray.count > 0 {
                        model.attrList = tempArray
                        self.applicantArray.append(model)
                    }
                }
            }
        }
        
        let applicantModel : ApplicantModel = ApplicantModel()
        applicantModel.catName = "基本资料"
        applicantModel.catLogo = "http://jdq-01.oss-cn-hangzhou.aliyuncs.com/img/ICON_basic-info.png"
        applicantModel.verifyAttribute = ""
        
        
        let phoneModel : ApplyRegulaModel = ApplyRegulaModel()
        phoneModel.attribute_name = "手机号"
        if ASSERLOGIN! {
            phoneModel.attibute_type = "none"
            phoneModel.selectValue = (USERINFO?.mobile)!
        } else {
            phoneModel.attibute_type = "string"
            phoneModel.selectValue = ""
        }
        phoneModel.fillAttribute = "must"
        applicantModel.attrList.append(phoneModel)
        
        
        let nameModel : ApplyRegulaModel = ApplyRegulaModel()
        nameModel.attribute_name = "真实姓名"
        if USERINFO?.verify == 1 {
            nameModel.attibute_type = "none"
        } else {
            nameModel.attibute_type = "string"
        }
        nameModel.attribute_id = "name"
        nameModel.selectValue = (USERINFO?.name)!
        nameModel.fillAttribute = "must"
        applicantModel.attrList.append(nameModel)
        
        
        let cardModel : ApplyRegulaModel = ApplyRegulaModel()
        cardModel.attribute_name = "身份证号"
        if USERINFO?.verify == 1 {
            cardModel.attibute_type = "none"
        } else {
            cardModel.attibute_type = "string"
        }
        cardModel.attribute_id = "IdCard"
        cardModel.selectValue = (USERINFO?.idCard)!
        cardModel.fillAttribute = "must"
        applicantModel.attrList.append(cardModel)
        
        
        let occupModel : ApplyRegulaModel = ApplyRegulaModel()
        if ASSERLOGIN! {
            if (USERINFO?.roleType?.isEmpty)! {
                occupModel.selectValue = "工薪族"
            } else {
                occupModel.selectValue = (USERINFO?.roleType)!
            }
        } else {
            occupModel.selectValue = "工薪族"
        }
        occupModel.attribute_name = "职业"
        occupModel.attibute_type = "enum"
        occupModel.attribute_id = "10000"
        occupModel.fillAttribute = "must"
        occupModel.allChoice.adding(["attributeId":"10000","attibuteValue":"工薪族"])
        occupModel.allChoice.adding(["attributeId":"10000","attibuteValue":"企业主"])
        occupModel.allChoice.adding(["attributeId":"10000","attibuteValue":"自由职业者"])
        applicantModel.attrList.append(occupModel)
        
        
        // 将这个添加到数组的第一个位置
        self.applicantArray.insert(applicantModel, at: 0)
        
        // 刷新数据
        self.loanDetailTableView?.reloadData()
        
        let view : UIActionSheet
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
