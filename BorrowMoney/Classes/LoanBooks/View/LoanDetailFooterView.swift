//
//  LoanDetailFooterView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/4/17.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias AgreementBlock = (Bool) -> Void
typealias TextProtocolBlock = (String) -> Void
class LoanDetailFooterView: BasicView, UIWebViewDelegate, UITextViewDelegate {
    var agreementSelected : UIButton = UIButton()//
    var webView : UIWebView = UIWebView()// 协议
    var agreeTextView : UITextView = UITextView()// 协议
    var textProtocolBlock : TextProtocolBlock?// TEXT协议的点击事件
    
    
    var agreementBlock : AgreementBlock?// 同意协议的回调
    

    // 创建UI
    override func createUI() {
        super.createUI()
        
        self.agreementSelected.setImage(UIImage (named: "agreeOff.png"), for: UIControlState.normal)
        self.agreementSelected.setImage(UIImage (named: "agreeOn.png"), for: UIControlState.selected)
        self.agreementSelected.addTarget(self, action: #selector(agreementClick), for: UIControlEvents.touchUpInside)
        self.agreementSelected.isSelected = true
        self.addSubview(self.agreementSelected)
        self.agreementSelected.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(5 * WIDTH_SCALE)
            make.top.equalTo(self.snp.top).offset(5 * HEIGHT_SCALE)
            make.width.height.equalTo(30 * WIDTH_SCALE)
        }
        
        // 协议方式一 http
        self.webView.backgroundColor = UIColor.clear
        self.webView.scalesPageToFit = true
        self.webView.delegate = self
        self.addSubview(self.webView)
        self.webView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(5 * HEIGHT_SCALE)
            make.left.equalTo(self.agreementSelected.snp.right).offset(5 * WIDTH_SCALE)
            make.right.equalTo(self.snp.right).offset(-10 * WIDTH_SCALE)
            make.bottom.equalTo(self.snp.bottom).offset(-10 * HEIGHT_SCALE)
        }
        
        // 协议方式二 text
        self.agreeTextView.backgroundColor = UIColor.clear
        self.agreeTextView.delegate = self
        self.agreeTextView.isEditable = false
        self.addSubview(self.agreeTextView)
        self.agreeTextView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(5 * HEIGHT_SCALE)
            make.left.equalTo(self.agreementSelected.snp.right).offset(5 * WIDTH_SCALE)
            make.right.equalTo(self.snp.right).offset(-10 * WIDTH_SCALE)
            make.bottom.equalTo(self.snp.bottom).offset(-10 * HEIGHT_SCALE)
        }
    }
    
    
    //MARK:UIWebViewDelegate
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
    }
    
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
    }
    
    
    // MARK:UITextViewDelegate
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        if self.textProtocolBlock != nil {
            self.textProtocolBlock!(URL.absoluteString)
        }
        return false
    }
    
    
    // 更新协议
    func updateAgreementData(loanDetailModel : LoanDetailModel) -> Void {
        if loanDetailModel.loanAgreementType == "http" {
            self.webView.isHidden = false
            self.agreeTextView.isHidden = true
            var path : String = Bundle.main.path(forResource: "loanDetailAgreement", ofType: "html")!
            path = path.replacingOccurrences(of: "protocol", with: loanDetailModel.loanAgreement)
            let urlStr = NSURL.fileURL(withPath:path)
            self.webView.loadRequest(NSURLRequest.init(url: urlStr) as URLRequest)
        } else {
            self.webView.isHidden = true
            self.agreeTextView.isHidden = false
            let attString : NSMutableAttributedString = NSMutableAttributedString.init(string:loanDetailModel.loanAgreementText as String)
            attString.setAttributes([NSForegroundColorAttributeName : LINE_COLOR3,NSFontAttributeName : UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)], range: NSMakeRange(0, 5))
            var index : Int = 5;
            for dict : NSDictionary in loanDetailModel.loanAgreementNew {
                let name : String = dict.stringForKey(key: "name")
                let url : String = dict.stringForKey(key: "url")
                attString.setAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 12 * WIDTH_SCALE),NSLinkAttributeName : url], range: NSMakeRange(index, name.count + 2))
                index = index + name.count + 2
            }
            // 设置合同协议的颜色
            self.agreeTextView.linkTextAttributes = [NSForegroundColorAttributeName : NAVIGATION_COLOR]
            self.agreeTextView.attributedText = attString
        }
    }

    
    
    // 同意协议的点击事件
    func agreementClick() -> Void {
        self.agreementSelected.isSelected = !self.agreementSelected.isSelected
        if self.agreementBlock != nil {
            self.agreementBlock!(self.agreementSelected.isSelected)
        }
    }
}
