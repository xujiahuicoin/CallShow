//
//  CSID_LikeListVC.swift
//  CallShow
//
//  Created by mac on 2019/11/28.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit

class CSID_LikeListVC: CSID_BaseViewController {
    
    var call_show_LikeListArray : [CSID_CallShowListModel] = []
    var call_show_likeView : CSID_Me_LikeListCollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "点赞列表"
        // Do any additional setup after loading the view.
        CSID_Pri_setcurrentUI()
        CSID_Pri_GetLikeListData()
    }
    
    ///设置UI
    func CSID_Pri_setcurrentUI(){
        
        call_show_likeView = CSID_Me_LikeListCollView.view()
        call_show_likeView.delegate = self
        self.view.addSubview(call_show_likeView)
        
        call_show_likeView.snp.makeConstraints { (ma) in
            ma.edges.equalToSuperview()
        }
    }
    
    ///获取数据---
    func CSID_Pri_GetLikeListData(){
        
        CSID_HUDShow()
        CSID_RequestManager.request(.post, url:callShowClickLikeList, params:nil, success: {(resltData) in
            
            self.CSID_hideHUD()
            
            NSLog("resltData = \(resltData)")
            
            let responDict : NSDictionary = resltData as! NSDictionary
            if let listArray = responDict["list"] as? [[String : Any]] {
                
                self.call_show_LikeListArray = [CSID_CallShowListModel].deserialize(from: listArray) as! [CSID_CallShowListModel]
            }
            
            if self.call_show_LikeListArray.count > 0{
                self.call_show_likeView.CSID_updateCollecDataToView(datas: self.call_show_LikeListArray)
                self.call_show_likeView.collectionView?.set(loadType: .normal)
            }else{
                self.call_show_likeView.collectionView?.set(loadType: .noData)
            }
            
            
        }) { (error) in
            
            self.CSID_hideHUD()
            self.CSID_showErrorWithText(text:"获取失败请重试")
            
            self.call_show_likeView.collectionView?.set(loadType: .noData)
        }
    }
    
    
    override func CSID_UIViewCollectEvent(eventObject: ViewEventObject) {
        
        if eventObject.event_CodeType == CSID_AppAction.csid_ClickLikeItemAction.rawValue {
            let index = eventObject.params
            
            let detailVC = CSID_CallShowSiteDetailVC.init()
            detailVC.callShow_IsLike = true
            detailVC.detailCurrentIndex = index as? NSInteger ?? 0
            detailVC.callShowDetailArrays = call_show_LikeListArray
            detailVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detailVC, animated: true)
            
        }
    }
    
}
