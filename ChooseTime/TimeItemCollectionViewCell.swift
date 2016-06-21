//
//  TimeItemCollectionViewCell.swift
//  ChooseTime
//
//  Created by yaosixu on 16/6/16.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

struct TimeInfos {
    var year = 0
    var month = 0
    var day = 0
    var dayString = ""
}

let weekArray : [String] = ["Mon","Tues","Wed","Thur","Fri","Sat","Sun"]

class DateItemCollectionViewCell: UICollectionViewCell {
    
    /**  maskView的背景颜色 */
    var maskViewColor : UIColor = UIColor ( red: 0.8157, green: 0.8157, blue: 0.8157, alpha: 1.0 ) {
        didSet {
            maskview.backgroundColor = maskViewColor
        }
    }
    
    /** 是否选中 */
    var isSelect  = false {
        didSet{
            if isSelect {
                maskview.backgroundColor = maskViewColor
            } else {
                maskview.backgroundColor = UIColor.clearColor()
            }
        }
    }
    
    /**  weekLable字体颜色 */
    var weekLabelTextColor : UIColor = UIColor ( red: 0.4706, green: 0.4706, blue: 0.4706, alpha: 1.0 ) {
        didSet {
            weekLabel.textColor = weekLabelTextColor
        }
    }
    
    /** 日期字体颜色 */
    var dateLabelTextColor : UIColor = UIColor.blackColor() {
        didSet {
            dateLabel.textColor = dateLabelTextColor
        }
    }
    
    /** 选中时的图片 */
   var maskview : UIView!
    
    /** 时间信息 */
    var dateInfo = TimeInfos()
    
    /** 时间*/
    var dateLabel :UILabel!
    /** 星期*/
     var weekLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.whiteColor()
        
        maskview = UIView(frame: CGRect(x: 0, y: -100, width: contentView.bounds.width, height: 100 + contentView.bounds.height * 0.8))
        maskview.layer.cornerRadius = maskview.bounds.size.width / 2
        maskview.layer.masksToBounds = true
        contentView.addSubview(maskview)
        
        weekLabel = UILabel(frame: CGRect(x: 0, y: 0, width: contentView.bounds.width, height: contentView.bounds.height * 0.4))
        weekLabel.textAlignment = .Center
        contentView.addSubview(weekLabel)
        
        dateLabel = UILabel(frame: CGRect(x: 0, y: contentView.bounds.height * 0.4, width: contentView.bounds.width, height:  contentView.bounds.height * 0.4))
        dateLabel.textAlignment = .Center
        contentView.addSubview(dateLabel)

        
        weekLabel.text = "123"
        dateLabel.text = "qwe"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initContentView(indexPath: Int,dateArray: [NSDate]) {
        contentView.backgroundColor = UIColor.whiteColor()
        
        maskview = UIView(frame: CGRect(x: 0, y: -100, width: contentView.bounds.width, height: 100 + contentView.bounds.height * 0.8))
        maskview.layer.cornerRadius = maskview.bounds.size.width / 2
        maskview.layer.masksToBounds = true
        contentView.addSubview(maskview)

        weekLabel = UILabel(frame: CGRect(x: 0, y: 0, width: contentView.bounds.width, height: contentView.bounds.height * 0.4))
        weekLabel.textAlignment = .Center
        contentView.addSubview(weekLabel)
        
        dateLabel = UILabel(frame: CGRect(x: 0, y: contentView.bounds.height * 0.4, width: contentView.bounds.width, height:  contentView.bounds.height * 0.4))
        dateLabel.textAlignment = .Center
        contentView.addSubview(dateLabel)
        
//        dateInfo = dateArray[indexPath]
        if dateArray[indexPath] == NSDate() {
            dateLabel.text = "今"
        } else {
            let  comp =  NSCalendar.currentCalendar().components([NSCalendarUnit.Year,NSCalendarUnit.Month,NSCalendarUnit.Weekday,NSCalendarUnit.Day], fromDate: dateArray[indexPath])
            
            dateLabel.text = "\(comp.day)"
        }
        
        weekLabel.text = weekArray[indexPath % 7]
        
        self.layer.masksToBounds = true
    }
    
//    override func prepareForReuse() {
//        self.contentView.subviews.forEach({
//            $0.removeFromSuperview()
//        })
//    }
    
}
