//
//  DropdownView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/12/26.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

typealias DataBlock = (_ loanType : LoanAmountType, _ tag : Int) -> Void

class DropdownView: BasicView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate{
    
    lazy var backBtn : UIButton = UIButton (type: UIButtonType.custom)// 背景点击事件
    lazy var dropView : UIView = UIView()
    var dropCollectionView : UICollectionView?
    var dropTableView : UITableView?
    
    var dataBlock : DataBlock?// 数据资源的回调
    var dropViewHeight : CGFloat = 105 * HEIGHT_SCALE;// 默认下拉框的高度为105
    var dataArray : [LoanAmountType] = [LoanAmountType]()// 金额类型排序的数据源
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        // 添加控件
        createControls(frame: frame)
    }
    
    
    // 添加控件
    func createControls(frame : CGRect) -> Void {
        // 下拉框View
        self.dropView.frame = CGRect (x: 0, y: 0 * HEIGHT_SCALE, width: SCREEN_WIDTH, height: self.dropViewHeight)
        self.addSubview(self.dropView)
        
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize (width: (SCREEN_WIDTH - 50 * WIDTH_SCALE) / 3 - 0.01, height: 30 * HEIGHT_SCALE - 0.01)
        let dropCollectionView : UICollectionView = UICollectionView.init(frame: CGRect (x: 15 * WIDTH_SCALE, y: 17 * HEIGHT_SCALE, width: SCREEN_WIDTH - 2 * 15 * WIDTH_SCALE, height: self.dropView.frame.size.height - 34 * HEIGHT_SCALE), collectionViewLayout: layout)
        dropCollectionView.dataSource = self
        dropCollectionView.delegate = self
        dropCollectionView.backgroundColor = UIColor.clear
        dropCollectionView.isHidden = false
        dropCollectionView.register(DropViewCell.self, forCellWithReuseIdentifier: "dropCollection")
        self.dropCollectionView = dropCollectionView
        self.dropView .addSubview(self.dropCollectionView!)
        
        
        let dropTableView : UITableView = UITableView (frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: self.dropView.frame.size.height), style: UITableViewStyle.grouped)
        dropTableView.dataSource = self;
        dropTableView.delegate = self
        dropTableView.isHidden = true
        dropTableView.separatorStyle = .none
        dropTableView.register(SortViewCell.self, forCellReuseIdentifier: "sortView")
        self.dropTableView = dropTableView
        self.dropView.addSubview(self.dropTableView!)
    }
    
    
    //MARK: UITableViewDataSource, UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SortViewCell = tableView.dequeueReusableCell(withIdentifier: "sortView") as! SortViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.loanType = self.dataArray[indexPath.row]
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let loanType : LoanAmountType = self.dataArray[indexPath.row]
        if self.dataBlock != nil {
            self.dataBlock!(loanType,indexPath.row)
        }
    }
    
    
    //MARK: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 * HEIGHT_SCALE
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 * WIDTH_SCALE
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : DropViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dropCollection", for: indexPath) as! DropViewCell
        
        let loanType : LoanAmountType = self.dataArray[indexPath.item]
        
        cell.loanType = loanType
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let loanType : LoanAmountType = self.dataArray[indexPath.item]
        if self.dataBlock != nil {
            self.dataBlock!(loanType,indexPath.item)
        }
    }
    
    
    // 更新数据
    func updateDropViewData(dataArray : [LoanAmountType]) -> Void {
        self.dataArray = dataArray;
        if self.dataArray.count >= 1 {
            self.dropView.frame = CGRect (x: 0, y: 0 * HEIGHT_SCALE, width: SCREEN_WIDTH, height: self.dropViewHeight)
            let loanType : LoanAmountType = self.dataArray.first!
            if loanType.type == "amount" || loanType.type == "type"{
                self.dropCollectionView?.isHidden = false
                self.dropTableView?.isHidden = true
                self.dropCollectionView?.frame = CGRect (x: 15 * WIDTH_SCALE, y: 17 * HEIGHT_SCALE, width: SCREEN_WIDTH - 2 * 15 * WIDTH_SCALE, height: self.dropViewHeight - 34 * HEIGHT_SCALE)
                // 刷新数据
                self.dropCollectionView?.reloadData()
            } else if loanType.type == "sort" {
                self.dropTableView?.isHidden = false
                self.dropCollectionView?.isHidden = true
                self.dropTableView?.frame = CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: self.dropViewHeight)
                self.dropTableView?.reloadData()
            }
        }
    }
}
