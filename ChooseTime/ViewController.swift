//
//  ViewController.swift
//  ChooseTime
//
//  Created by yaosixu on 16/6/16.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    let timeLabel = UILabel(frame: CGRect(x: 100, y: 400, width: 100, height: 30))
    let button = UIButton(frame: CGRect(x: 100, y: 300, width: 30, height: 30))
    var customCell : ChooseDateView!
    let weekArray = ["Mon","Tus","Wed","Thu","Fri","Sst","Sun"]
    
    var formDate = NSDate()
    var dateFormat = NSDateFormatter()
    
    override func viewDidLoad() {
        print("\(#function)")
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        title = "Choose Time"
        view.backgroundColor = UIColor.whiteColor()
        let size = CGSize(width: view.bounds.size.width, height: 60)
        let rect = CGRect(x: 0, y: 64, width: size.width, height: size.height)
        customCell = ChooseDateView(frame: rect, itemSize: CGSize(width: size.width / 7,height: size.height), minimumLineSpacing: 0, minimumInteritemSpacing: 0, scrollDirection: .Horizontal)
        customCell.backgroundColor = UIColor.whiteColor()
        customCell.setCollectionView(true, isBounces: false, isShowIndicator: false)
        
        view.addSubview(customCell)
        customCell.registerCollectionViewCell("123", collectionViewCell: ChooseDateItemCollectionViewCell.self)
        customCell.delegateCell = self
        
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        
        dateFormat = format
        formDate = dateFormat.dateFromString("2015-01-05")!
        let days = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: formDate, toDate: NSDate(), options: [])
        customCell.showRowOfSection(0, row: days.day - days.day % 7)
        
        
//        let timeView = ChooseDate(frame: CGRect(x: 0, y: 64, width: UIScreen.mainScreen().bounds.width, height: 70))
//        timeView.delegate = self
//        button.backgroundColor = UIColor.blackColor()
//        button.addTarget(self, action: #selector(ViewController.tapButton), forControlEvents: .TouchUpInside)
//        view.addSubview(timeView)
//        view.addSubview(button)
//        view.addSubview(timeLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getDate(formDate: NSDate, count: Int) -> NSDate {
        return formDate.dateByAddingTimeInterval( 60 * 60 * 24 * Double(count))
    }
    
    
    func tapButton() {
        button.backgroundColor = UIColor.blackColor()
//        timeView.getCellArray()
    }

    func cancelOther(cell: ChooseDateItemCollectionViewCell) {
//        let cellArray = customCell.getCellArray() as! [ChooseDateItemCollectionViewCell]
//        cellArray.forEach({
//            if $0 != cell {
//                $0.isSelect = false
//            }
//        })
    }
}

extension ViewController : ChooseDateViewCellDelegate {
    
    func setCollectionCell(cellIdentifify: String, collectionView: UICollectionView,indexPath: NSIndexPath) -> UICollectionViewCell {
        print("\(#function)")
        if cellIdentifify == "" {
            return UICollectionViewCell()
        }
        let cell =  collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifify, forIndexPath: indexPath) as! ChooseDateItemCollectionViewCell
        cell.weakLabel.text = weekArray[indexPath.row % 7]
        
        let date =  getDate(formDate, count: indexPath.row)
        
        if dateFormat.stringFromDate(date) == dateFormat.stringFromDate(NSDate()) {
            cell.dateLabel.text = "今"
        } else {
            let comps = NSCalendar.currentCalendar().components([NSCalendarUnit.Day], fromDate: date)
            cell.dateLabel.text = "\(comps.day)"
        }
        
        cell.selected = false
        
        return cell
    }
    
    func tapCell(collectionView: UICollectionView, indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ChooseDateItemCollectionViewCell
//        cell.isSelect = true
//        cancelOther(cell)
        
        cell.selected = true
        cell.selectedBackgroundView?.backgroundColor = UIColor.cyanColor()
        
    }
    
}


//extension ViewController : ChooseDateViewDelegate {
//    
//    func curDateChoose(time: TimeInfos) {
//        print("time = \(time)")
//        button.backgroundColor = UIColor.cyanColor()
//    }
//    
//    func firstDateChanged(nowTime: String) {
//        timeLabel.text = nowTime
//    }
//    
//}