//
//  EvaluateVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/17.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class EvaluateVC: BasicVC {
    var loanOrder : LoanOrderModel?//
    var headerView : EvaluateHeaderView = EvaluateHeaderView()// 头部View
    var markView : EvaluateMarkView = EvaluateMarkView()// 标签View
    var submitView : EvaluateSubmitView = EvaluateSubmitView()// 底部View
    var goodArray : [TagModel] = [TagModel]() // 赞数组
    var badArray : [TagModel] = [TagModel]() // 吐槽数组
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建ui
        createUI()
        
        // 获取评价标签
        requestMarkList()
    }

    
    // 创建ui
    func createUI() -> Void {
        weak var weakSelf = self
        
        self.view.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(200 * HEIGHT_SCALE)
        }
        self.headerView.url = self.loanOrder?.logo
        self.headerView.starBlock = { (count) in
            weakSelf?.submitView.updateEvaluateBtnState(evaluateState: true)
        }
    
        self.view.addSubview(self.markView)
        self.markView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.headerView.snp.bottom)
            make.height.equalTo(195 * HEIGHT_SCALE)
        }
        self.markView.evaluateBlock = { (tag) in
            // 0表示赞 1表示吐槽
            if tag == 0 {
                self.markView.updateMarkBtn(tagArray: self.goodArray)
            } else {
                self.markView.updateMarkBtn(tagArray: self.badArray)
            }
        }
        
        self.view.addSubview(self.submitView)
//        self.submitView.backgroundColor = UIColor.purple
        self.submitView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.markView.snp.bottom)
            make.height.equalTo(100 * HEIGHT_SCALE)
        }
    }
    
    
    override func setUpNavigationView() {
        super.setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: String (format: "评价%@", (self.loanOrder?.channelName)!))
    }
    

    // 获取评价标签
    func requestMarkList() -> Void {
        UserCenterService.userInstance.requestEvaluateMarkList(success: { (responseObject) in
            let tempDict : NSDictionary = responseObject as! NSDictionary
            self.goodArray = TagModel.objectArrayWithKeyValuesArray(array: tempDict["goodTagList"] as! NSArray) as! [TagModel]
            self.badArray = TagModel.objectArrayWithKeyValuesArray(array: tempDict["badTagList"] as! NSArray) as! [TagModel]
            
            // 默认显示赞的
            self.markView.updateMarkBtn(tagArray: self.goodArray)
        }) { (error) in
        }
    }
    
    
    // 提交评价信息
    func requestEvaluateSubmit() -> Void {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
