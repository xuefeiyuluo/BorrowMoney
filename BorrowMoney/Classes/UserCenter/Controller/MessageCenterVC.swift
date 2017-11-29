//
//  MessageCenterVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/22.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class MessageCenterVC: BasicVC, UITableViewDelegate, UITableViewDataSource {

    var rightBtn : UIButton?// 全部已读按钮
    var messageTableView : UITableView?
    var currentPage : Int = 1// 第一页
    var messageArray : [AnyObject] = [AnyObject]()// 数据
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建界面
        createUI()
        
        // 添加下拉刷新
        createRefresh()
    }

    
    // 添加下拉刷新,下拉加载更多
    func createRefresh() -> Void {
        
        self.messageTableView?.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            self.messageTableView?.mj_header.endRefreshing()
            self.currentPage = 1
            // 获取消息列表
            self.requestMessageListData()
        })
        
        self.messageTableView?.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { () -> Void in
            self.messageTableView?.mj_footer.endRefreshing()
            // 获取消息列表
            self.requestMessageListData()
        })
        let footer : MJRefreshBackNormalFooter = self.messageTableView?.mj_footer as! MJRefreshBackNormalFooter
        footer.setTitle("已经到了我的底线", for: MJRefreshState.noMoreData)
        // 刚进入就刷新数据
        self.messageTableView?.mj_header.beginRefreshing()
    }
    
    // 创建界面
    func createUI() -> Void {
        // 主界面
        let tableView :UITableView  = UITableView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = MAIN_COLOR
        tableView.separatorStyle = .none
        tableView.register(MessageCenterCell.self, forCellReuseIdentifier: "messageCenter")
        self.messageTableView = tableView
        self.view .addSubview(self.messageTableView!)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messageArray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MessageCenterCell = tableView.dequeueReusableCell(withIdentifier: "messageCenter") as! MessageCenterCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.messageModel = self.messageArray[indexPath.row] as? MessageCenterModel
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let messageModel : MessageCenterModel = self.messageArray[indexPath.row] as! MessageCenterModel
        if messageModel.status == "new" {
            self.selectedMessageState(indexPath: indexPath)
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            self.deleteMessageListData(indexPath: indexPath)
        }
    }
    
    
    // 删除当前的row
    func deleteMessageListData(indexPath: IndexPath) -> Void {
        let messageModel : MessageCenterModel = self.messageArray[indexPath.row] as! MessageCenterModel
        UserCenterService.userInstance.updateMessageData(state: "delete", messageId: messageModel.message_id!, success: { (responseObject) in
            // 删除当前的row
            self.messageArray.remove(at: indexPath.row)
            self.messageTableView!.deleteRows(at: [indexPath], with: UITableViewRowAnimation.none)
        }) { (errorInfo) in
            
        }
    }
    
    
    // 点击更新数据状态
    func selectedMessageState(indexPath: IndexPath) -> Void {
        let messageModel : MessageCenterModel = self.messageArray[indexPath.row] as! MessageCenterModel
        UserCenterService.userInstance.updateMessageData(state: "read", messageId: messageModel.message_id!, success: { (responseObject) in
            messageModel.status = "read"
            
            // 刷新当前的row
            self.messageTableView?.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        }) { (errorInfo) in
            
        }
    }
    
    
    // 获取消息列表
    func requestMessageListData() -> Void {
        
        UserCenterService.userInstance.requestMessageListData(currentPage: NSString (format: "%i", self.currentPage) as String, pageSize: "20", success: { (responseObject) in
            let dataArrary : NSArray = responseObject as! NSArray
            
            // 刚进入或上拉刷新时清除所有数据
            if self.currentPage == 1 {
                self.messageArray.removeAll()
            }
            self.currentPage += 1
            
            // 没有更多数据，取消提示
            if dataArrary.count == 0 {
                self.messageTableView?.mj_footer.endRefreshingWithNoMoreData()
            }
            

            if dataArrary.count > 0 {
                self.messageArray += MessageCenterModel.objectArrayWithKeyValuesArray(array: dataArrary)! as [AnyObject]
                // 刷新界面
                self.messageTableView?.reloadData()
            }
        }) { (errorInfo) in
            
        }
    }
    
    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "消息中心");
        
        let rightBtn = UIButton (type: UIButtonType.custom)
        rightBtn.frame = CGRect (x: 0, y: 0, width: 60 * WIDTH_SCALE, height: 30)
        rightBtn.titleLabel?.font = UIFont .systemFont(ofSize: 13)
        rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20)
        rightBtn .setTitle("全部已读", for: UIControlState.normal)
        rightBtn .addTarget(self, action: #selector(messgaeClick), for: UIControlEvents.touchUpInside)
        rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -25)
        self.rightBtn = rightBtn
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (customView: self.rightBtn!)
    }
    
    
    // 全部已读的点击事件
    func messgaeClick() -> Void {
        for i in 0 ..< self.messageArray.count {
            let model : MessageCenterModel = self.messageArray[i] as! MessageCenterModel
            if !(model.status == "read") {
                model.status = "read"
                UserCenterService.userInstance.allMessageData(success: { (responseObject) in
                    
                }, failure: { (errorInfo) in
                    
                })
            }
        }
        self.rightBtn?.setTitleColor(TEXT_BLACK_COLOR, for: UIControlState.normal)
        self.messageTableView?.reloadData()

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
