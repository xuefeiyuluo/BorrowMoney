//
//  WeChatFocusVC.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/2/26.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

class WeChatFocusVC: BasicVC, UIAlertViewDelegate {

    var weChatImageView : UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
    }
    
    
    
    func createUI() -> Void {
        let backImageView : UIImageView = UIImageView()
        backImageView.image = UIImage (named: "weChatBG.png")
        backImageView.isUserInteractionEnabled = true
        self.view.addSubview(backImageView)
        backImageView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self.view)
        }
        
        self.weChatImageView.image = UIImage (named: "weChat.png")
        self.weChatImageView.isUserInteractionEnabled = true
        backImageView.addSubview(self.weChatImageView)
        self.weChatImageView.snp.makeConstraints { (make) in
            make.left.equalTo(backImageView.snp.left).offset(15 * WIDTH_SCALE)
            make.right.equalTo(backImageView.snp.right).offset(-15 * WIDTH_SCALE)
            make.top.equalTo(backImageView.snp.top).offset(15 * HEIGHT_SCALE)
            make.bottom.equalTo(backImageView.snp.bottom).offset(-70 * HEIGHT_SCALE)
        }
        
        
        let copyBtn : UIButton = UIButton (type: UIButtonType.custom)
        copyBtn.setTitle("复制账号", for: UIControlState.normal)
        copyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17 * WIDTH_SCALE)
        copyBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        copyBtn.setTitleColor(NAVIGATION_COLOR, for: UIControlState.highlighted)
        copyBtn.setBackgroundImage(UIImage().imageCustom(color: UIColor.clear, size: CGSize.init(width: SCREEN_WIDTH - 15 * 3 * WIDTH_SCALE, height: 40 * HEIGHT_SCALE)), for: UIControlState.normal)
        copyBtn.setBackgroundImage(UIImage().imageCustom(color: UIColor.white, size: CGSize.init(width: SCREEN_WIDTH - 15 * 3 * WIDTH_SCALE, height: 40 * HEIGHT_SCALE)), for: UIControlState.highlighted)
        copyBtn.layer.cornerRadius = 2.5
        copyBtn.layer.borderColor = UIColor.white.cgColor
        copyBtn.layer.borderWidth = 1
        copyBtn.layer.masksToBounds = true
        copyBtn.tag = 1000
        copyBtn.addTarget(self, action: #selector(tapClick(sender:)), for: UIControlEvents.touchUpInside)
        backImageView.addSubview(copyBtn)
        copyBtn.snp.makeConstraints { (make) in
            make.left.equalTo(backImageView.snp.left).offset(15 * WIDTH_SCALE)
            make.height.equalTo(40 * HEIGHT_SCALE)
            make.bottom.equalTo(backImageView.snp.bottom).offset(-15 * HEIGHT_SCALE)
            make.width.equalTo((SCREEN_WIDTH - 3 * 15 * WIDTH_SCALE) / 2)
        }
        
        
        let codeBtn : UIButton = UIButton (type: UIButtonType.custom)
        codeBtn.setTitle("保存二维码", for: UIControlState.normal)
        codeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17 * WIDTH_SCALE)
        codeBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        codeBtn.setTitleColor(NAVIGATION_COLOR, for: UIControlState.highlighted)
        codeBtn.setBackgroundImage(UIImage().imageCustom(color: UIColor.clear, size: CGSize.init(width: SCREEN_WIDTH - 15 * 3 * WIDTH_SCALE, height: 40 * HEIGHT_SCALE)), for: UIControlState.normal)
        codeBtn.setBackgroundImage(UIImage().imageCustom(color: UIColor.white, size: CGSize.init(width: SCREEN_WIDTH - 15 * 3 * WIDTH_SCALE, height: 40 * HEIGHT_SCALE)), for: UIControlState.highlighted)
        codeBtn.layer.cornerRadius = 2.5
        codeBtn.layer.borderColor = UIColor.white.cgColor
        codeBtn.layer.borderWidth = 1
        codeBtn.layer.masksToBounds = true
        codeBtn.tag = 1001
        codeBtn.addTarget(self, action: #selector(tapClick(sender:)), for: UIControlEvents.touchUpInside)
        backImageView.addSubview(codeBtn)
        codeBtn.snp.makeConstraints { (make) in
            make.right.equalTo(backImageView.snp.right).offset(-15 * WIDTH_SCALE)
            make.height.equalTo(40 * HEIGHT_SCALE)
            make.bottom.equalTo(backImageView.snp.bottom).offset(-15 * HEIGHT_SCALE)
            make.width.equalTo((SCREEN_WIDTH - 3 * 15 * WIDTH_SCALE) / 2)
        }
    }
    
    
    // 按钮的点击事件
    func tapClick(sender: UIButton) -> Void {
        // 复制账号
        if sender.tag == 1000 {
            let pastboard : UIPasteboard = UIPasteboard.general
            pastboard.string = "jiedianqianwfh"
            let alertView : UIAlertView = UIAlertView (title: "账号jiedianqianwfh已复制入剪切板", message: "", delegate: self as UIAlertViewDelegate, cancelButtonTitle: "待会再说", otherButtonTitles: "飞奔去关注")
            alertView.show()
        // 保存二维码
        } else {
            if XJurisdiction().iPhonePhoto(){
                UIImageWriteToSavedPhotosAlbum(self.weChatImageView.image!, self, #selector(saveImage(image:didFinishSavingWithError:contextInfo:)), nil)
            } else {
                SVProgressHUD.showInfo(withStatus: "啊哦，保存失败了：( 请在系统设置中，允许借点钱app获得“相册”权限。")
            }
        }
    }
    
    
    // MARK: UIAlertViewDelegate
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if buttonIndex == 0 {
        } else {
            // 打开微信
            XPrint("打开微信...")
        }
    }
    
    
    func saveImage(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        if error != nil {
            SVProgressHUD.showError(withStatus: "图片保存失败，请重新尝试")
        } else {
            SVProgressHUD.showSuccess(withStatus: "二维码已保存至相册，打开微信扫一扫即可关注")
        }
    }
    
    
    func image(image:UIImage,didFinishSavingWithError error:NSError?,contextInfo:AnyObject) {
        if error != nil {
            SVProgressHUD.showError(withStatus: "图片保存失败，请重新尝试")
        } else {
            SVProgressHUD.showSuccess(withStatus: "二维码已保存至相册，打开微信扫一扫即可关注")
        }
    }
    

    override func setUpNavigationView() -> () {
        super .setUpNavigationView()
        self.navigationItem .titleView = NaviBarView() .setUpNaviBarWithTitle(title: "关注公众号，福利大放送");
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
