//
//  BankSheetView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/2/28.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias BankSheetBlock = (Int) -> Void
typealias BankPickBlock = (BankNameModel) -> Void
class BankSheetView: BasicView, UIPickerViewDelegate, UIPickerViewDataSource {

    var bankSheetBlock : BankSheetBlock?// 头部按钮
    var bankPickView : UIPickerView = UIPickerView()
    var bankPickBlock : BankPickBlock?// 选择框
    var sheetBool : Bool = true
    var model : BankNameModel?// 选中的
    var bankArray : [BankNameModel] = [BankNameModel](){
        didSet{
            // 刷新界面
            self.bankPickView.reloadAllComponents()
        }
    }
    
    
    // 创建UI
    override func createUI() {
        super.createUI()
        
        // 取消
        let cancelBtn : UIButton = UIButton (type: UIButtonType.custom)
        cancelBtn.setTitle("取消", for: UIControlState.normal)
        cancelBtn.setTitleColor(UIColor().colorWithHexString(hex: "333333"), for: UIControlState.normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17 * WIDTH_SCALE)
        cancelBtn.setBackgroundImage(UIImage (named: "btnOn.png"), for: UIControlState.normal)
        cancelBtn.setBackgroundImage(UIImage (named: "btnOff.png"), for: UIControlState.highlighted)
        cancelBtn.addTarget(self, action: #selector(tapClick(sender:)), for: UIControlEvents.touchUpInside)
        cancelBtn.tag = 500
        self.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.top.left.equalTo(self)
            make.height.equalTo(40 * HEIGHT_SCALE)
            make.width.equalTo((SCREEN_WIDTH - 1) / 2)
        }
        
        let lineView : UIView = UIView()
        lineView.backgroundColor = LINE_COLOR2
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(cancelBtn.snp.right)
            make.height.equalTo(cancelBtn.snp.height)
            make.width.equalTo(1)
        }
        
        // 确定
        let determineBtn : UIButton = UIButton (type: UIButtonType.custom)
        determineBtn.setTitle("确定", for: UIControlState.normal)
        determineBtn.setTitleColor(UIColor().colorWithHexString(hex: "333333"), for: UIControlState.normal)
        determineBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17 * WIDTH_SCALE)
        determineBtn.setBackgroundImage(UIImage (named: "btnOn.png"), for: UIControlState.normal)
        determineBtn.setBackgroundImage(UIImage (named: "btnOff.png"), for: UIControlState.highlighted)
        determineBtn.addTarget(self, action: #selector(tapClick(sender:)), for: UIControlEvents.touchUpInside)
        determineBtn.tag = 501
        self.addSubview(determineBtn)
        determineBtn.snp.makeConstraints { (make) in
            make.top.right.equalTo(self)
            make.height.equalTo(40 * HEIGHT_SCALE)
            make.width.equalTo((SCREEN_WIDTH - 1) / 2)
        }
        
        // UIPickerView选择框
        self.bankPickView.delegate = self
        self.bankPickView.dataSource = self
        self.bankPickView.selectRow(0, inComponent: 0, animated: true)
        self.addSubview(self.bankPickView)
        self.bankPickView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(cancelBtn.snp.bottom)
        }
    }
    
    
    // MARK: UIPickerViewDelegate, UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.bankArray.count
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
        let bankName : BankNameModel = self.bankArray[row]
        return bankName.bankName as String
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.model = self.bankArray[row]
        if self.sheetBool {
            bankNameSelected(model: self.model!)
        }
    }
    
    
    // 按钮的点击事件
    func tapClick(sender : UIButton) -> Void {
        if self.bankSheetBlock != nil {
            self.bankSheetBlock!(sender.tag)
        }
        if self.model == nil {
            self.model = self.bankArray[0]
        }
        
        if self.sheetBool {
            bankNameSelected(model: self.model!)
        } else {
            // 确定按钮的点击事件
            if sender.tag == 501 {
                bankNameSelected(model: self.model!)
            }
        }
    }
    
    
    func bankNameSelected(model : BankNameModel) -> Void {
        if self.bankPickBlock != nil {
            self.bankPickBlock!(self.model!)
        }
    }
}
