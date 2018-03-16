//
//  OrderDetailVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/6.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class OrderDetailVC: BasicVC, UITableViewDelegate, UITableViewDataSource {
    var orderModel : OrderManageModel?// 订单列表模型
    var detailTableView : UITableView?// 订单详情界面
    var orderDetail : OrderDetailModel = OrderDetailModel()// 订单详情数据
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 获取订单详情
        requestOrderDetailInfo()
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建UI
        createUI()

    }


    // 创建UI
    func createUI() -> Void {
        // 订单详情列表
        let tableView :UITableView  = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = MAIN_COLOR
        tableView.separatorStyle = .none
        tableView.register(OrderDetailTitleCell.self, forCellReuseIdentifier: "titleCell")
        tableView.register(OrderDetailSateCell.self, forCellReuseIdentifier: "sateCell")
        tableView.register(OrderDetailInfoCell.self, forCellReuseIdentifier: "infoCell")
        self.detailTableView = tableView
        self.view.addSubview(self.detailTableView!)
        self.detailTableView?.snp.makeConstraints({ (make) in
            make.top.left.right.bottom.equalTo(self.view)
        })
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 || section == 2  {
            return 1
        } else {
//            if self.orderDetail.planList.count > 0 {
//                return self.orderDetail.planList.count
//            }
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 || section == 2 || section == 3 {
            return 30 * HEIGHT_SCALE
        } else {
            if self.orderDetail.planList.count > 0 {
                return 70 * HEIGHT_SCALE
            }
        }
        return 0.01
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            if self.orderDetail.orderDesc.isEmpty {
                return 10 * HEIGHT_SCALE
            } else {
                let size : CGSize = self.sizeWithText(text: self.orderDetail.orderDesc, font: UIFont.systemFont(ofSize: 12 * WIDTH_SCALE), maxSize: CGSize.init(width: SCREEN_WIDTH - 30 * WIDTH_SCALE, height: CGFloat(MAXFLOAT)))
                return size.height + 25 * HEIGHT_SCALE
            }
        } else if section == 2 {
            if self.orderDetail.status == "3" && CGFloat((self.orderDetail.loanAmount as NSString).floatValue) >= 10000 {
                return 30 * HEIGHT_SCALE
            } else {
                return 10 * HEIGHT_SCALE
            }
            
        }
        return 10 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView : UIView = UIView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 30 * HEIGHT_SCALE))
            headerView.backgroundColor = UIColor.white
            let label : UILabel = UILabel()
            label.text = "订单状态"
            label.textColor = LINE_COLOR3
            label.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
            headerView.addSubview(label)
            label.snp.makeConstraints({ (make) in
                make.bottom.top.equalTo(headerView)
                make.left.equalTo(headerView.snp.left).offset(15 * WIDTH_SCALE)
            })
            
            let lineView : UIView = UIView()
            lineView.backgroundColor = UIColor().colorWithHexString(hex: "d0d0d0")
            headerView.addSubview(lineView)
            lineView.snp.makeConstraints { (make) in
                make.left.bottom.right.equalTo(headerView)
                make.height.equalTo(1 * HEIGHT_SCALE)
            }
            return headerView
        } else if section == 2 {
            let headerView : UIView = UIView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 30 * HEIGHT_SCALE))
            headerView.backgroundColor = UIColor.white
            let label : UILabel = UILabel()
            label.text = "详细信息"
            label.textColor = LINE_COLOR3
            label.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
            headerView.addSubview(label)
            label.snp.makeConstraints({ (make) in
                make.bottom.top.equalTo(headerView)
                make.left.equalTo(headerView.snp.left).offset(15 * WIDTH_SCALE)
            })
            let evaluateBtn : UIButton = UIButton (type: UIButtonType.custom)
            evaluateBtn.setTitleColor(NAVIGATION_COLOR, for: UIControlState.normal)
            evaluateBtn.addTarget(self, action: #selector(evaluateClick(sender:)), for: UIControlEvents.touchUpInside)
            evaluateBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
            headerView.addSubview(evaluateBtn)
            evaluateBtn.snp.makeConstraints({ (make) in
                make.top.bottom.equalTo(headerView)
                make.right.equalTo(headerView.snp.right).offset(-15 * WIDTH_SCALE)
            })
            
            let lineView1 : UIView = UIView()
            lineView1.backgroundColor = NAVIGATION_COLOR
            headerView.addSubview(lineView1)
            
            // 3审核失败
            if self.orderDetail.status == "3" {
                if self.orderDetail.loanChannelTel.isEmpty {
                    evaluateBtn.isHidden = true
                    lineView1.isHidden = true
                } else {
                    evaluateBtn.isHidden = false
                    lineView1.isHidden = false
                    evaluateBtn.setTitle(String (format: "联系机构:%@>", self.orderDetail.loanChannelTel), for: UIControlState.normal)
                    evaluateBtn.tag = 300
                    lineView1.snp.makeConstraints { (make) in
                        make.left.right.equalTo(evaluateBtn)
                        make.top.equalTo(evaluateBtn.snp.centerY).offset(9 * HEIGHT_SCALE)
                        make.height.equalTo(1 * HEIGHT_SCALE)
                    }
                }
            } else {
                lineView1.isHidden = true
                if self.orderDetail.hasComment.isEmpty {
                    evaluateBtn.isHidden = true
                } else {
                    evaluateBtn.isHidden = false
                    evaluateBtn.setTitle("我要评价>", for: UIControlState.normal)
                    evaluateBtn.tag = 400
                }
            }
            
            let lineView : UIView = UIView()
            lineView.backgroundColor = UIColor().colorWithHexString(hex: "d0d0d0")
            headerView.addSubview(lineView)
            lineView.snp.makeConstraints { (make) in
                make.left.bottom.right.equalTo(headerView)
                make.height.equalTo(1 * HEIGHT_SCALE)
            }
            return headerView
        } else if section == 3 {
            if self.orderDetail.planList.count > 0 {
                return self.createPlanHeaderView()
            } else if (self.orderDetail.planList.count > 0) {
                return self.createRecommendHeaderView()
            } else {
                return nil
            }
        }
        else {
            return nil
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            if self.orderDetail.orderDesc.isEmpty {
                return nil
            } else {
                let size : CGSize = self.sizeWithText(text: self.orderDetail.orderDesc, font: UIFont.systemFont(ofSize: 12 * WIDTH_SCALE), maxSize: CGSize.init(width: SCREEN_WIDTH - 30 * WIDTH_SCALE, height: CGFloat(MAXFLOAT)))
                let footerView : UIView = UIView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: size.height + 25 * HEIGHT_SCALE))
                
                let view : UIView = UIView()
                view.backgroundColor = UIColor.white
                footerView.addSubview(view)
                view.snp.makeConstraints({ (make) in
                    make.left.top.right.equalTo(footerView)
                    make.height.equalTo(size.height + 15 * HEIGHT_SCALE)
                })
                
                let label : UILabel = UILabel()
                label.text = self.orderDetail.orderDesc
                label.numberOfLines = 0
                if size.height > 15 * HEIGHT_SCALE {
                    label.textAlignment = NSTextAlignment.left
                } else {
                    label.textAlignment = NSTextAlignment.center
                }
                label.textColor = LINE_COLOR3
                label.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
                view.addSubview(label)
                label.snp.makeConstraints({ (make) in
                    make.bottom.top.equalTo(view)
                    make.right.equalTo(view.snp.right).offset(-15 * WIDTH_SCALE)
                    make.left.equalTo(view.snp.left).offset(15 * WIDTH_SCALE)
                })
                
                let lineView : UIView = UIView()
                lineView.backgroundColor = UIColor().colorWithHexString(hex: "d0d0d0")
                view.addSubview(lineView)
                lineView.snp.makeConstraints { (make) in
                    make.left.bottom.right.equalTo(view)
                    make.height.equalTo(1 * HEIGHT_SCALE)
                }
                return footerView
            }
        } else if section == 2 {
            if self.orderDetail.status == "3" && CGFloat((self.orderDetail.loanAmount as NSString).floatValue) >= 10000 {
                let footerView : UIView = UIView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 30 * HEIGHT_SCALE))
                let label : UILabel = UILabel()
                label.text = "联系信贷经理办理"
                label.textColor = NAVIGATION_COLOR
                label.textAlignment = NSTextAlignment.center
                label.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
                footerView.addSubview(label)
                label.snp.makeConstraints({ (make) in
                    make.centerX.equalTo(footerView)
                    make.top.equalTo(10 * WIDTH_SCALE)
                })
                
                let lineView : UIView = UIView()
                lineView.backgroundColor = NAVIGATION_COLOR
                footerView.addSubview(lineView)
                lineView.snp.makeConstraints { (make) in
                    make.top.equalTo(label.snp.bottom).offset(1 * HEIGHT_SCALE)
                    make.width.equalTo(label.snp.width)
                    make.centerX.equalTo(footerView)
                    make.height.equalTo(1 * HEIGHT_SCALE)
                }
                
                let tapClick : UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(infoFooterClick))
                footerView.addGestureRecognizer(tapClick)
                
                return footerView
            } else {
                return nil
            }
        }
        return nil
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60 * HEIGHT_SCALE
        } else if indexPath.section == 1 {
            return 65 * HEIGHT_SCALE
        } else if indexPath.section == 2 {
            var sectionHeight : CGFloat = 0.0
            self.orderDetail.memberCard = "电视剧是打开"
            // 会员服务
            if !self.orderDetail.memberCard.isEmpty {
                sectionHeight = 15 + 10
            }
            self.orderDetail.protocols.removeAll()
            // 协议列表
            let model1 : ProtocolModel = ProtocolModel()
            model1.contract_name = "合同协议书"
            model1.url = "http://www.baidu.com"
            let model2 : ProtocolModel = ProtocolModel()
            model2.contract_name = "借款合同协议书"
            model2.url = "http://www.jianshu.com"
            let model3 : ProtocolModel = ProtocolModel()
            model3.contract_name = "结婚合同协议书"
            model3.url = "http://www.cnblogs.com"
            let model4 : ProtocolModel = ProtocolModel()
            model4.contract_name = "离婚合同协议书"
            model4.url = "http://www.apple.com"
            self.orderDetail.protocols.append(model1)
            self.orderDetail.protocols.append(model2)
            self.orderDetail.protocols.append(model3)
            self.orderDetail.protocols.append(model4)
            if self.orderDetail.protocols.count > 0 {
                let protocolStr : NSMutableString = "查看协议:"
                for i in 0 ..< self.orderDetail.protocols.count {
                    let model : ProtocolModel = self.orderDetail.protocols[i]
                    protocolStr.appendFormat("《%@》",model.contract_name)
                }
                let size : CGSize = self.sizeWithText(text: protocolStr as String, font: UIFont.systemFont(ofSize: 12 * WIDTH_SCALE), maxSize: CGSize.init(width: SCREEN_WIDTH - 25 * WIDTH_SCALE, height: CGFloat(MAXFLOAT)))
                sectionHeight = sectionHeight + size.height + 10
                // 如果会员服务与协议都有  则增加一个行间距
                if !self.orderDetail.memberCard.isEmpty {
                    sectionHeight = sectionHeight + 10
                }
            }
            return (60 + sectionHeight) * HEIGHT_SCALE
        }
        return 100 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell : OrderDetailTitleCell = tableView.dequeueReusableCell(withIdentifier: "titleCell") as! OrderDetailTitleCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.orderDetail = self.orderDetail
            return cell
        } else if indexPath.section == 1 {
            let cell : OrderDetailSateCell = tableView.dequeueReusableCell(withIdentifier: "sateCell") as! OrderDetailSateCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.orderDetail = self.orderDetail
            cell.operationBtn.addTarget(self, action: #selector(operationClick(sender:)), for: UIControlEvents.touchUpInside)
            return cell
        } else if indexPath.section == 2 {
            let cell : OrderDetailInfoCell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! OrderDetailInfoCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.orderDetail = self.orderDetail
            weak var weakSelf = self
            cell.protocolBlock = {(url) in
                weakSelf?.navigationController?.pushViewController(userCenterWebViewWithUrl(url: url), animated: true)
            }
            return cell
        }
        
        let cell : OrderDetailInfoCell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! OrderDetailInfoCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    
    // 创建还款列表的头部View
    func createPlanHeaderView() -> UIView {
        let headerView : UIView = UIView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 70 * HEIGHT_SCALE))
        let promptLabel : UILabel = UILabel()
        promptLabel.textColor = LINE_COLOR3
        promptLabel.text = String (format: "账单详情(%@)", self.orderDetail.tips);
        promptLabel.font = UIFont.systemFont(ofSize: 12 * WIDTH_SCALE)
        headerView.addSubview(promptLabel)
        promptLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerView.snp.left).offset(15 * WIDTH_SCALE)
            make.height.equalTo(29 * HEIGHT_SCALE)
            make.right.equalTo(headerView.snp.right).offset(-15 * WIDTH_SCALE)
            make.top.equalTo(headerView)
        }
        
        let lineView1 : UIView = UIView()
        lineView1.backgroundColor = UIColor().colorWithHexString(hex: "d0d0d0")
        headerView.addSubview(lineView1)
        lineView1.snp.makeConstraints { (make) in
            make.left.right.equalTo(headerView)
            make.top.equalTo(promptLabel.snp.bottom)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        let titleView : UIView = UIView()
        titleView.backgroundColor = UIColor().colorWithHexString(hex: "f4fbfc")
        headerView.addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.left.right.equalTo(headerView)
            make.top.equalTo(lineView1.snp.bottom)
            make.bottom.equalTo(headerView.snp.bottom).offset(-1 * HEIGHT_SCALE)
        }
        
        // 期数/总期数
//        let termLabel : UILabel = UILabel()
//        termLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
//        termLabel.textColor = TEXT_SECOND_COLOR
        
        
        
        
        
        // 还款金额
        
        // 还款日
        
        // 还款情况
        
        
        
        let lineView2 : UIView = UIView()
        lineView2.backgroundColor = UIColor().colorWithHexString(hex: "d0d0d0")
        headerView.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.left.right.equalTo(headerView)
            make.top.equalTo(titleView.snp.bottom)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        return headerView
    }
    
    
    // 创建推荐列表的头部View
    func createRecommendHeaderView() -> UIView {
        let headerView : UIView = UIView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 30 * HEIGHT_SCALE))
        // 为您推荐的图片
        let imageView : UIImageView = UIImageView()
        imageView.image = UIImage (named: "recommendIcon")
        imageView.contentMode = UIViewContentMode.center
        headerView.addSubview(imageView)
        imageView.snp.makeConstraints({ (make) in
            make.top.bottom.centerX.equalTo(headerView)
            make.width.equalTo(200 * WIDTH_SCALE)
        })
        return headerView
    }
    
    
    // 评价的点击事件
    func evaluateClick(sender: UIButton) -> Void {
        XPrint("评价的点击事件")
    }
    
    
    // 联系信贷经理的点击事件
    func infoFooterClick() -> Void {
        XPrint("联系信贷经理")
    }
    
    
    // 订单状态按钮的操作
    func operationClick(sender : UIButton) -> Void {
        if sender.titleLabel?.text == "一键还款" || sender.titleLabel?.text == "去还款" {
            let loanManageData : LoanManageData = LoanManageData()
            loanManageData.loanType = self.orderDetail.loanType;
            loanManageData.recordId = self.orderDetail.orderId
            // 账单详情界面
            self.navigationController?.pushViewController(billDetail(model: loanManageData), animated: true)
        } else if sender.titleLabel?.text == "再贷一笔" {
            // 贷款详情
            let loanMode : HotLoanModel = HotLoanModel()
            loanMode.loan_id = self.orderDetail.loanId
            loanMode.source = "5"
            self.navigationController?.pushViewController(loanDetail(hotLoan:loanMode), animated: true)
        } else if sender.titleLabel?.text == "签约提现" {
            let loanOrder : LoanOrderModel = LoanOrderModel()
            loanOrder.channelName = self.orderDetail.loanChannelName
            loanOrder.channel_id = self.orderDetail.loanChannelId
            loanOrder.application_id = self.orderDetail.loanOrderId
            loanOrder.loan_id = self.orderDetail.loanId
            self.navigationController?.pushViewController(loanResult(loanModel: loanOrder), animated: true)
        } else if sender.titleLabel?.text == "查看其它产品" {
            if self.orderDetail.loanType == "API" {
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
    
    
    override func setUpNavigationView() {
        super.setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "订单详情")
    }
    
    
    // 获取订单详情
    func requestOrderDetailInfo() -> Void {
        UserCenterService.userInstance.requestOrderDetailInfo(orderId: (self.orderModel?.orderId)!, loanType: (self.orderModel?.loanType)!, success: { (responseObject) in
            
            let tempDict : NSDictionary = responseObject as! NSDictionary
            
            self.orderDetail = (OrderDetailModel.objectWithKeyValues(dict: tempDict) as? OrderDetailModel)!
            
            // 获取推荐列表
            if self.orderDetail.planList.count == 0 {
                self.requestRecommendListData()
            }
            
            // 刷新界面
            self.detailTableView?.reloadData()
        }) { (error) in
        }
    }
    
    
    // 获取推荐列表
    func requestRecommendListData() -> Void {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
