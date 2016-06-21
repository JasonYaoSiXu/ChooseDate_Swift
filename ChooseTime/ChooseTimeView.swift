//
//  ChooseTimeView.swift
//  ChooseTime
//
//  Created by yaosixu on 16/6/16.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

protocol ChooseDateViewDelegate {
    func curDateChoose(time: TimeInfos)
    func firstDateChanged(nowTime: String)
}

class ChooseDate: UIView,UIScrollViewDelegate {
    
    var collection : UICollectionView!
    let collectionCell = "collectionCell"
    var cellArray : [DateItemCollectionViewCell] = []
//    var dateArray : [TimeInfos] = []
    var dateArray : [NSDate] = []
    let numberOfCell = 70000
    var startIndex = 0
    var delegate : ChooseDateViewDelegate!
    var nowTime : String = ""
    var contentOffSetX : CGFloat = 0
    
    /**  collectionView cell 颜色配置 */
    var maskViewColor : UIColor = UIColor ( red: 0.8157, green: 0.8157, blue: 0.8157, alpha: 1.0 )
    var weekLabelTextColor : UIColor = UIColor ( red: 0.4706, green: 0.4706, blue: 0.4706, alpha: 1.0 )
    var dateLableTextColor : UIColor = UIColor.blackColor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: bounds.size.width / 7, height: bounds.size.height)
        startIndex = numberOfCell / 2
        
        collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height), collectionViewLayout: flowLayout)
        initCollectionView()
//        initDateArray()
//        initDateArrays(NSDate())
        collection.scrollToItemAtIndexPath(NSIndexPath(forRow: startIndex,inSection: 0), atScrollPosition: .Left, animated: true)
        
//        collection.scrollToItemAtIndexPath(NSIndexPath(forRow: 7,inSection: 0), atScrollPosition: .Left, animated: true)
        addSubview(collection)
        self.contentOffSetX = collection.contentOffset.x
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //初始化collectionView
    func initCollectionView() {
        collection.delegate = self
        collection.dataSource = self
        collection.pagingEnabled =  true
        collection.showsHorizontalScrollIndicator = false
        collection.bounces = false
        collection.registerClass(DateItemCollectionViewCell.self, forCellWithReuseIdentifier: collectionCell)
    }
    
    /** 初始化时间数组 */
//    func initDateArrays(nowDate: NSDate) {
//        
////        let nowDate = NSDate()
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let nowDateStr = dateFormatter.stringFromDate(nowDate)
//
//        let  comp =  NSCalendar.currentCalendar().components([NSCalendarUnit.Year,NSCalendarUnit.Month,NSCalendarUnit.Weekday,NSCalendarUnit.Day], fromDate: nowDate)
//        let week = comp.weekday
//        var addIndex = 0
//
//        if week == 1 {
//            addIndex = 7
//        } else {
//            addIndex = week - 1
//        }
//
//        for i in  1...7 {
//            var date = NSDate()
//
//            if i < addIndex {
//                date = getDate(nowDate, count: -(addIndex - i))
//            } else if i >  addIndex {
//                date = getDate(nowDate, count: (i - addIndex))
//            } else {
//                date = nowDate
//            }
////            let  comp =  NSCalendar.currentCalendar().components([NSCalendarUnit.Year,NSCalendarUnit.Month,NSCalendarUnit.Weekday,NSCalendarUnit.Day], fromDate: date)
////            var dateInto = TimeInfos()
////
////            dateInto.year = comp.year
////            dateInto.month = comp.month
////            dateInto.day = comp.day
////            dateInto.dayString = "\(dateInto.day)"
//            
//            let dateStr = dateFormatter.stringFromDate(date)
////            if dateStr == nowDateStr {
////                dateInto.dayString = "今"
////            }
////            dateArray.insert(dateInto, atIndex: i - 1)
//            dateArray.insert(date, atIndex: i - 1)
//        }
//    }
    
    /**  根据今天计算前后的日期 */
    func getDate(date: NSDate,count: Int) -> NSDate {
        return date.dateByAddingTimeInterval( 60 * 60 * 24 * Double(count))
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("before = \(contentOffSetX)")
        print("after = \(collection.contentOffset.x)")
        
        
        if scrollView.description == "" {
            
        }
        
        if contentOffSetX - collection.contentOffset.x  <  -30 {
            let last = dateArray[dateArray.count - 1]
            dateArray.removeAll()
            for i in 1...7 {
                let date = getDate(last, count: i)
                dateArray.insert(date, atIndex: i - 1)
            }
        } else if contentOffSetX  -  collection.contentOffset.x  > 30 {
            let first = dateArray[0]
            dateArray.removeAll()
            for i in 1...7 {
                let date = getDate(first, count: -(8 - i))
                dateArray.insert(date, atIndex: i - 1)
            }
        }
        self.contentOffSetX = collection.contentOffset.x
        collection.reloadData()
    }
    
    /** 初始化时间数组 */
//    func initDateArray(nowDate: NSDate) {
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let nowDateStr = dateFormatter.stringFromDate(nowDate)
//        
//        let  comp =  NSCalendar.currentCalendar().components([NSCalendarUnit.Year,NSCalendarUnit.Month,NSCalendarUnit.Weekday,NSCalendarUnit.Day], fromDate: nowDate)
//        let week = comp.weekday
//        var addIndex = 0
//        
//        if week == 1 {
//            addIndex = 7
//        } else {
//            addIndex = week - 1
//        }
//        
//        for i in 1...numberOfCell {
//            var date = NSDate()
//            
//            if i < startIndex + addIndex {
//                date = getDate(nowDate, count: -(startIndex + addIndex - i))
//            } else if i > startIndex + addIndex {
//                date = getDate(nowDate, count: i - (startIndex + addIndex) )
//            } else {
//                date = nowDate
//            }
//            let  comp =  NSCalendar.currentCalendar().components([NSCalendarUnit.Year,NSCalendarUnit.Month,NSCalendarUnit.Weekday,NSCalendarUnit.Day], fromDate: date)
//            var dateInto = TimeInfos()
//            
//            dateInto.year = comp.year
//            dateInto.month = comp.month
//            dateInto.day = comp.day
//            dateInto.dayString = "\(dateInto.day)"
//            
//            let dateStr = dateFormatter.stringFromDate(date)
//            if dateStr == nowDateStr {
//                dateInto.dayString = "今"
//            }
//            dateArray.insert(dateInto, atIndex: i - 1)
//        }
//    }

    /** 获取当前界面显示的所有cell*/
    func getCellArray() {
//        guard let cellArray = collection.visibleCells () as? [DateItemCollectionViewCell] else {
//            return
//        }
//        
//        cellArray.forEach({
//            $0.isSelect = false
//        })
    }
    
    /** 选中一个时间后，取消对其他时间的选择 */
    func chooseItem(cell: DateItemCollectionViewCell) {
//        delegate.curDateChoose(cell.dateInfo)
//        guard let cellArray = collection.visibleCells () as? [DateItemCollectionViewCell] else {
//            return
//        }
//        
//        cellArray.forEach({
//            if $0 == cell {
//                $0.isSelect = true
//            } else {
//                $0.isSelect = false
//            }
//        })
    }
    
}

extension ChooseDate : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  numberOfCell
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionCell, forIndexPath: indexPath) as? DateItemCollectionViewCell else {
            return UICollectionViewCell()
        }
//        cell.initContentView(indexPath.row % 7,dateArray:dateArray)
//        
//        cell.maskViewColor = maskViewColor
//        cell.weekLabelTextColor = weekLabelTextColor
//        cell.dateLabelTextColor = dateLableTextColor
//        cell.isSelect = false
//        
//        if indexPath.row % 7 == 0 {
//            delegate.firstDateChanged("\(cell.dateInfo.year)年\(cell.dateInfo.month)月")
//        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard  let cell = collection.cellForItemAtIndexPath(indexPath) as? DateItemCollectionViewCell else {
            return
        }
        chooseItem(cell)
    }
}
