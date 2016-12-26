//
//  CSMenuView.swift
//  Swift3InfiniteRotate
//
//  Created by macbook air on 16/12/17.
//  Copyright © 2016年 yundian. All rights reserved.
//

import UIKit
private let kMenuCellID = "kMenuCellID"
//代理
protocol CSMenuViewDelegate : class {
    func menuView(_ menuView : CSMenuView, selectedPage: Int, indexInPage index: Int, indexInAllData : Int)
}

class CSMenuView: UIView {
    //MARK: -- 定义属性
    weak var delegate : CSMenuViewDelegate?
    
    @IBOutlet weak var pageControl: UIPageControl!

    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageArray : [String]? = nil {
        
        didSet {
            collectionView.reloadData()
        }
    }
    
    var titleArray : [String]? = nil {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var itemsOfPage : Int = 8 {//每页几个item
        didSet {
            collectionView.reloadData()
        }
    }
    
    var imageViewSize : CGSize = CGSize(width: 48, height: 48) {
        
        didSet {
            collectionView.reloadData()
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //让空间不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        //注册Cell
        collectionView.register(UINib.init(nibName: "CSMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    }
    
    deinit {
        print("YLMenuView销毁了")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //重新设置布局
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}

//MARK: xib创建的类方法
extension CSMenuView {
    class func csMenuView() -> CSMenuView {
        return Bundle.main.loadNibNamed("CSMenuView", owner: nil, options: nil)?.first as! CSMenuView
    }
}

//MARK: UICollectionViewDataSource
extension CSMenuView : UICollectionViewDataSource, CSMenuViewCellDelegate{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if imageArray == nil {
            return 0
        }
        //计算有多少页的算法
        let pageNum = (imageArray!.count - 1) / itemsOfPage + 1
        pageControl.numberOfPages = pageNum
        return pageNum
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! CSMenuViewCell
        cell.delegate = self
        setupCelldataWithCell(cell: cell, indexPath: indexPath)
        cell.itemsOfPage = self.itemsOfPage
        cell.imageViewSize = self.imageViewSize
        return cell
    }

    private func setupCelldataWithCell(cell : CSMenuViewCell, indexPath : IndexPath) {
        
        //0页 0--7
        //1页 8--15
        //2页 16--23
        //取出起点位置
        let startIndex = indexPath.item * itemsOfPage
        //终点位置
        var endIndex = (indexPath.item + 1) * itemsOfPage - 1
        //判断越界问题
        if endIndex > imageArray!.count - 1 {
            endIndex = imageArray!.count - 1
        }
        //取出每一页的子cell数据，并且赋值给cell
        cell.imageArray = Array(imageArray![startIndex...endIndex])
        cell.titleArray = Array(titleArray![startIndex...endIndex])
        
    }
    
    func menuViewCell(_ menuViewCell : CSMenuViewCell, selectedIndex index : Int) {
        
        //为了便于数组计算这里的数字起算从0开始。也就是第八个数据实际上是第九个。array[8].取出的是第九个元素
        
        self.delegate?.menuView(self, selectedPage: pageControl.currentPage, indexInPage: index, indexInAllData: pageControl.currentPage * itemsOfPage + index)
        print("当前点击的页数下标是：\(pageControl.currentPage),页数中item下标是：\(index)，它在总数组的下标是：\(pageControl.currentPage * itemsOfPage + index)")
        
    }
}

//MARK: -- UICollectionViewDelegate
extension CSMenuView : UICollectionViewDelegate {
    
    
    //设置page的变化
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
