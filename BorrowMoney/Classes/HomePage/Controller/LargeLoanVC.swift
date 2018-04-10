//
//  LargeLoanVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/2/26.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit
import CoreTelephony

class LargeLoanVC: BasicVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    lazy var callView : CallPhoneView = CallPhoneView()// 拨打电话过渡界面
    var headerView : LargeHeaderView?// 头部View
    var loanCollectionView : UICollectionView?// 经理列表
    var back : Bool = true// 判断是进入下一页还是返回
    var largeModel : LargeModel = LargeModel()// 大额贷款数据源
    var largeArray : [LoanTypeModel] = [LoanTypeModel]()// 贷款种类类别
    var alertView : ConsultAlertView = ConsultAlertView()// 咨询的弹框
    var largeInfo : LargeInfoModel = LargeInfoModel()// 提交申请信息
    let callCenter = CTCallCenter()// 电话管理中心
    var delay : Int = 0// 3秒倒计时
    var callTimer : Timer?// 3秒倒计时
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.back = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建UI
        createUI()
        
        // 添加下拉刷新
        createRefresh()
        
        // 添加拨打电话的回调
        addCallPhoneBlock()
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.back {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    // 添加下拉刷新
    func createRefresh() -> Void {
        var imageArray : [UIImage] = [UIImage]()
        for i in 0 ..< 6 {
            let imageName : String = String (format: "BorrowMoney%d", i)
            
            let image : UIImage = UIImage (named: imageName)!
            imageArray.append(image)
        }
        
        self.loanCollectionView?.mj_header = MJRefreshGifHeader(refreshingBlock: { () -> Void in
            // 获取信贷员列表
            self.requestLoanOfficeList()
            self.loanCollectionView?.mj_header.endRefreshing()
        })
        
        var imageArray2 : [UIImage] = [UIImage]()
        let image2 : UIImage = UIImage (named: "Money")!
        imageArray2.append(image2)
        
        let header : MJRefreshGifHeader = self.loanCollectionView?.mj_header as! MJRefreshGifHeader
        header.setImages(imageArray2, for: MJRefreshState.idle)
        header.setImages(imageArray, for: MJRefreshState.pulling)
        header.setImages(imageArray, for: MJRefreshState.refreshing)
        header.lastUpdatedTimeLabel.isHidden = true
        
        // 获取信贷员列表
        self.loanCollectionView?.mj_header.beginRefreshing()
    }
    
    
    // 创建UI
    func createUI() -> Void {
        self.view.backgroundColor = UIColor.white

        // 创建信贷经理列表
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let itemWidth : CGFloat = (SCREEN_WIDTH - 10 * WIDTH_SCALE) / 2
        layout.itemSize = CGSize.init(width: itemWidth, height: 240 * HEIGHT_SCALE)
        layout.minimumLineSpacing = 10 * WIDTH_SCALE
        layout.minimumInteritemSpacing = 10 * HEIGHT_SCALE
        layout.headerReferenceSize = CGSize.init(width: SCREEN_WIDTH, height: 435 * HEIGHT_SCALE)

        let collectionView : UICollectionView = UICollectionView (frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(LargeViewCell.self, forCellWithReuseIdentifier: "largeCell")
        collectionView.register(LargeHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "largeHeader")
        collectionView.showsVerticalScrollIndicator = false
        self.loanCollectionView = collectionView
        self.view.addSubview(self.loanCollectionView!)
        self.loanCollectionView?.snp.makeConstraints({ (make) in
            make.top.bottom.right.left.equalTo(self.view)
        })

        // 立即咨询弹框
        self.alertView.isHidden = true
        self.view.addSubview(self.alertView)
        self.alertView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self.view)
        }
        weak var weakSelf = self
        // 弹框立即咨询的回调
        self.alertView.consultBlock = { (largeInfo) in
            weakSelf?.largeInfo = largeInfo
            // 更新头部数据
            weakSelf?.headerView?.updateLargeHeaderData(largeInfo: (weakSelf?.largeInfo)!)

            // 拨打电话
            UIApplication.shared.openURL(NSURL (string: String (format: "tel://%@", "10010"))! as URL)
            // 判断是否可以拨打电话
//            weakSelf?.loanOfferBeforeCall()
        }
    }
    
    
    //MARK: UICollectionViewDelegate, UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.largeArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            self.largeInfo.cityName = self.largeModel.cityName
            self.largeInfo.loanNumText = self.largeModel.totalCount
            self.largeInfo.verify = String (format: "%i", (USERINFO?.verify)!)
            self.largeInfo.nameText = (USERINFO?.name)!
            self.largeInfo.cardText = (USERINFO?.idCard)!
            
            weak var weakSelf = self
            let headerView : LargeHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "largeHeader", for: indexPath) as! LargeHeaderView
            self.headerView = headerView
            // 更新头部数据
            headerView.updateLargeHeaderData(largeInfo: self.largeInfo)
            headerView.largeChangeCity = { () in
                weakSelf?.back = false
                weakSelf?.navigationController?.pushViewController(chooseCity(), animated: true)
            }
            // 提交申请的回调
            headerView.largeSubmitBlock = { (tempDict) in
                weakSelf?.back = false
                weakSelf?.navigationController?.pushViewController(oneToOne(dict: tempDict), animated: true)
            }
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        weak var weakSelf = self
        let cell : LargeViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "largeCell", for: indexPath) as! LargeViewCell
        cell.updateViewWithData(loanDate: self.largeArray, indexPath: indexPath)
        // 更换的回调
        cell.refreshBlock = { (item) in
            let refreshIndexPath : IndexPath = IndexPath.init(row: item, section: 0)
            weakSelf?.loanCollectionView?.reloadItems(at: [refreshIndexPath])
        }

        // 立即咨询的回调
        cell.callPhoneBlcok = { (tag) in
            let model : LoanTypeModel = weakSelf!.largeArray[tag]
            weakSelf?.largeInfo.url = model.providerUrl
            weakSelf?.largeInfo.providerId = model.providerId
            weakSelf?.largeInfo.spreadTypeName = model.spreadTypeName
            weakSelf?.largeInfo.spreadType = model.spreadType
            weakSelf?.largeInfo.providerName = model.providerName
            weakSelf?.alertView.isHidden = false
            weakSelf?.alertView.updateAlertViewData(largeInfo: (weakSelf?.largeInfo)!)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "大额贷款");
    }

    
    // 添加拨打电话的回调
    func addCallPhoneBlock() -> Void {
        weak var weakSelf = self
        self.callCenter.callEventHandler = { (call : CTCall) in
            // 电话挂断
            if call.callState == CTCallStateDisconnected {
                DispatchQueue.main.async {
                    weakSelf?.delay = 3
                    weakSelf?.callTimer = Timer.scheduledTimer(timeInterval: 1, target: weakSelf as Any, selector: #selector(weakSelf?.delayOperation), userInfo: nil, repeats: true)
                }
            // 电话接通
            } else if call.callState == CTCallStateConnected {
                
            // 通话途中有新的电话打进来
            } else if call.callState == CTCallStateIncoming {
                
            // 电话播出
            } else if call.callState == CTCallStateDialing {
                DispatchQueue.main.async {
                    weakSelf?.alertView.closeClick()
                    weakSelf?.addCallPhoneView()
                }
            // 其它
            } else {
                
            }
        }
    }
    
    
    // 延迟操作
    func delayOperation() -> Void {
        if self.delay > 0 {
            self.callView.promptLabel.text = String (format: "正在挂机...%i", self.delay)
            self.delay -= 1
            if self.delay == 0 {
                // 获取拨打电话的结果
                requestLoanOfficeCallResult()
            }
        } else {
            self.callTimer?.invalidate()
            self.callTimer = nil
        }
    }
    
    
    // 添加拨打电话的过段界面
    func addCallPhoneView() -> Void {
        let window : UIWindow = UIApplication.shared.keyWindow!
        self.callView.frame = window.bounds
        window.addSubview(self.callView)
        // 继续拨打下一位信贷经理
        self.callView.callBtnBlock = { () in
            
        }
    }
    
    
    // 获取信贷员列表
    func requestLoanOfficeList() -> Void {
        HomePageService.homeInstance.requestLoanData(cityId: "251", success: { (responseObject) in
            self.loanCollectionView?.mj_header.endRefreshing()
            let tempDict : NSDictionary = responseObject as! NSDictionary
            self.largeModel = LargeModel.objectWithKeyValues(dict: tempDict) as! LargeModel
            self.largeArray = self.largeModel.serviceTypeList
            
            // 刷新数据
            self.loanCollectionView?.reloadData()
        }) { (errorInfo) in
            self.loanCollectionView?.mj_header.endRefreshing()
        }
    }
    
    
    // 判断是否可以拨打电话
    func loanOfferBeforeCall() -> Void {
        HomePageService.homeInstance.requestBeforeCall(applyAmount: self.largeInfo.amountText!, applyTerm: self.largeInfo.termText!, card: self.largeInfo.cardText!, city: "251", name: self.largeInfo.nameText!, providerId: self.largeInfo.providerId!, spreadType: self.largeInfo.spreadType!, spreadTypeName: self.largeInfo.spreadTypeName!, success: { (responseObject) in
            self.alertView.closeClick()
            let tempDict : NSDictionary = responseObject as! NSDictionary
            self.largeInfo.recordId = tempDict.stringForKey(key: "recordId")

            // 拨打电话
            UIApplication.shared.openURL(NSURL (string: String (format: "tel://%@", self.largeModel.thirdPhoneNumber!))! as URL)
        }) { (errorInfo) in
        }
    }
    
    
    // 获取拨打电话的结果
    func requestLoanOfficeCallResult() -> Void {
        HomePageService.homeInstance.requestLoanOfficeCallResult(recordId: self.largeInfo.recordId!, success: { (responseObject) in
            let tempDict : NSDictionary = responseObject as! NSDictionary
            self.callView.cancelBtn.isHidden = true
            self.callView.promptLabel.isHidden = true
            self.callView.callImageView.isHidden = true
            let dataDict : NSMutableDictionary = NSMutableDictionary()
            
            if tempDict.stringForKey(key: "status") == "NO_NEXT" || tempDict["searchProviderVO"] != nil {
                dataDict.setValue("啊哦，当前暂无信贷经理接驾。是否提交申请预约服务？", forKey: "btnContent")
                dataDict.setValue("好的", forKey: "btnRight")
                dataDict.setValue("取消", forKey: "btnLeft")
                dataDict.setValue("noProvider", forKey: "stateSign")
            } else {
                if tempDict.stringForKey(key: "status") == "SUCCESS" {
                    dataDict.setValue("本次服务满足您的需求吗，是否需要为您转接下一位信贷经理？", forKey: "btnContent")
                    dataDict.setValue("好的", forKey: "btnRight")
                    dataDict.setValue("不必了,谢谢", forKey: "btnLeft")
                    dataDict.setValue("callSussecc", forKey: "stateSign")
                } else {
                    dataDict.setValue(String (format: "真不巧，%@暂未接到您的电话。借小二将为您联系下一位信贷经理？", self.largeInfo.providerName!), forKey: "btnContent")
                    dataDict.setValue("确定", forKey: "btnRight")
                    dataDict.setValue("取消", forKey: "btnLeft")
                    dataDict.setValue("callFail", forKey: "stateSign")
                }
                
                // 下一位信贷员数据
                let model : LoanTypeModel = LoanTypeModel.objectWithKeyValues(dict: tempDict["searchProviderVO"] as! NSDictionary) as! LoanTypeModel
                self.largeInfo.spreadType = model.spreadType
                self.largeInfo.providerId = model.providerId
                self.largeInfo.providerName = model.providerName
                // 更新弹框数据
                self.callView.updateCallPhoneView(dict: dataDict)
            }
        }) { (errorInfo) in
        }
    }
    
    
    deinit {
        self.callTimer?.invalidate()
        self.callTimer = nil
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
