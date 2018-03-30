//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？
//
//  UserCenterVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/10/12.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit
class User: NSObject {
    var name : String?
    var iphone : String?
}

class UserCenterVC: BasicVC, UITableViewDelegate, UITableViewDataSource {
    static let RowRepaymentManage : String = "RowRepaymentManage"
    static let RowOrderManage : String = "RowOrderManage"
    static let RowLargeAmountView : String = "RowLargeAmountView"
    static let RowUserIconListView : String = "RowUserIconListView"
    static let RowUserSetUp : String = "RowUserSetUp"

    var rightBtn : UIButton?// 导航栏按钮
    var userTableView : UITableView?//
    var sectionArray : NSArray?//
    var loanOrder : LoanOrderModel?//
    var payOrder : LoanProductsModel?//
    var orderManageView : UserCenterCell1?// 订单管理
    var payManageView : UserCenterCell1?// 还款管理
    var headerView : UserCenterHeaderView?// 头部View
    var userCenter : UserCenterModel?//
    var messageTimer : Timer?// 消息的定时器
    
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        self.navigationLine = true
        
        if ASSERLOGIN! {
            // 获取用户基本信息
            requestBaseInfo()
            
            // 请求消息中心数据
            self.requestMessageList()
            
            // 消息中心的定时器
//            createTimer()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建UI
        createUI()
        
        // 添加下拉刷新
        createRefresh()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.messageTimer?.invalidate()
        self.messageTimer = nil
    }
    
    
    // 添加下拉刷新
    func createRefresh() -> Void {
        var imageArray : [UIImage] = [UIImage]()
        for i in 0 ..< 6 {
            let imageName : String = String (format: "BorrowMoney%d", i)
            
            let image : UIImage = UIImage (named: imageName)!
            imageArray.append(image)
        }
        
        self.userTableView?.mj_header = MJRefreshGifHeader(refreshingBlock: { () -> Void in
            // 获取用户基本信息
            self.requestBaseInfo()
            // 请求消息中心数据
            self.requestMessageList()
            
            self.userTableView?.mj_header.endRefreshing()
        })
        
        var imageArray2 : [UIImage] = [UIImage]()
        let image2 : UIImage = UIImage (named: "Money")!
        imageArray2.append(image2)
        
        let header : MJRefreshGifHeader = self.userTableView?.mj_header as! MJRefreshGifHeader
        header.setImages(imageArray2, for: MJRefreshState.idle)
        header.setImages(imageArray, for: MJRefreshState.pulling)
        header.setImages(imageArray, for: MJRefreshState.refreshing)
        header.lastUpdatedTimeLabel.isHidden = true
    }
    

    
    func createUI() -> Void {
        
        // 创建头部
        let headerView : UserCenterHeaderView = UserCenterHeaderView()
        headerView.frame = CGRect (x: 0, y: 0, width:SCREEN_HEIGHT , height: 90 * HEIGHT_SCALE)
        self.headerView = headerView
        // 100头像的点击事件  200完善信息的点击事件
        self.headerView?.userHeaderBlock = { (sign) in
            if sign == 100 {
                userLogin(successHandler: { () -> (Void) in
                    self.requestBaseInfo()
                }) { () -> (Void) in
                }
            } else {
                self.navigationController?.pushViewController(personalInfo(), animated: true)
            }
        }
        
        
        // 主界面
        let tableView :UITableView  = UITableView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 44), style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = MAIN_COLOR
        tableView.register(UserCenterCell1.self, forCellReuseIdentifier: "UserCenterCell1")
        tableView.register(UserCenterCell2.self, forCellReuseIdentifier: "UserCenterCell2")
        self.userTableView = tableView
        self.view .addSubview(self.userTableView!)
        self.userTableView?.tableHeaderView = headerView
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.sectionArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tempArray : NSArray = self.sectionArray![section] as! NSArray
        return tempArray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowString : String = (self.sectionArray![indexPath.section] as! NSArray)[indexPath.row] as! String
        if rowString == "RowUserIconListView"{
            return 195 * HEIGHT_SCALE
        } else {
            return 44 * HEIGHT_SCALE
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10 * HEIGHT_SCALE
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view : UIView = UIView()
        view.frame = CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 10 * HEIGHT_SCALE)
        view.backgroundColor = MAIN_COLOR;
        return view
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowString : String = (self.sectionArray![indexPath.section] as! NSArray)[indexPath.row] as! String
        // 订单管理
        if rowString == "RowOrderManage" {
            self.orderManageView = tableView.dequeueReusableCell(withIdentifier: "UserCenterCell1") as? UserCenterCell1
            self.orderManageView?.selectionStyle = UITableViewCellSelectionStyle.none
            self.orderManageView?.iconImage?.image = UIImage (named: "ic_ddgl.png")
            self.orderManageView?.titleLabel?.text = "订单管理"
            return self.orderManageView!
        // 还款管理
        } else if rowString == "RowRepaymentManage" {
            self.payManageView = tableView.dequeueReusableCell(withIdentifier: "UserCenterCell1") as? UserCenterCell1
            self.payManageView?.selectionStyle = UITableViewCellSelectionStyle.none
            self.payManageView?.iconImage?.image = UIImage (named: "ic_hkgl.png")
            self.payManageView?.titleLabel?.text = "还款管理"
            return self.payManageView!
        // “九宫格”
        } else if rowString == "RowUserIconListView" {
            let cell : UserCenterCell2 = tableView.dequeueReusableCell(withIdentifier: "UserCenterCell2") as! UserCenterCell2
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            cell.userIconBlock = {index in
                // 贷款计算器
                if index == 0 {
                    self.navigationController?.pushViewController(loanCalculator(), animated: true)
                // 微信公众号
                } else if index == 1 {
                    self.navigationController?.pushViewController(weChatFocus(), animated: true)
                // 常见问题
                } else if index == 2 {
                    userLogin(successHandler: { () -> (Void) in
                        self.navigationController?.pushViewController(userCenterWebViewWithUrl(url: CommonProblem), animated: true)
                    }) { () -> (Void) in
                    }
                // 现金
                } else if index == 3 {
                    userLogin(successHandler: { () -> (Void) in
                        self.navigationController?.pushViewController(cash(), animated: true)
                    }) { () -> (Void) in
                    }
                // 免息卷
                } else if index == 4 {
                    userLogin(successHandler: { () -> (Void) in
                        self.navigationController?.pushViewController(interestFree(), animated: true)
                    }) { () -> (Void) in
                    }
                // 赚积分
                } else if index == 5 {
                    userLogin(successHandler: { () -> (Void) in
                        self.navigationController?.pushViewController(integral(), animated: true)
                    }) { () -> (Void) in
                    }
                // 抽奖赢免息
                } else if index == 6 {
                    userLogin(successHandler: { () -> (Void) in
                        self.navigationController?.pushViewController(userCenterWebViewWithUrl(url: LuckDraw), animated: true)
                    }) { () -> (Void) in
                    }
                    
                // 邀请好友
                } else if index == 7 {
                    self.navigationController?.pushViewController(userCenterWebViewWithUrl(url: InvitingFriends), animated: true)
                // 第三方账户
                } else if index == 8 {
                    userLogin(successHandler: { () -> (Void) in
                        self.navigationController?.pushViewController(accountManage(), animated: true)
                    }) { () -> (Void) in
                    }
                }
            }
            
            return cell
        // 大额信贷
        } else if rowString == "RowLargeAmountView" {
            let cell : UserCenterCell1 = tableView.dequeueReusableCell(withIdentifier: "UserCenterCell1") as! UserCenterCell1
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.iconImage?.image = UIImage (named: "ic_wd1.png")
            cell.titleLabel?.text = "我的信贷经理"
            cell.subLabel?.text = ""
            cell.payLabel?.text = ""
            return cell
        // 设置
        } else {
            let cell : UserCenterCell1 = tableView.dequeueReusableCell(withIdentifier: "UserCenterCell1") as! UserCenterCell1
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.iconImage?.image = UIImage (named: "ic_sz.png")
            cell.titleLabel?.text = "设置"
            cell.subLabel?.text = ""
            cell.payLabel?.text = ""
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
        
        let rowString : String = (self.sectionArray![indexPath.section] as! NSArray)[indexPath.row] as! String
        if rowString == UserCenterVC.RowUserSetUp {
            userLogin(successHandler: { () -> (Void) in
                self.navigationController?.pushViewController(setUp(), animated: true)
            }) { () -> (Void) in
                
            }
        } else if rowString == UserCenterVC.RowRepaymentManage {
            userLogin(successHandler: { () -> (Void) in
                self.navigationController?.pushViewController(repayManage(), animated: true)
            }) { () -> (Void) in
                
            }
        } else if rowString == UserCenterVC.RowOrderManage {
            if self.userCenter?.application != nil {
                userLogin(successHandler: { () -> (Void) in
                    self.navigationController?.pushViewController(orderManage(), animated: true)
                }) { () -> (Void) in
                }
            } else {
                let alertView : UIAlertView = UIAlertView (title: "你还没有申请任何贷款，赶快申请吧！", message: "", delegate: nil, cancelButtonTitle: "去申请贷款")
                alertView.showWithAlertBlock(alertBlock: { (btnIndex, btnTitle) in
                    APPDELEGATE.tabBarControllerSelectedIndex(index: 1)
                })
            }
        } else if rowString == UserCenterVC.RowLargeAmountView {
            
        }
    }
    
    
    // 更新界面
    func updataUI() -> Void {
        
        // 用户信息
        self.headerView?.updateHeadeView(userCenter: self.userCenter!)
        
        // 还款管理
        self.payManageView?.updatePayManage(loanData: (self.userCenter?.record)!)

        // 订单管理
        if self.userCenter?.application != nil {
            self.orderManageView?.updateOrdeManage(loanOrdermodel:(self.userCenter?.application)!)
        } else {
            self.orderManageView?.updateOrdeManage(loanOrdermodel:LoanOrderModel())
        }
    }
    
    
    // 消息中心的定时器
    func createTimer() -> Void {
        if self.messageTimer == nil {
            self.messageTimer = Timer (timeInterval: 5, target: self, selector: #selector(requestMessageList), userInfo: nil, repeats: true)
            RunLoop.main.add(self.messageTimer!, forMode: RunLoopMode.commonModes)
        }
    }
    
    
    // 请求消息中心数据
    func requestMessageList() -> Void {
        UserCenterService.userInstance.requestMessageSate(success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            if (dataDict["newMessageCount"] as! Int) > 0 {
                self.rightBtn?.setImage(UIImage (named: "newMessage.png"), for: UIControlState.normal)
            } else {
                self.rightBtn?.setImage(UIImage (named: "message.png"), for: UIControlState.normal)
            }
            
        }) { (errorInfo) in
            
        }
    }
    
    
    // 获取用户基本信息
    func requestBaseInfo() -> Void {
        UserCenterService.userInstance.baseInfo(success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            self.userCenter = UserCenterModel.objectWithKeyValues(dict: dataDict) as? UserCenterModel
            
            // 更新界面
            self.updataUI()
            
            // 获取大额信贷经理
            self.requestLoanOfficeSate()
            
            let userInfo : UserModel = USERINFO!
            userInfo.mobile = dataDict["mobile"] as? String
            userInfo.webCookies = dataDict["webCookies"] as? NSArray
            userInfo.hasPassword = dataDict["hasPassword"] as? Bool
            userInfo.isNewUser = dataDict["isNewUser"] as? String
            userInfo.name = dataDict["name"] as? String
            userInfo.idCard = dataDict["idCard"] as? String
            userInfo.roleType = dataDict["roleType"] as? String
            userInfo.verify = dataDict["verify"] as? String
            userInfo.headImage = dataDict["headImage"] as? String
            userInfo.redPacketCount = dataDict["redPacketCount"] as? String
            userInfo.balanceAmount = dataDict["balanceAmount"] as? String
            userInfo.signInToday = dataDict["signInToday"] as? Bool
            userInfo.yhzxShowFlag = dataDict["yhzxShowFlag"] as? String
            userInfo.gender = dataDict["gender"] as? String
            USERDEFAULT.saveCustomObject(customObject: userInfo, key: "userInfo")
        }) { (errorInfo) in
            
        }
    }
    
    
    // 获取大额信贷经理
    func requestLoanOfficeSate() -> Void {
        UserCenterService.userInstance.requestLoanOfficeSate(success: { (responseObject) in
            let dataDict : NSDictionary = responseObject as! NSDictionary
            var largeAmount : Bool?// 我的信贷经理
            if dataDict["data"] is NSArray {
                if (dataDict["data"] as! NSArray).count > 0 {
                    largeAmount = true
                } else {
                    largeAmount = false
                }
            } else {
                largeAmount = false
            }
            
            // 更新界面
            if largeAmount! {
                self.sectionArray = [["RowOrderManage","RowRepaymentManage"],["RowUserIconListView"],["RowLargeAmountView","RowUserSetUp"]]
            } else {
                self.sectionArray = [["RowOrderManage","RowRepaymentManage"],["RowUserIconListView"],["RowUserSetUp"]]
            }
            // 刷新界面
            self.userTableView?.reloadData()
        }) { (errorInfo) in
            
        }
    }
    
    
    // 消息的点击事件
    func messgaeClick() -> Void {
        self.navigationController?.pushViewController(messageCenter(), animated: true)
    }

    
    override func setUpNavigationView() {
        super.setUpNavigationView()
        self.navigationItem.titleView = NaviBarView().setUpNaviBarWithTitle(title: "个人中心");
        self.navigationItem.leftBarButtonItem = nil
        
        let rightBtn = UIButton (type: UIButtonType.custom)
        rightBtn.frame = CGRect (x: 0, y: 0, width: 30, height: 30)
        rightBtn .setImage(UIImage (named: "message.png"), for: UIControlState.normal)
        rightBtn .addTarget(self, action: #selector(messgaeClick), for: UIControlEvents.touchUpInside)
        rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -25)
        self.rightBtn = rightBtn
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (customView: self.rightBtn!)
    }
    
    
    // 初始化数据
    override func initializationData() -> Void {
        super.initializationData()
        self.sectionArray = [["RowOrderManage","RowRepaymentManage"],["RowUserIconListView"],["RowUserSetUp"]]
        NotificationCenter.default.addObserver(self, selector: #selector(loginOut), name: NSNotification.Name (rawValue: "NotificationLoginOut"), object: nil)
    }
    
    
    // 退出登录后，界面刷新
    func loginOut() -> Void
    {
        self.headerView?.loginOutUpdateView()
        self.orderManageView?.loginOutOrdeManageView()
        self.payManageView?.loginOutPayManageView()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
