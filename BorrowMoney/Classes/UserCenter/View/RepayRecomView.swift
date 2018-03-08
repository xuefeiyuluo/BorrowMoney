//
//  RepayRecomView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/7.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias RecommendDetail = (HotLoanModel) -> Void
typealias RecommendFast = (HotLoanModel) -> Void
class RepayRecomView: BasicView, UITableViewDelegate, UITableViewDataSource {
    var headerView : UIView = UIView()// 头部View
    var headerImage : UIImageView = UIImageView()// 头部图片
    var headerLabel : UILabel = UILabel()// 头部文案
    var recommendTableView : UITableView?// 推荐列表
    var pageNo : Int = 1// 默认为1 当前页数
    var booksArray : [HotLoanModel] = [HotLoanModel]()// 列表数据
    var recommendDetail : RecommendDetail?// 点击列表
    var recommendFast : RecommendFast?// 一键申请
    

    // 创建UI
    override func createUI() {
        super.createUI()
        self.headerView.frame = CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 152 * HEIGHT_SCALE)
        // 头部图片
        self.headerImage.contentMode = UIViewContentMode.center
        self.headerImage.image = UIImage (named: "repayManage.png")
        self.headerView.addSubview(self.headerImage)
        self.headerImage.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.headerView)
            make.height.equalTo(104 * HEIGHT_SCALE)
            make.top.equalTo(self.headerView.snp.top).offset(18 * HEIGHT_SCALE)
        }
        
        // 头部文案
        self.headerLabel.text = "暂无贷款信息，赶紧去申请吧！"
        self.headerLabel.textColor = TEXT_LIGHT_COLOR
        self.headerLabel.font = UIFont.systemFont(ofSize: 14 * WIDTH_SCALE)
        self.headerLabel.textAlignment = NSTextAlignment.center
        self.headerView.addSubview(self.headerLabel)
        self.headerLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.headerView)
            make.top.equalTo(self.headerImage.snp.bottom).offset(10 * HEIGHT_SCALE)
        }
        
        // 推荐列表
        let tableView :UITableView  = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = MAIN_COLOR
        tableView.separatorStyle = .none
        tableView.register(LoanBrandCell.self, forCellReuseIdentifier: "loanBrand")
        self.recommendTableView = tableView
        self.addSubview(self.recommendTableView!)
        self.recommendTableView?.snp.makeConstraints({ (make) in
            make.top.left.right.bottom.equalTo(self)
        })
        self.recommendTableView?.tableHeaderView = self.headerView
        
        // 设置上拉加载更多
        setUpRefresh()
    }
    
    
    // 设置上拉加载更多
    func setUpRefresh() -> Void {
        // 上拉加载更多
        self.recommendTableView?.mj_footer = MJRefreshAutoNormalFooter (refreshingBlock: {
            
        })
        let footer : MJRefreshAutoNormalFooter = self.recommendTableView?.mj_footer as! MJRefreshAutoNormalFooter
        footer.setTitle("接小二努力加载产品中...", for: .idle)
        footer.setTitle("接小二努力加载产品中...", for: .refreshing)
        footer.setTitle("已经到了我的底线", for: .noMoreData)
    }
    
    
    // MARK: UITableViewDataSource, UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.booksArray.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let temphot : HotLoanModel = self.booksArray[indexPath.section] as HotLoanModel
        if self.isEmptyAndNil(str: temphot.descriptions!) {
            return 75 * HEIGHT_SCALE
        } else {
            return 105 * HEIGHT_SCALE
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40 * HEIGHT_SCALE
        }
        return 0.01
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10 * HEIGHT_SCALE
//        return 0.01
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view : UIView = UIView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 40 * HEIGHT_SCALE))
            let imageView : UIImageView = UIImageView()
            imageView.contentMode = UIViewContentMode.center
            imageView.image = UIImage (named: "recommend")
            view.addSubview(imageView)
            imageView.snp.makeConstraints({ (make) in
                make.top.left.bottom.right.equalTo(view)
            })
            return view
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : LoanBrandCell = tableView.dequeueReusableCell(withIdentifier: "loanBrand") as! LoanBrandCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.hotModel = self.booksArray[indexPath.section] as HotLoanModel
        cell.fastLoan?.tag = indexPath.section
        cell.fastLoan?.addTarget(self, action: #selector(fastClick(sender:)), for: UIControlEvents.touchUpInside)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let loanMode : HotLoanModel = self.booksArray[indexPath.section]
        loanMode.source = "3"
        if self.recommendDetail != nil {
            self.recommendDetail!(loanMode)
        }
    }
    
    
    // 一键申请点击事件
    func fastClick(sender: UIButton) -> Void {
        //        let hotLoan : HotLoanModel = self.hotArray[sender.tag]
        //        self.navigationController?.pushViewController(loanDetail(hotLoan: hotLoan), animated: true)
    }
    
    
    // 获取推荐列表
    func requestRecommendListData() -> Void {
        UserCenterService.userInstance.requestRepayRecommendList(pageNo: String(self.pageNo), success: { (responseObject) in
            // 下拉动画
            self.recommendTableView?.mj_footer.endRefreshing()
            
            let tempDict : NSDictionary = responseObject as! NSDictionary
            
            let tempArray : [HotLoanModel] = HotLoanModel.objectArrayWithKeyValuesArray(array: tempDict["recommendationList"] as! NSArray) as! [HotLoanModel]

            if self.pageNo == 1 {
                self.booksArray.removeAll()
            }
            
            if tempArray.count < 10 {
                self.recommendTableView?.mj_footer.endRefreshingWithNoMoreData()
            }
            
            self.booksArray += tempArray
            self.pageNo += 1

            self.recommendTableView?.reloadData()
        }) { (errorInfo) in
            // 取消上拉动画
            self.recommendTableView?.mj_footer.endRefreshing()

        }
    }
}
