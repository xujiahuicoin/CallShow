//
//  CSID_CallShowListCommView.swift
//  CallShow
//
//  Created by MAC on 26/11/2019.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit

class CSID_CallShowListCommView: UIView,UICollectionViewDelegate,UICollectionViewDataSource{

    
    var listdataArr : NSArray = NSArray.init()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(CSID_CallShow_RecommlistCollView)
    }
    
    public func csid_CallShow_recommCollectViewRefresh(needArray:NSArray) -> Void {
        
        if needArray.count>0 {
            listdataArr=needArray[0] as! NSArray
            CSID_CallShow_RecommlistCollView.reloadData()
        }
    }
    lazy var CSID_CallShow_RecommlistCollView : UICollectionView = {
        
        var layout = UICollectionViewFlowLayout()
        //设置每一个cell_View的宽高
        layout.itemSize = CGSize(width:CSID_WidthScreen,height:CSID_heightScreen+CSID_Status_H)
        
        //设置最小的行间距
        layout.minimumLineSpacing = 0
        //设置最小的列间距
        layout.minimumInteritemSpacing = 0
        
        let CSID_CallShow_RecommlistCollView : UICollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: CSID_WidthScreen, height: CSID_heightScreen+CSID_Status_H), collectionViewLayout: layout)
        CSID_CallShow_RecommlistCollView.backgroundColor = UIColor.white
    CSID_CallShow_RecommlistCollView.register(CSID_CallShowRecommCellCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "RecommCell")
        CSID_CallShow_RecommlistCollView.isPagingEnabled = true
        CSID_CallShow_RecommlistCollView.delegate = self
        CSID_CallShow_RecommlistCollView.dataSource = self
        CSID_CallShow_RecommlistCollView.showsVerticalScrollIndicator = false
        CSID_CallShow_RecommlistCollView.showsHorizontalScrollIndicator = false
        
        return CSID_CallShow_RecommlistCollView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return listdataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell_View:CSID_CallShowRecommCellCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommCell", for: indexPath) as! CSID_CallShowRecommCellCollectionViewCell
              
        let model = listdataArr[indexPath.row] as! CSID_CallShowListModel
        cell_View.configCellWithModel(model: model)
        
        return cell_View
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
