//
//  ChooseDateItemCollectionViewCell.swift
//  ChooseTime
//
//  Created by yaosixu on 16/6/20.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class ChooseDateItemCollectionViewCell: UICollectionViewCell {
 
    var weakLabel = UILabel()
    var dateLabel = UILabel()
//    var mask = UIView()
    
        
//    var isSelect  = false {
//        didSet{
//            if isSelect {
//                mask.backgroundColor = UIColor.cyanColor()
//            } else {
//                mask.backgroundColor = UIColor.clearColor()
//            }
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        
        weakLabel = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height * 0.4))
        dateLabel = UILabel(frame: CGRect(x: 0, y: bounds.height * 0.4, width: bounds.width, height: bounds.height * 0.4))
//        mask = UIView(frame: bounds)
        
        weakLabel.textAlignment = .Center
        dateLabel.textAlignment = .Center
//        mask.backgroundColor = UIColor.clearColor()
        
//        selectedBackgroundView = mask
        selectedBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        addSubview(weakLabel)
        addSubview(dateLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
