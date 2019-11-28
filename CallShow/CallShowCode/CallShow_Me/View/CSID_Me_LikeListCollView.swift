//
//  CSID_Me_LikeListCollView.swift
//  CallShow
//
//  Created by mac on 2019/11/28.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit

class CSID_Me_LikeListCollView: CSID_BaseCollectionView {

    override func initCSID_View() {
        
        //设置collection
        let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width:(CSID_WidthScreen-40)/3,height:(CSID_WidthScreen-40)/3*1.5)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.headerReferenceSize = CGSize(width:CSID_WidthScreen, height:CSID_DefaultHeight)
            
             self.collectionView?.setCollectionViewLayout(layout, animated: false)
        
        self.collectionView?.register(CSID_CallShow_SiteCollectViewCell.classForCoder(), forCellWithReuseIdentifier:"SiteCell")
 
            self.collectionView?.isPagingEnabled = true
            self.collectionView?.showsVerticalScrollIndicator = false
            self.collectionView?.showsHorizontalScrollIndicator = false
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SiteCell", for: indexPath) as! CSID_CallShow_SiteCollectViewCell
        
        let siteModel:CSID_CallShowListModel = datas[indexPath.row] as! CSID_CallShowListModel
        
         cell.csid_callshow_SiteImageView.kf.setImage(with: URL(string: siteModel.imgUrl ?? ""), placeholder: UIImage(named: "placeholder"))
        
           return cell
       }
       
    
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          
        sendViewDelegateEvent(eventObject: ViewEventObject.CSID_viewEventObject(eventType: CSID_AppAction.csid_ClickLikeItemAction.rawValue, params: indexPath.item))
       }
    

}
