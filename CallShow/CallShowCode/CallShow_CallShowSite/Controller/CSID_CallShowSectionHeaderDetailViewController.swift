//
//  CSID_CallShowSectionHeaderDetailViewController.swift
//  CallShow
//
//  Created by MAC on 27/11/2019.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit

class CSID_CallShowSectionHeaderDetailViewController: CSID_BaseViewController,UICollectionViewDataSource,UICollectionViewDelegate{


     var siteSectionHeaderModel : CSID_SiteModel!
     var callShowSiteSectionHeaderArrays: Array<CSID_CallShowListModel> = []
    
     override func viewDidLoad() {
        super.viewDidLoad()
        /**标题,组内容*/
        self.title = siteSectionHeaderModel.groupName
        //self.callShowSiteSectionHeaderArrays = [CSID_CallShowListModel].deserialize(from: self.siteSectionHeaderModel.imageList) as! Array<CSID_CallShowListModel>
        if callShowSiteSectionHeaderArrays.count<=0 {
                self.call_showFiledSectionDetailListNetwork()
         }
        view.addSubview(CSID_CallShow_SiteDetailCollView)
    }
    /**组详情内容接口请求*/
    func call_showFiledSectionDetailListNetwork(){
           
        CSID_HUDShow()
        CSID_RequestManager.request(.post, url:callShowFieldDetailList, params:["groupId":self.siteSectionHeaderModel.groupId ?? String.self,"page":"1",
                                                                            "pageSize":defaultPageSize], success: {(resltData) in


                   self.CSID_hideHUD()

                   NSLog("--详情--resltData = \(resltData)")
                   let responDict : NSDictionary = resltData as! NSDictionary
                   if let listArray = responDict["list"] as? [[String : Any]] {
           
                     self.callShowSiteSectionHeaderArrays = [CSID_CallShowListModel].deserialize(from: listArray) as! Array<CSID_CallShowListModel>
                    }
                    self.CSID_CallShow_SiteDetailCollView.reloadData()

       
                }) { (error) in

                    self.CSID_hideHUD()
                }
        
         }
    
    lazy var CSID_CallShow_SiteDetailCollView : UICollectionView = {
        
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:(CSID_WidthScreen-30)/2,height:(CSID_WidthScreen-30)/2*1.5)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
    
        let CSID_CallShow_SiteDetailCollView : UICollectionView = UICollectionView.init(frame: CGRect.init(x: 10, y: 0, width: CSID_WidthScreen-20, height: CSID_heightScreen-CSID_HeightTabBom), collectionViewLayout: layout)
        
        CSID_CallShow_SiteDetailCollView.backgroundColor = UIColor.white
        CSID_CallShow_SiteDetailCollView.register(CSID_CallShowSiteDetailCollectViewCell.classForCoder(), forCellWithReuseIdentifier:"SiteDetailCell")
        CSID_CallShow_SiteDetailCollView.delegate = self
        CSID_CallShow_SiteDetailCollView.dataSource = self
        CSID_CallShow_SiteDetailCollView.showsVerticalScrollIndicator = false
        CSID_CallShow_SiteDetailCollView.showsHorizontalScrollIndicator = false
        
        return CSID_CallShow_SiteDetailCollView
        
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.callShowSiteSectionHeaderArrays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell_View:CSID_CallShowSiteDetailCollectViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:"SiteDetailCell", for: indexPath) as! CSID_CallShowSiteDetailCollectViewCell
        let model = self.callShowSiteSectionHeaderArrays[indexPath.row]
        
        cell_View.csid_callshow_SiteDetailImageView.kf.setImage(with: URL(string: model.imageUrl ?? ""), placeholder: UIImage(named: "placeholder"))
        cell_View.call_showTitleL.text = model.upCount
        
        return cell_View
    }

}
