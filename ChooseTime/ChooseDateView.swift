//
//  ChooseDateView.swift
//  ChooseTime
//
//  Created by yaosixu on 16/6/20.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

/**  自定义cell */
protocol ChooseDateViewCellDelegate {
    /** 设置cell */
    func setCollectionCell(cellIdentifify: String,collectionView: UICollectionView,indexPath: NSIndexPath) -> UICollectionViewCell
    /** 点击cell时发生 */
    func tapCell(collectionView: UICollectionView, indexPath: NSIndexPath)
}

class ChooseDateView: UIView {
    
    private var collection : UICollectionView!
    private var cellIdentify : String = ""
    private var collectionCell : UICollectionViewCell!
    
    /** 设置cell的内容，和点击cell时发生的动作 */
    var delegateCell : ChooseDateViewCellDelegate!
    /** section 数量默认为1 */
    var sectionNum : Int = 1
    /** 一个section里面的cell个数，默认为70000 */
    var cellInSectionNum : Int = 70000
    
    /** 初始化collection 设置uiview的frame,以及collectionview的cell大小，cell间的距离，以及滑动方向 */
    init(frame: CGRect,itemSize: CGSize,minimumLineSpacing: CGFloat,minimumInteritemSpacing: CGFloat,scrollDirection:UICollectionViewScrollDirection) {
        super.init(frame: frame)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = itemSize
        flowLayout.minimumLineSpacing = minimumLineSpacing
        flowLayout.minimumInteritemSpacing = minimumInteritemSpacing
        flowLayout.scrollDirection = scrollDirection
        
        collection = UICollectionView(frame: bounds, collectionViewLayout: flowLayout)
        self.addSubview(collection)
        collection.backgroundColor = UIColor.whiteColor()
        collection.delegate = self
        collection.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /** 注册UICollectionViewCell */
    func registerCollectionViewCell(cellIdentify: String,collectionViewCell: AnyClass) {
         self.cellIdentify = cellIdentify
         collection.registerClass(collectionViewCell.self, forCellWithReuseIdentifier: cellIdentify)
    }
    
    /** 从xib注册cell */
    func registerColletionViewFormXib(nibName: String, cellIdentifier: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        collection.registerNib(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    /**  设置collectionView属性,是否分页，滑动时是否有弹性 ,是否显示滚动条*/
    func setCollectionView(isPaging: Bool, isBounces: Bool,isShowIndicator: Bool) {
        collection.pagingEnabled = isPaging
        collection.bounces = isBounces
        collection.showsVerticalScrollIndicator = isShowIndicator
        collection.showsHorizontalScrollIndicator = isShowIndicator
    }
    
    /** 默认从第几个section的第一个cell开始显示，默认为0，0 */
    func showRowOfSection(section: Int = 0,row: Int  = 0) {
       collection.scrollToItemAtIndexPath(NSIndexPath(forRow: row,inSection: section), atScrollPosition: .Left, animated: true)
    }
    
    /** 获取当前屏幕上显示的cell的indexPath 类型为NSIndexPath 返回值为[NSIndexPath] */
    func getIndexPaths() -> [NSIndexPath] {
        return collection.indexPathsForVisibleItems()
    }
    
    /** 返回当前屏幕上的cell，返回值类型为[UICollectionViewCell] */
    func getCellArray() -> [UICollectionViewCell] {
        return collection.visibleCells()
    }
    
}

extension ChooseDateView : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return sectionNum
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellInSectionNum
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return delegateCell.setCollectionCell(cellIdentify,collectionView: collectionView,indexPath: indexPath)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        delegateCell.tapCell(collectionView, indexPath: indexPath)
    }
    
}
