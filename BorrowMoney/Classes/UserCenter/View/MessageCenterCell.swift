//
//  MessageCenterCell.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/27.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

class MessageCenterCell: UITableViewCell {
    var iconImageView : UIImageView?// 图标
    var signView : UIImageView?// 红点
    var typeLabel : UILabel?// 活动类型
    var timeLabel : UILabel?// 时间
    var contentLabel : UILabel?// 活动内容
    var messageModel : MessageCenterModel?{
        didSet{
            // 信息类型图片  消息类型    热门活动(rmhd)/精品推荐(jptj)/生命周期(smzq)/个人消息(grxx)/公告信息
            if messageModel?.msg_type == "rmhd" {
                self.iconImageView?.image = UIImage (named: "ic_rmhd.png")
                self.typeLabel?.text = "热门活动:"
            } else if messageModel?.msg_type == "ggxx" {
                self.iconImageView?.image = UIImage (named: "ic_ggxx.png")
                self.typeLabel?.text = "公告消息:"
            } else if messageModel?.msg_type == "jptj" {
                self.iconImageView?.image = UIImage (named: "ic_jptj.png")
                self.typeLabel?.text = "精品推荐:"
            } else {
                self.iconImageView?.image = UIImage (named: "ic_xtxx.png")
                self.typeLabel?.text = "系统消息:"
            }
            
            // 时间
            self.timeLabel?.text = messageModel?.time
            
            // 内容
            self.contentLabel?.text = messageModel?.content
            
            // 是否已读
            if messageModel?.status == "new" {
                self.signView?.isHidden = false
                self.typeLabel?.textColor = UIColor().colorWithHexString(hex: "383838")
                self.timeLabel?.textColor = TEXT_BLACK_COLOR
                self.contentLabel?.textColor = TEXT_BLACK_COLOR
            } else {
                self.signView?.isHidden = true
                self.typeLabel?.textColor = UIColor().colorWithHexString(hex: "AAAAAA")
                self.timeLabel?.textColor = UIColor().colorWithHexString(hex: "AAAAAA")
                self.contentLabel?.textColor = UIColor().colorWithHexString(hex: "AAAAAA")
            }
        }
    }
    
 
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // 创建界面
    func createUI() -> Void {
        // 图标
        let iconImage : UIImageView = UIImageView()
        self.iconImageView = iconImage
        self.contentView .addSubview(self.iconImageView!)
        self.iconImageView?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.height.width.equalTo(50 * HEIGHT_SCALE)
            make.left.equalTo(self.contentView.snp.left).offset(10 * WIDTH_SCALE)
        })
        
        
        // 红点
        let signView = UIImageView()
        signView.image = UIImage (named: "messageSign.png")
        self.layer.cornerRadius = 9 / 2
        signView.layer.masksToBounds = true
        signView.contentMode = .center
        self.signView = signView
        self.contentView .addSubview(self.signView!)
        self.signView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentView.snp.top).offset(9 * HEIGHT_SCALE)
            make.height.width.equalTo(9 * HEIGHT_SCALE)
            make.left.equalTo((self.iconImageView?.snp.right)!).offset(-5 * WIDTH_SCALE)
        })
        
        
        // 活动类型
        let typeLabel = UILabel()
        typeLabel.font = UIFont .boldSystemFont(ofSize: 16 * WIDTH_SCALE)
        self.typeLabel = typeLabel
        self.contentView .addSubview(self.typeLabel!)
        self.typeLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.signView?.snp.right)!).offset(12 * WIDTH_SCALE)
            make.top.equalTo(self.contentView.snp.top).offset(13 * HEIGHT_SCALE)
        })
        
        
        // 时间
        let timeLabel = UILabel()
        timeLabel.font = UIFont .systemFont(ofSize: 13 * WIDTH_SCALE)
        self.timeLabel = timeLabel
        self.contentView .addSubview(self.timeLabel!)
        self.timeLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-10 * WIDTH_SCALE)
            make.bottom.equalTo((self.typeLabel?.snp.bottom)!)
        })
        
        
        // 内容
        let contentLabel = UILabel()
        contentLabel.font = UIFont .systemFont(ofSize: 13 * WIDTH_SCALE)
        contentLabel.numberOfLines = 2
        self.contentLabel = contentLabel
        self.contentView .addSubview(self.contentLabel!)
        self.contentLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.signView?.snp.right)!).offset(12 * WIDTH_SCALE)
            make.right.equalTo(self.contentView.snp.right).offset(-10 * WIDTH_SCALE)
            make.top.equalTo((self.typeLabel?.snp.bottom)!).offset(6 * HEIGHT_SCALE)
        })
        
        // 横线
        let lineView : UIView = UIView()
        lineView.backgroundColor = LINE_COLOR2
        self.contentView .addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(self.contentView)
            make.height.equalTo(0.5 * HEIGHT_SCALE)
            make.left.equalTo((self.signView?.snp.left)!).offset(12 * WIDTH_SCALE)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
