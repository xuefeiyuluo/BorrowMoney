//
//  RollPictureView.swift
//  BorrowMoney
//
//  Created by 雪飞雨落 on 2017/11/30.
//  Copyright © 2017年 sparrow. All rights reserved.
//

import UIKit

typealias RollImageBlock = (Int) -> Void
class RollPictureView: UIView, UIScrollViewDelegate {

    var rollImageBlock : RollImageBlock?//
    var rollScrollView : UIScrollView?//
    var letfImageView : UIImageView?// 左边的image
    var midImageView : UIImageView?// 中间的image
    var rightImageView : UIImageView?// 右边的image
    var currentNumber : Int = 0// 当前图片显示
    var imageArray : NSArray?// 数据源
    var imageTimer : Timer?// 图片的定时器
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 创建界面
        createUI()
        
        // 滚动图片的定时器
        createTimer()
    }
    
    
    // 创建界面
    func createUI() -> Void {
        let rollScrollView : UIScrollView = UIScrollView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 95 * HEIGHT_SCALE))
        rollScrollView.contentOffset = CGPoint(x: SCREEN_WIDTH, y: 0)
        rollScrollView.showsHorizontalScrollIndicator = false
        rollScrollView.isPagingEnabled = true
        rollScrollView.bounces = false
        rollScrollView.delegate = self
        rollScrollView.contentSize = CGSize (width: SCREEN_WIDTH * 3, height: self.frame.height)
        self.rollScrollView = rollScrollView
        self.addSubview(rollScrollView)
        
        // 左边的imageView
        let leftImage : UIImageView = UIImageView.init(frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: 95 * HEIGHT_SCALE))
        leftImage.isUserInteractionEnabled = true
        leftImage.backgroundColor = UIColor.red
        self.letfImageView = leftImage
        rollScrollView.addSubview(self.letfImageView!)
        
        // 中间的imageView
        let midImage : UIImageView = UIImageView.init(frame: CGRect (x: SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: 95 * HEIGHT_SCALE))
        midImage.isUserInteractionEnabled = true
        midImage.backgroundColor = UIColor.green
        self.midImageView = midImage
        rollScrollView.addSubview(self.midImageView!)
        
        // 右边的imageView
        let rightImage : UIImageView = UIImageView.init(frame: CGRect (x: SCREEN_WIDTH * 2, y: 0, width: SCREEN_WIDTH, height: 95 * HEIGHT_SCALE))
        rightImage.isUserInteractionEnabled = true
        rightImage.backgroundColor = UIColor.yellow
        self.rightImageView = rightImage
        rollScrollView.addSubview(self.rightImageView!)
        
        let tapClick : UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(rollTapClick))
        self.addGestureRecognizer(tapClick)
    }
    
    
    // 滚动图片的定时器
    func createTimer() -> Void {
        if self.imageTimer == nil {
            self.imageTimer = Timer (timeInterval: 5, target: self, selector: #selector(imageChange), userInfo: nil, repeats: true)
            RunLoop.main.add(self.imageTimer!, forMode: RunLoopMode.commonModes)
        }
    }

    
    // MARK: UIScrollViewDelegate
    // 当用户手动个轮播时 关闭定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.imageTimer?.invalidate()
        self.imageTimer = nil
    }
    
    
    // 当用户手指停止滑动图片时 启动定时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        createTimer()
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset : CGPoint = scrollView.contentOffset
        if offset.x == 2 * (self.rollScrollView?.frame.size.width)! {
            self.currentNumber = (self.currentNumber + 1 + (self.imageArray?.count)!)  % (self.imageArray?.count)!
        } else if offset.x == 0 {
            self.currentNumber = (self.currentNumber - 1 + (self.imageArray?.count)!)  % (self.imageArray?.count)!
        } else {
            return
        }
        
        // 改变轮播图的当前 前一张 后一张 图片
        changeImageView(imageNumber: self.currentNumber)
        self.rollScrollView?.contentOffset = CGPoint(x: SCREEN_WIDTH, y: 0)
    }
    
    
    // 图片定时器
    func imageChange() -> Void {
        self.currentNumber = (self.currentNumber + 1 + (self.imageArray?.count)!)  % (self.imageArray?.count)!
        //设置后没有效果，而且数据错乱
//        self.rollScrollView?.setContentOffset(CGPoint(x: 750, y: 0), animated: true)
        changeImageView(imageNumber: self.currentNumber)
        self.rollScrollView?.contentOffset = CGPoint(x: SCREEN_WIDTH, y: 0)
    }
    
    
    // 改变轮播图的当前 前一张 后一张 图片
    func changeImageView(imageNumber : Int) -> Void {
        let leftIndex = (imageNumber - 1 + (self.imageArray?.count)!) % (self.imageArray?.count)!
        let leftModel : BannerModel = self.imageArray![leftIndex] as! BannerModel
        self.letfImageView?.kf.setImage(with: URL (string: leftModel.logo!))
        
        let midIndex = (imageNumber + (self.imageArray?.count)! ) % (self.imageArray?.count)!
        let midMOdel : BannerModel = self.imageArray![midIndex] as! BannerModel
        self.midImageView?.kf.setImage(with: URL (string: midMOdel.logo!))

        let rightIndex = (imageNumber + 1 + (self.imageArray?.count)!) % (self.imageArray?.count)!
        let rightModel : BannerModel = self.imageArray![rightIndex] as! BannerModel
        self.rightImageView?.kf.setImage(with: URL (string: rightModel.logo!))
    }
    
    
    // 图片的点击事件
    func rollTapClick() -> Void {
        if self.rollImageBlock != nil {
            self.rollImageBlock!(self.currentNumber)
        }
    }
    
    
    // 数据源
    func updateRollImageDate(dateArray : NSArray) -> Void {
        if dateArray.count == 0 {
            self.imageTimer?.invalidate()
            self.imageTimer = nil
            return
        }
        self.imageArray = dateArray
        if dateArray.count >= 2 {
            let leftIndex = (self.currentNumber - 1 + dateArray.count) % dateArray.count
            let leftModel : BannerModel = dateArray[leftIndex] as! BannerModel
            self.letfImageView?.kf.setImage(with: URL (string: leftModel.logo!))
            
            let midIndex = (self.currentNumber + dateArray.count ) % dateArray.count
            let midMOdel : BannerModel = dateArray[midIndex] as! BannerModel
            self.midImageView?.kf.setImage(with: URL (string: midMOdel.logo!))
            
            let rightIndex = (self.currentNumber + 1 + dateArray.count) % dateArray.count
            let rightModel : BannerModel = dateArray[rightIndex] as! BannerModel
            self.rightImageView?.kf.setImage(with: URL (string: rightModel.logo!))
        }else if dateArray.count == 1 {
            self.rollScrollView?.isScrollEnabled = false
            let midMOdel : BannerModel = dateArray[0] as! BannerModel
            self.midImageView?.kf.setImage(with: URL (string: midMOdel.logo!))
        }
    }
}
