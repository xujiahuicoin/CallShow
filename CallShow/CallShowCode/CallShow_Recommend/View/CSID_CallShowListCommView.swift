//
//  CSID_CallShowListCommView.swift
//  CallShow
//
//  Created by MAC on 26/11/2019.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit

typealias  recommendChangeblock = (_ changBool : Bool) -> Void

class CSID_CallShowListCommView: UIView,UICollectionViewDelegate,UICollectionViewDataSource{

    var recommendChangeblock:recommendChangeblock?
    
    var listdataArr : NSArray = NSArray.init()
    var currentModel : CSID_CallShowListModel!


    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(CSID_CallShow_RecommlistCollView)
        addSubview(call_show_RightView)
        addSubview(call_show_PreviewView)
        
        call_show_RightView.call_show_loveBlockAction { (loveButton) in
        
            CSID_RequestManager.request(.post, url:callShowloveurl, params:["upType":"1","relationId":self.currentModel.relationId ?? ""], success: {(resltData) in
        
                    NSLog("resltData = \(resltData)")
                    loveButton.isSelected = !loveButton.isSelected
                self.currentModel.haveUp = !(self.currentModel.haveUp ?? false)
        
                }) { (error) in

            }
        }
        
        call_show_RightView.call_show_eyeLookBlockAction { (eyeButton) in
            
            self.call_show_PreviewView.isHidden=false
            self.call_show_RightView.isHidden=true
            
            if self.recommendChangeblock != nil {
                self.recommendChangeblock!(true)
            }
        }
        call_show_PreviewView.call_show_preViewHiddeneBlock = { () -> Void in
            
            self.call_show_RightView.isHidden=false
            self.call_show_PreviewView.isHidden = true
            if self.recommendChangeblock != nil {
                self.recommendChangeblock!(false)
            }
        }
        
    }
    
    lazy var call_show_RightView: CSID_CollectRightSubView = {
        () -> CSID_CollectRightSubView in
        
        let call_show_RightView = CSID_CollectRightSubView.newInstance()
        call_show_RightView?.frame = CGRect(x:CSID_WidthScreen-80, y:(CSID_heightScreen-200)/2, width:80, height:200)
        
        return call_show_RightView!
    }()
    
    lazy var call_show_PreviewView: CSID_ShowPreviewSubView = {
         () -> CSID_ShowPreviewSubView in

         let call_show_PreviewView = CSID_ShowPreviewSubView.previewInstance()
         call_show_PreviewView?.frame = CGRect(x:0, y:0, width:CSID_CallShow_RecommlistCollView.width, height:CSID_CallShow_RecommlistCollView.height)
         call_show_PreviewView?.isHidden = true
         call_show_PreviewView?.call_showTtileHeightConstriant.constant = CSID_HeightNav_top+3*CSID_Status_H
    call_show_PreviewView?.call_showMiddleViewWidthConstraint.constant=(CSID_WidthScreen-120)/2
        
        call_show_PreviewView?.call_show_refuceBottomHeightConstriant.constant = CSID_HeightTabBom+CSID_DefaultHeight
        call_show_PreviewView?.call_show_acceptBottomHeightConstraint.constant = CSID_HeightTabBom+CSID_DefaultHeight
           
         return call_show_PreviewView!
     }()
    
    public func csid_CallShow_recommCollectViewRefresh(needArray:NSArray) -> Void {
        
        listdataArr=needArray
        if listdataArr.count>0 {
          self.currentModel = (listdataArr[0] as! CSID_CallShowListModel)
        }
        CSID_CallShow_RecommlistCollView.reloadData()
    }
    
    public func csid_callShow_collectScrollViewCurrentIndex(currentIndex:NSInteger) ->Void{
    
        CSID_CallShow_RecommlistCollView.contentOffset=CGPoint(x: 0, y: self.height * CGFloat(currentIndex))
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
        
        call_show_RightView.call_show_loveButton.isSelected = model.haveUp ?? false
        
        cell_View.configCellWithModel(model: model)
        
        return cell_View
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        
        let currentPage = Int(scrollView.contentOffset.y/CSID_heightScreen)
        currentModel = (listdataArr[currentPage] as! CSID_CallShowListModel)
        
        call_show_RightView.call_show_loveButton.isSelected = currentModel.haveUp ?? false
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
