//
//  LargeLoanVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/2/26.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class LargeLoanVC: BasicVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var headerView : LargeHeaderView = LargeHeaderView()// 头部View
    var loanCollectionView : UICollectionView?// 经理列表
    var back : Bool = true// 判断是进入下一页还是返回
    var largeModel : LargeModel = LargeModel()// 大额贷款数据源
    var largeArray : [LoanTypeModel] = [LoanTypeModel]()// 贷款种类类别
    
    
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
            let largeInfo : LargeInfoModel = LargeInfoModel()
            largeInfo.cityName = self.largeModel.cityName
            largeInfo.loanNumText = self.largeModel.totalCount
            largeInfo.verify = String (format: "%i", (USERINFO?.verify)!)
            largeInfo.nameText = (USERINFO?.name)!
            largeInfo.cardText = (USERINFO?.idCard)!
            
            weak var weakSelf = self
            let headerView : LargeHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "largeHeader", for: indexPath) as! LargeHeaderView
            // 更新头部数据
            headerView.updateLargeHeaderData(largeInfo: largeInfo)
            headerView.largeChangeCity = { () in
                weakSelf?.back = false
                weakSelf?.navigationController?.pushViewController(chooseCity(), animated: true)
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
        cell.refreshBlock = { (item) in
            let refreshIndexPath : IndexPath = IndexPath.init(row: item, section: 0)
            weakSelf?.loanCollectionView?.reloadItems(at: [refreshIndexPath])
        }
        cell.callPhoneBlcok = { (sender) in
            
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "大额贷款");
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
