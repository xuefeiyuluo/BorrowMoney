//
//  BaseCertificaView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2018/3/29.
//  Copyright © 2018年 sparrow. All rights reserved.
//

import UIKit

typealias BaseBlock = (Int) -> Void
class BaseCertificaCell: BasicViewCell {
    let titleView : UIView = UIView()// 头部View
    let certificaView : UIView = UIView()// 认证View
    var promptLabel : UILabel = UILabel()// 头部提示信息
    var certificaBbckImage : UIImageView = UIImageView()// 认证背景图片
    var certificaArray : [String] = [String]()// 基本认证
    var uiArray : [UIView] = [UIView]()// 控件数据
    var baseBlock : BaseBlock?// 认证的回调
    
    
    // 初始化数据
    override func initializationData() {
        super.initializationData()
        
        self.certificaArray = ["基本资料","家庭信息","联系人信息","运营商授权","身份认证","银行卡认证"]
    }
    

    // 创建UI
    override func createUI() {
        super.createUI()
        
        self.backgroundColor = UIColor.white
        
        // 头部View
        createTitleView()
        
        // 认证View
        createCertificaView()
    }
    
    
    // 头部View
    func createTitleView() -> Void {
        self.addSubview(self.titleView)
        self.titleView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(40 * HEIGHT_SCALE)
        }
        
        // 基本认证
        let titleLabel : UILabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16 * WIDTH_SCALE)
        titleLabel.text = "基本认证"
        titleLabel.textColor = TEXT_SECOND_COLOR
        self.titleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.titleView)
            make.left.equalTo(self.titleView.snp.left).offset(25 * WIDTH_SCALE)
        }
        

        self.promptLabel.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
        let termStr : NSMutableAttributedString = NSMutableAttributedString(string: "—  认证完成获10元免息券")
        let termFirstDict = [NSForegroundColorAttributeName:UIColor().colorWithHexString(hex: "808080")]
        termStr.addAttributes(termFirstDict, range: NSMakeRange(0, 8))
        let termSecondDict = [NSForegroundColorAttributeName : UIColor().colorWithHexString(hex: "ff5a30")]
        termStr.addAttributes(termSecondDict, range: NSMakeRange(8, 2))
        let termThirdDict = [NSForegroundColorAttributeName:UIColor().colorWithHexString(hex: "808080")]
        termStr.addAttributes(termThirdDict, range: NSMakeRange(10, 4))
        self.promptLabel.attributedText = termStr
        self.titleView.addSubview(self.promptLabel)
        self.promptLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.right).offset(5 * WIDTH_SCALE)
            make.centerY.equalTo(titleLabel)
        }
    }
    
    
    // 认证View
    func createCertificaView() -> Void {
        self.addSubview(self.certificaView)
        self.certificaView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleView.snp.bottom)
            make.left.right.bottom.equalTo(self)
        }
        
        // 背景图片
        self.certificaBbckImage.image = UIImage (named: "baseCertificaNormal")
        self.certificaBbckImage.contentMode = UIViewContentMode.scaleToFill
        self.certificaBbckImage.isUserInteractionEnabled = true
        self.certificaView.addSubview(self.certificaBbckImage)
        self.certificaBbckImage.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self.certificaView)
        }
        
        
        let view : UIView = UIView()
        self.certificaView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.equalTo(self.certificaView.snp.top).offset(11 * HEIGHT_SCALE)
            make.bottom.equalTo(self.certificaView.snp.bottom).offset(-22 * HEIGHT_SCALE)
            make.left.equalTo(self.certificaView.snp.left).offset(105 * WIDTH_SCALE)
            make.right.equalTo(self.certificaView.snp.right).offset(-20 * WIDTH_SCALE)
        }
        
        //
        let width : CGFloat = (SCREEN_WIDTH - 125 * WIDTH_SCALE) / 3
        let height : CGFloat = (220 - 73) * HEIGHT_SCALE / 2
        for i in 0 ..< 6 {
            let basicView : UIView = UIView()
            basicView.tag = i
            view.addSubview(basicView)
            // 行数
            let row : CGFloat = CGFloat(i / 3)
            // 列数
            let column : CGFloat = CGFloat(i % 3)
            
            basicView.snp.makeConstraints { (make) in
                make.left.equalTo(view.snp.left).offset(column * width)
                make.top.equalTo(view.snp.top).offset(row * height)
                make.width.equalTo(width)
                make.height.equalTo(height)
            }
            let tapClick : UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(tapClick(tap:)))
            basicView.addGestureRecognizer(tapClick)
            
            // 图标
            let iconImage : UIImageView = UIImageView()
            iconImage.tag = 300
            iconImage.image = UIImage (named: "certificaNormal.png")
            iconImage.isUserInteractionEnabled = true
            basicView.addSubview(iconImage)
            iconImage.snp.makeConstraints({ (make) in
                make.centerX.equalTo(basicView)
                make.width.equalTo(40 * WIDTH_SCALE)
                make.height.equalTo(40 * WIDTH_SCALE)
                make.top.equalTo(basicView.snp.top).offset(5 * HEIGHT_SCALE)
            })
            
            // 名称
            let label : UILabel = UILabel()
            label.tag = 400
            label.textAlignment = .center
            label.text = self.certificaArray[i]
            label.font = UIFont.systemFont(ofSize: 13 * WIDTH_SCALE)
            label.textColor = UIColor().colorWithHexString(hex: "666666")
            basicView.addSubview(label)
            label.snp.makeConstraints({ (make) in
                make.left.right.equalTo(basicView)
                make.bottom.equalTo(basicView.snp.bottom).offset(-3 * HEIGHT_SCALE)
            })
            
            self.uiArray.append(basicView)
        }
    }
    
    
    // 认证的点击事件
    func tapClick(tap : UITapGestureRecognizer) -> Void {
        XPrint(tap.view?.tag)
        if self.baseBlock != nil {
            self.baseBlock!((tap.view?.tag)!)
        }
    }
    
    
}
