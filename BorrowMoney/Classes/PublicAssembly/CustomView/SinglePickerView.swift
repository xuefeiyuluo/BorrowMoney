//
//  SinglePickerView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/20.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias SinglePickerBlock = (Int,String) -> Void
class SinglePickerView: BasicView, UIPickerViewDelegate, UIPickerViewDataSource {
    var customView : UIView = UIView()// 弹框View
    let backBtn : UIButton = UIButton()// 背景的点击事件
    var pickerView : UIPickerView = UIPickerView()// 选择器
    var singlePickerBlock : SinglePickerBlock?// 选中的回调事件
    var rowSelected : Int = 0// 选中的row
    var slideBool : Bool = false// pickerView滚动时是否回调
    var pickerData : [String] = [String](){// 数据源
        didSet{
            // 刷新界面
            self.pickerView.reloadAllComponents()
            
            UIView.animate(withDuration: 0.3) {
                self.customView.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT - 230 * HEIGHT_SCALE, width: SCREEN_WIDTH, height: 230 * HEIGHT_SCALE)
            }
        }
    }
    

    override func createUI() {
        super.createUI()
        
        // 背景的点击事件
        self.backBtn.addTarget(self, action: #selector(backClick), for: UIControlEvents.touchUpInside)
        self.backBtn.backgroundColor = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
        self.addSubview(backBtn)
        self.backBtn.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self)
        }
        
        
        self.customView.backgroundColor = UIColor.white
        self.customView.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 230 * HEIGHT_SCALE)
        self.addSubview(self.customView)
        
    
        // 头部View
        let titleView : UIView = UIView()
        self.customView.addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.customView)
            make.height.equalTo(44 * HEIGHT_SCALE)
        }
        
        
        // 取消
        let cancelBtn : UIButton = UIButton (type: UIButtonType.custom)
        cancelBtn.setTitle("取消", for: UIControlState.normal)
        cancelBtn.setTitleColor(UIColor().colorWithHexString(hex: "007AFF"), for: UIControlState.normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16 * WIDTH_SCALE)
        cancelBtn.addTarget(self, action: #selector(tapClick(sender:)), for: UIControlEvents.touchUpInside)
        cancelBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15 * WIDTH_SCALE, 0, 0)
        cancelBtn.contentHorizontalAlignment = .left
        cancelBtn.tag = 500
        titleView.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(titleView)
            make.width.equalTo(SCREEN_WIDTH / 2)
        }
        
        
        // 确定
        let determineBtn : UIButton = UIButton (type: UIButtonType.custom)
        determineBtn.setTitle("确定", for: UIControlState.normal)
        determineBtn.setTitleColor(UIColor().colorWithHexString(hex: "007AFF"), for: UIControlState.normal)
        determineBtn.contentHorizontalAlignment = .right
        determineBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15 * WIDTH_SCALE)
        determineBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16 * WIDTH_SCALE)
        determineBtn.addTarget(self, action: #selector(tapClick(sender:)), for: UIControlEvents.touchUpInside)
        determineBtn.tag = 501
        titleView.addSubview(determineBtn)
        determineBtn.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(titleView)
            make.width.equalTo(SCREEN_WIDTH / 2)
        }
        
        let lineView : UIView = UIView()
        lineView.backgroundColor = LINE_COLOR2
        titleView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(titleView)
            make.height.equalTo(1 * HEIGHT_SCALE)
        }
        
        // UIPickerView选择框
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.selectRow(0, inComponent: 0, animated: true)
        self.customView.addSubview(self.pickerView)
        self.pickerView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.customView)
            make.top.equalTo(titleView.snp.bottom)
        }
    }
    
    
    // MARK: UIPickerViewDelegate, UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40 * HEIGHT_SCALE
    }
    
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return SCREEN_WIDTH
    }
    
    // 修改字体样式
    //    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    //        var pickerLabel = view as? UILabel
    //        if pickerLabel == nil {
    //            pickerLabel = UILabel()
    //            pickerLabel?.font = UIFont.systemFont(ofSize: 15 * HEIGHT_SCALE)
    //            pickerLabel?.textAlignment = .center
    //        }
    //        let bankName : BankNameModel = self.bankArray[row]
    //        pickerLabel?.text = bankName.bankName as String
    //        pickerLabel?.textColor = UIColor.black
    //        return pickerLabel!
    //    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerData[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.rowSelected = row
        if self.slideBool {
            if self.singlePickerBlock != nil {
                self.singlePickerBlock!(self.rowSelected,self.pickerData[self.rowSelected])
            }
        }
    }
    
    // 按钮的点击事件
    func tapClick(sender : UIButton) -> Void {
        // 500取消按钮
        if sender.tag == 500 {
        } else {
            if self.singlePickerBlock != nil {
                self.singlePickerBlock!(self.rowSelected,self.pickerData[self.rowSelected])
            }
        }
        // 移除弹框
        removePickerView()
    }
    
    
    // 背景的点击事件
    func backClick() -> Void {
        // 移除弹框
        removePickerView()
    }
    
    
    // 移除弹框
    func removePickerView() -> Void {
        UIView.animate(withDuration: 0.3, animations: {
            self.customView.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 230 * HEIGHT_SCALE)
        }) { (inished : Bool) in
            self.removeFromSuperview()
        }
    }
    
}
