//
//  CSID_CallShowSiteDetailVC.swift
//  CallShow
//
//  Created by 高燕 on 2019/11/26.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit

class CSID_CallShowSiteDetailVC: CSID_BaseViewController{

     var callShowDetailArrays: Array<CSID_CallShowListModel> = []
     var detailGroupIdString: String?
    ///点击的事第几个
     var detailCurrentIndex :NSInteger = 0
    
    ///是不是点赞进来的--默认不是
    var callShow_IsLike : Bool = false
    
     override func viewWillAppear(_ animated: Bool){
         
         self.navigationController?.navigationBar.isHidden = true
     }
     override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = false
     }
     override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(callShowFiledDetailView)
        view.addSubview(navBackBotton)
        
        if callShowDetailArrays.count<=0{
            self.call_showFiledDetailListNetwork()
        }else{
            
            self.callShowFiledDetailView.csid_CallShow_recommCollectViewRefresh(needArray: self.callShowDetailArrays as NSArray)
         self.callShowFiledDetailView.csid_callShow_collectScrollViewCurrentIndex(currentIndex:self.detailCurrentIndex)
            
        }
        
        callShowFiledDetailView.callShowBlock = {imageUrlStr in
            //展示插页广告
            self.doStarInterstitial()
        }
        
    }
    /**detialCollectionView*/
    lazy var callShowFiledDetailView : CSID_CallShowListCommView = {
        
        let callShowFiledDetailView = CSID_CallShowListCommView(frame:.init(x: 0, y: -CSID_Status_H, width: CSID_WidthScreen, height: CSID_heightScreen+CSID_Status_H))
    
        return callShowFiledDetailView
    }()
    
    /**返回按钮*/
    lazy var navBackBotton : UIButton = {
        
            let navBackBotton : UIButton = UIButton.init(frame: CGRect.init(x:0, y:CSID_Status_H, width:CSID_HeightNav, height:CSID_HeightNav))
        
            navBackBotton.setImage(UIImage.init(named: "fanhuibai_img1"), for:.normal)
            navBackBotton.addTarget(self, action: #selector(backButtonViewAction), for: .touchUpInside)
        
            return navBackBotton
    }()
    
    @objc func backButtonViewAction(sender:UIButton) -> Void {
        
        self.navigationController?.popViewController(animated: true)
     }
    /**组详情内容接口请求*/
       func call_showFiledDetailListNetwork(){
              
        CSID_HUDShow()
        CSID_RequestManager.request(.post, url:callShowFieldDetailList, params:["groupId":self.detailGroupIdString!,"page":"1",
                                                                               "pageSize":defaultPageSize], success: {(resltData) in


                      self.CSID_hideHUD()

                      let responDict : NSDictionary = resltData as! NSDictionary
                      if let listArray = responDict["list"] as? [[String : Any]] {
                        self.callShowDetailArrays = [CSID_CallShowListModel].deserialize(from: listArray) as! Array<CSID_CallShowListModel>
                       }
                    self.callShowFiledDetailView.csid_CallShow_recommCollectViewRefresh(needArray: self.callShowDetailArrays as NSArray)
                    self.callShowFiledDetailView.csid_callShow_collectScrollViewCurrentIndex(currentIndex:self.detailCurrentIndex)
          
                   }) { (error) in

                       self.CSID_hideHUD()
                   }
           
            }
    
}
