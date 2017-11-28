//
//  GraphicView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/10.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

typealias SubmitClickBlock = (String) -> Void
class GraphicView: UIView {

    var backBtn : UIButton?// 背景
    var alertView : UIView?// 弹框
    var titleLabel : UILabel?// 标题
    var submitBtn : UIButton?// 确定按钮
    var graphicCodeView : UIImageView?// 图形验证码
    var codeField : UITextField?// 输入框
    var lineView : UIView?// 横线
    var submitClickBlock : SubmitClickBlock?
    
    // 验证码
    var imageCode : String? {
        didSet {
            let tempData = NSData(base64Encoded:imageCode!, options:NSData.Base64DecodingOptions(rawValue: 0))
            self.graphicCodeView?.image = UIImage (data: tempData! as Data)
        }
    }
    
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        // 创建控件
        createUI(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // 创建控件
    func createUI(frame : CGRect) -> Void {
        // 添加一个遮盖按钮
        self.backBtn = UIButton (type: UIButtonType.custom)
        self.backBtn?.backgroundColor = UIColor.clear
        self.backBtn?.addTarget(self, action: #selector(backClick), for: UIControlEvents.touchUpInside)
        self .addSubview(self.backBtn!)
        
        // 弹框
        self.alertView = UIView()
        self.alertView?.backgroundColor = UIColor.white
        self.alertView?.layer.cornerRadius = 4
        self.alertView?.layer.masksToBounds = true
        self .addSubview(self.alertView!)
        
        // 标题
        self.titleLabel = UILabel()
        self.titleLabel?.text = "请输入图形验证码"
        self.titleLabel?.font = UIFont .systemFont(ofSize: 17 * WIDTH_SCALE)
        self.titleLabel?.textColor = UIColor().colorWithHexString(hex: "383838")
        self.titleLabel?.textAlignment = NSTextAlignment.center
        self.alertView?.addSubview(self.titleLabel!)
        
        // 验证码
        let view = UIImageView()
        view.layer.cornerRadius = 2
        view.backgroundColor = UIColor .gray;
        view.layer.borderColor = LINE_COLOR3.cgColor
        view.layer.borderWidth = 0.5
        view.layer.masksToBounds = true
        self.graphicCodeView = view
        self.alertView?.addSubview(self.graphicCodeView!)
        
        // 输入框
        let textField = UITextField()
        textField.placeholder = "请输入图形验证码"
        textField.font = UIFont .systemFont(ofSize: 16 * WIDTH_SCALE)
        textField.textColor = UIColor().colorWithHexString(hex: "3d3d3d")
        textField.keyboardType = UIKeyboardType.asciiCapable
        textField.setValue(UIFont.systemFont(ofSize: 14 * WIDTH_SCALE), forKeyPath: "_placeholderLabel.font")
        textField.setValue(LINE_COLOR3, forKeyPath: "_placeholderLabel.textColor")
        self.codeField = textField
        self.alertView?.addSubview(self.codeField!)
        
        // 横线
        let lineView = UIView()
        lineView.backgroundColor = LINE_COLOR3
        self.lineView = lineView
        self.alertView?.addSubview(self.lineView!)
        
        // 确定按钮
        let submitBtn = UIButton (type: UIButtonType.custom)
        submitBtn .setTitle("确定", for: UIControlState.normal)
        submitBtn .addTarget(self, action:#selector(submitClick) , for: UIControlEvents.touchUpInside)
        submitBtn.backgroundColor = NAVIGATION_COLOR
        submitBtn.layer.cornerRadius = 2;
        submitBtn.layer.masksToBounds = true
        self.submitBtn = submitBtn
        self.alertView?.addSubview(self.submitBtn!)
    }
    
    
    override func layoutSubviews() {
        super .layoutSubviews()
        self.backBtn?.frame = self.bounds
        self.backBtn?.backgroundColor = UIColor (colorLiteralRed: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 0.5)
    }
    
    
    // 显示图形码弹框
    func showInRect(rect : CGRect) -> Void {
        let window : UIWindow = UIApplication.shared.keyWindow!
        self.frame = window.bounds
        window .addSubview(self)
        
        // 弹框大小
        self.alertView?.frame = rect
        
        // 标题
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.right.width.equalTo(self.alertView!)
            make.top.equalTo((self.alertView?.snp.top)!).offset(20 * HEIGHT_SCALE)
            make.top.height.equalTo(20 * HEIGHT_SCALE)
        })
        
        // 输入框
        self.codeField?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.alertView?.snp.left)!).offset(15 * WIDTH_SCALE)
            make.top.equalTo((self.titleLabel?.snp.bottom)!).offset(20 * HEIGHT_SCALE)
            make.width.equalTo(rect.size.width - (45 + 90) * WIDTH_SCALE)
            make.height.equalTo(40 * HEIGHT_SCALE)
        })
        
        // 图形码
        self.graphicCodeView?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.codeField?.snp.right)!).offset(15 * WIDTH_SCALE)
            make.top.equalTo((self.titleLabel?.snp.bottom)!).offset(20 * HEIGHT_SCALE)
            make.width.equalTo(90 * WIDTH_SCALE)
            make.height.equalTo(40 * HEIGHT_SCALE)
        })
        
        
        // 横线
        self.lineView?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.alertView?.snp.left)!).offset(15 * WIDTH_SCALE)
            make.top.equalTo((self.codeField?.snp.bottom)!).offset(0.5 * HEIGHT_SCALE)
            make.width.equalTo(self.codeField!)
            make.height.equalTo(0.5 * HEIGHT_SCALE)
        })
        
        // 提交按钮
        self.submitBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.alertView?.snp.left)!).offset(15 * WIDTH_SCALE)
            make.width.equalTo(rect.size.width - 30 * WIDTH_SCALE)
            make.height.equalTo(40 * HEIGHT_SCALE)
            make.bottom.equalTo((self.alertView?.snp.bottom)!).offset(-15 * HEIGHT_SCALE)
        })
    }
    
    
    // 确定按钮点击事件
    func submitClick() -> Void {
        if self.codeField?.text == "" {
            SVProgressHUD .showError(withStatus: "请输入图形验证码")
        } else {
            if self.submitClickBlock != nil {
                self.submitClickBlock!((self.codeField?.text)!)
            }
            // 移除当前View
            dismiss()
        }
    }
    
    // 背景的点击事件
    func backClick() -> Void {
        dismiss()
    }
    
    
    func dismiss() -> Void {
        self .removeFromSuperview()
    }
}
