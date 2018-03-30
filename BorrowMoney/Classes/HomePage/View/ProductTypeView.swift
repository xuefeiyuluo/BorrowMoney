//
//  ProductTypeView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/30.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

typealias ImageBlock = (Int) -> Void
class ProductTypeView: BasicView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var productCollectionView : UICollectionView?//
    var lineView : UIView?// 横线
    var line1 : UIButton?// 第一条横线
    var line2 : UIButton?// 第一条横线
    var imageBlock : ImageBlock?// 图片的点击事件
    var productArray : [BannerModel] = [BannerModel]()// 数据源
    
    
    // 创建界面
    override func createUI() -> Void {
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.itemSize = CGSize (width: SCREEN_WIDTH / 5 - 0.01, height: 80 * HEIGHT_SCALE)
        let collectionView : UICollectionView = UICollectionView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 80 * HEIGHT_SCALE), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.isPagingEnabled = true
        collectionView.register(ProductViewCell.self, forCellWithReuseIdentifier: "product")
        self.productCollectionView = collectionView
        self.addSubview(self.productCollectionView!)
        
        let lineView : UIView = UIView()
        self.lineView = lineView
        self.addSubview(self.lineView!)
        self.lineView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self)
            make.top.equalTo((self.productCollectionView?.snp.bottom)!)
            make.height.height.equalTo(10 * HEIGHT_SCALE)
        })
        
        // 第一条横线
        let line1 : UIButton = UIButton (type: UIButtonType.custom)
        line1.setImage(UIImage (named: "line2"), for: UIControlState.normal)
        line1.setImage(UIImage (named: "line1"), for: UIControlState.selected)
        line1.isSelected = true
        line1.tag = 500
        self.line1 = line1
        self.lineView?.addSubview(self.line1!)
        self.line1?.snp.makeConstraints({ (make) in
            make.top.bottom.equalTo(self.lineView!)
            make.width.equalTo(10 * WIDTH_SCALE)
            make.right.equalTo((self.lineView?.snp.centerX)!).offset(-2 * WIDTH_SCALE)
        })
        
        
        // 第一条横线
        let line2 : UIButton = UIButton (type: UIButtonType.custom)
        line2.setImage(UIImage (named: "line2"), for: UIControlState.normal)
        line2.setImage(UIImage (named: "line1"), for: UIControlState.selected)
        line2.tag = 600
        self.line2 = line2
        self.lineView?.addSubview(self.line2!)
        self.line2?.snp.makeConstraints({ (make) in
            make.top.bottom.equalTo(self.lineView!)
            make.width.equalTo(10 * WIDTH_SCALE)
            make.left.equalTo((self.lineView?.snp.centerX)!).offset(2 * WIDTH_SCALE)
        })
    }

    
    // MARK: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.01
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.01
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ProductViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as! ProductViewCell
        cell.model = self.productArray[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if self.imageBlock != nil {
            self.imageBlock!(indexPath.item)
        }
    }
    
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset : CGPoint = scrollView.contentOffset
        if offset.x / (self.productCollectionView?.frame.size.width)! == 0 {
            self.line1?.isSelected = true
            self.line2?.isSelected = false
        } else if offset.x / (self.productCollectionView?.frame.size.width)! == 1{
            self.line1?.isSelected = false
            self.line2?.isSelected = true
        }
    }
    
    
    // 数据源
    func updateProductData(dataArray : NSArray) -> Void {
        if dataArray.count > 0 {
            self.productArray = (dataArray as? [BannerModel])!
            // 数据填充
            if self.productArray.count % 5 != 0 {
                for _ in 0 ..< (5 - self.productArray.count % 5) {
                    self.productArray.append(BannerModel())
                }
            }
            
            // 刷新数据
            self.productCollectionView?.reloadData()
        }
    }
}
