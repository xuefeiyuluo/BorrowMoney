//
//  RepaidAlertView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/20.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias RepaidAlertBlock = (String) -> Void
class RepaidAlertView: BasicView, UITableViewDelegate, UITableViewDataSource {
    var backBtn : UIButton = UIButton()// 背景按钮
    var alertView : UIView = UIView()// 弹框View
    var repaidTableView : UITableView?// 账单列表
    var repaidBtn : UIButton = UIButton()// 确认还款
    var promptLabel : UILabel = UILabel()// 提示文字
    var repaiArray : [PlanModel] = [PlanModel]()// 数据源
    var repaidBlock : RepaidAlertBlock?// 确认还款回调
    var alertHeight : CGFloat = 0.0// 弹框高度
    var selectedIds : String = ""// 贷款期数的id
    
    
    // 创建UI
    override func createUI() {
        super.createUI()
        
        // 背景按钮
        self.backBtn.addTarget(self, action: #selector(removeAlertView), for: UIControlEvents.touchUpInside)
        self.backBtn.frame = self.bounds
        self.addSubview(self.backBtn)
        
        // 弹框
        self.alertView.layer.cornerRadius = 3 * WIDTH_SCALE
        self.alertView.layer.masksToBounds = true
        self.alertView.backgroundColor = UIColor.white
        self.addSubview(self.alertView)
        
        // 账单列表
        let tableView :UITableView  = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.backgroundColor = MAIN_COLOR
        tableView.separatorStyle = .none
        tableView.register(RepaidViewCell.self, forCellReuseIdentifier: "repaidCell")
        self.repaidTableView = tableView
        self.addSubview(self.repaidTableView!)
        
        // 确认还款按钮
        self.repaidBtn.setTitle("确认还款", for: UIControlState.normal)
        self.repaidBtn.backgroundColor = NAVIGATION_COLOR
        self.repaidBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17 * WIDTH_SCALE)
        self.repaidBtn.layer.cornerRadius = 5 * WIDTH_SCALE
        self.repaidBtn.layer.masksToBounds = true
        self.repaidBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.repaidBtn.addTarget(self, action: #selector(repaidClick), for: UIControlEvents.touchUpInside)
        self.addSubview(self.repaidBtn)
        
        // 提示文字
        self.promptLabel.text = "您可以选择将本期，或多期设为已还"
        self.promptLabel.textColor = UIColor().colorWithHexString(hex: "777777")
        self.promptLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        self.promptLabel.textAlignment = NSTextAlignment.center
        self.addSubview(self.promptLabel)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backBtn.frame = self.bounds
        self.backBtn.backgroundColor = UIColor.init(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 0.9)
        
        // 弹框
        self.alertView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(10 * WIDTH_SCALE)
            make.right.equalTo(self.snp.right).offset(-10 * WIDTH_SCALE)
            make.centerY.equalTo(self)
            make.height.equalTo(self.alertHeight)
        }
        
        
        // 账单列表
        self.repaidTableView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self.alertView)
            make.top.equalTo(self.alertView.snp.top).offset(3 * HEIGHT_SCALE)
            make.height.equalTo(((self.repaiArray.count > 5 ? 5 * 27 * HEIGHT_SCALE : CGFloat(self.repaiArray.count) * 27) + 35)  * HEIGHT_SCALE)
        })
        
        // 确认还款按钮
        self.repaidBtn.snp.makeConstraints { (make) in
            make.top.equalTo((self.repaidTableView?.snp.bottom)!).offset(37 * HEIGHT_SCALE)
            make.left.equalTo(self.alertView.snp.left).offset(20 * WIDTH_SCALE)
            make.right.equalTo(self.alertView.snp.right).offset(-20 * WIDTH_SCALE)
            make.height.equalTo(40 * HEIGHT_SCALE)
        }
        
        // 提示文字
        self.promptLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.alertView)
            make.top.equalTo(self.repaidBtn.snp.bottom).offset(10 * HEIGHT_SCALE)
            make.height.equalTo(15 * HEIGHT_SCALE)
        }
        
    }
    
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repaiArray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 35 * HEIGHT_SCALE
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
        return 27 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : RepaidViewCell = tableView.dequeueReusableCell(withIdentifier: "repaidCell") as! RepaidViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.repaidImage.tag = indexPath.row
        cell.repaidImage.addTarget(self, action: #selector(planClick(sender:)), for: UIControlEvents.touchUpInside)
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor.white
        } else {
            cell.contentView.backgroundColor = UIColor().colorWithHexString(hex: "fafafa")
        }
        cell.planModel = self.repaiArray[indexPath.row] as PlanModel
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedLoanRepaidRow(indexPath: indexPath)
    }
    
    
    // 创建Section头部View
    func createSectionHeaderView() -> UIView {
        let headerView : UIView = UIView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH - 20 * WIDTH_SCALE, height: 35 * HEIGHT_SCALE))
        headerView.backgroundColor = UIColor().colorWithHexString(hex: "f4fbfc")
        headerView.layer.masksToBounds = true
        
        // 期数/总期数
        let termText : UIButton = UIButton (type: UIButtonType.custom)
        termText.titleLabel?.font = UIFont.systemFont(ofSize: 10 * WIDTH_SCALE)
        termText.setTitleColor(TEXT_SECOND_COLOR, for: UIControlState.normal)
        termText.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        termText.titleEdgeInsets = UIEdgeInsetsMake(0, 10 * WIDTH_SCALE, 0, 0)
        termText.setTitle("期数/总期数", for: UIControlState.normal)
        headerView.addSubview(termText)
        termText.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(headerView)
            make.width.equalTo((SCREEN_WIDTH - 20 * WIDTH_SCALE) / 5)
        }
        
        let lineView1 : UIView = UIView()
        lineView1.backgroundColor = UIColor().colorWithHexString(hex: "AAAAAA")
        termText.addSubview(lineView1)
        lineView1.snp.makeConstraints { (make) in
            make.right.equalTo(termText)
            make.top.equalTo(termText.snp.top).offset(5 * HEIGHT_SCALE)
            make.bottom.equalTo(termText.snp.bottom).offset(-5 * HEIGHT_SCALE)
            make.width.equalTo(1 * WIDTH_SCALE)
        }
        
        
        // 还款金额
        let amountText : UIButton = UIButton (type: UIButtonType.custom)
        amountText.titleLabel?.font = UIFont.systemFont(ofSize: 10 * WIDTH_SCALE)
        amountText.setTitleColor(TEXT_SECOND_COLOR, for: UIControlState.normal)
        amountText.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        amountText.titleEdgeInsets = UIEdgeInsetsMake(0, 5 * WIDTH_SCALE, 0, 0)
        amountText.setTitle("还款金额(元)", for: UIControlState.normal)
        headerView.addSubview(amountText)
        amountText.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(headerView)
            make.left.equalTo(termText.snp.right)
            make.width.equalTo((SCREEN_WIDTH - 20 * WIDTH_SCALE) / 5)
        }

        let lineView2 : UIView = UIView()
        lineView2.backgroundColor = UIColor().colorWithHexString(hex: "AAAAAA")
        amountText.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.right.equalTo(amountText)
            make.top.equalTo(amountText.snp.top).offset(5 * HEIGHT_SCALE)
            make.bottom.equalTo(amountText.snp.bottom).offset(-5 * HEIGHT_SCALE)
            make.width.equalTo(1 * WIDTH_SCALE)
        }
        
        
        // 还款日
        let dateLabel : UILabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 10 * WIDTH_SCALE)
        dateLabel.textColor = TEXT_SECOND_COLOR
        dateLabel.text = "还款日"
        dateLabel.textAlignment = NSTextAlignment.center
        headerView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(headerView)
            make.left.equalTo(amountText.snp.right)
            make.width.equalTo(((SCREEN_WIDTH - 20 * WIDTH_SCALE) / 25) * 6)
        }
        let lineView3 : UIView = UIView()
        lineView3.backgroundColor = UIColor().colorWithHexString(hex: "AAAAAA")
        amountText.addSubview(lineView3)
        lineView3.snp.makeConstraints { (make) in
            make.right.equalTo(dateLabel)
            make.top.equalTo(dateLabel.snp.top).offset(5 * HEIGHT_SCALE)
            make.bottom.equalTo(dateLabel.snp.bottom).offset(-5 * HEIGHT_SCALE)
            make.width.equalTo(1 * WIDTH_SCALE)
        }
        
        
        // 还款情况
        let stateLabel : UILabel = UILabel()
        stateLabel.font = UIFont.systemFont(ofSize: 10 * WIDTH_SCALE)
        stateLabel.textColor = TEXT_SECOND_COLOR
        stateLabel.textAlignment = NSTextAlignment.center
        stateLabel.text = "还款情况"
        headerView.addSubview(stateLabel)
        stateLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(headerView)
            make.left.equalTo(dateLabel.snp.right)
            make.width.equalTo(((SCREEN_WIDTH - 20 * WIDTH_SCALE) / 25) * 4.5)
        }
        let lineView4 : UIView = UIView()
        lineView4.backgroundColor = UIColor().colorWithHexString(hex: "AAAAAA")
        stateLabel.addSubview(lineView4)
        lineView4.snp.makeConstraints { (make) in
            make.right.equalTo(stateLabel)
            make.top.equalTo(stateLabel.snp.top).offset(5 * HEIGHT_SCALE)
            make.bottom.equalTo(stateLabel.snp.bottom).offset(-5 * HEIGHT_SCALE)
            make.width.equalTo(1 * WIDTH_SCALE)
        }
        
        // 全选按钮
        let allBtn : UIButton = UIButton (type: UIButtonType.custom)
        allBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10 * WIDTH_SCALE)
        allBtn.setTitleColor(UIColor().colorWithHexString(hex: "777777"), for: UIControlState.normal)
        allBtn.layer.cornerRadius = 1.5 * WIDTH_SCALE
        allBtn.layer.borderColor = UIColor().colorWithHexString(hex: "AAAAAA").cgColor
        allBtn.layer.borderWidth = 1 * WIDTH_SCALE
        allBtn.layer.masksToBounds = true
        allBtn.setTitle("全选", for: UIControlState.normal)
        allBtn.addTarget(self, action: #selector(allClick), for: UIControlEvents.touchUpInside)
        headerView.addSubview(allBtn)
        allBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerView)
            make.height.equalTo(21 * HEIGHT_SCALE)
            make.right.equalTo(headerView.snp.right).offset(-10 * WIDTH_SCALE)
            make.left.equalTo(stateLabel.snp.right).offset(10 * WIDTH_SCALE)
        }
        
        return headerView
    }
    
    
    // 确认还款的点击事件
    func repaidClick() -> Void
    {
        if self.selectedIds.isEmpty {
            for model : PlanModel in self.repaiArray {
                if model.selectedId {
                    self.selectedIds = self.selectedIds.appendingFormat("%@,",model.planId)
                }
            }
        }
        
        self.selectedIds = self.selectedIds.substringInRange(0...self.selectedIds.count - 2)
        
        if self.repaidBlock != nil {
            self.repaidBlock!(self.selectedIds)
        }
    }
    
    
    // 全部选择按钮
    func allClick() -> Void
    {
        var allSelected : Bool = false
        for model : PlanModel in self.repaiArray {
            if model.selectedId {
                allSelected = true
            } else {
                allSelected = false
                break
            }
        }
        
        self.selectedIds = ""
        for model : PlanModel in self.repaiArray {
            if allSelected {
                model.selectedId = false
            } else {
                model.selectedId = true
                self.selectedIds = self.selectedIds.appendingFormat("%@,", model.planId)
            }
        }
        
        // 刷新数据
        self.repaidTableView?.reloadData()
    }
    
    
    // 选择按钮
    func planClick(sender : UIButton) -> Void {
        let indexPath : IndexPath = IndexPath (row: sender.tag, section: 0)
        self.selectedLoanRepaidRow(indexPath: indexPath)
    }
    
    
    // 单个选中处理逻辑
    func selectedLoanRepaidRow(indexPath : IndexPath) -> Void {
        let planModel : PlanModel = self.repaiArray[indexPath.row]
        if planModel.selectedId {
            planModel.selectedId = false
            self.selectedIds = ""
            for model : PlanModel in self.repaiArray {
                if model.selectedId {
                    self.selectedIds = self.selectedIds.appendingFormat("%@,",model.planId)
                }
            }
        } else {
            planModel.selectedId = true
            self.selectedIds = self.selectedIds.appendingFormat("%@,",planModel.planId)
        }
        
        // 刷新数据
        self.repaidTableView?.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
    }
    
    
    
    // 移除弹框
    func removeAlertView() -> Void {
        self.removeFromSuperview()
    }
}

