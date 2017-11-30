//
//  UserCenterCell2.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/13.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

typealias UserIconBlock = (Int) -> Void
class UserCenterCell2: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var userCollectionView : UICollectionView?
    var dataArray : NSArray?
    var userIconBlock : UserIconBlock?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 初始化数据
        initializationData()
        
        // 创建UI
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // 创建UI
    func createUI() -> Void {
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize (width: SCREEN_WIDTH / 3 - 0.01, height: 195 * HEIGHT_SCALE / 3)
        let userCollectionView : UICollectionView = UICollectionView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 195 * HEIGHT_SCALE), collectionViewLayout: layout)
        userCollectionView.dataSource = self
        userCollectionView.delegate = self
        userCollectionView.backgroundColor = UIColor.clear
        userCollectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: "userCollection")
        self.userCollectionView = userCollectionView
        self.contentView .addSubview(self.userCollectionView!)
    }
    
    
    //MARK: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.dataArray?.count)!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.01
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.01
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UserCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCollection", for: indexPath) as! UserCollectionViewCell
        
        cell.dataDict = self.dataArray?[indexPath.item] as? NSDictionary
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if self.userIconBlock != nil {
            self.userIconBlock!(indexPath.item)
        }
    }
    

    func initializationData() -> Void {
        self.dataArray = [["titileName":"贷款计算器","imageName":"ic_jsq.png"],["titileName":"微信公众号","imageName":"ic_wx.png"],["titileName":"常见问题","imageName":"ic_cjwt.png"],["titileName":"现金","imageName":"ic_xj.png"],["titileName":"免息卷","imageName":"ic_mxj.png"],["titileName":"赚积分","imageName":"ic_zjf.png"],["titileName":"抽奖赢免息","imageName":"ic_cmx.png"],["titileName":"邀请好友","imageName":"ic_yqhy.png"],["titileName":"第三方账户管理","imageName":"nav_gl.png"]]
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
