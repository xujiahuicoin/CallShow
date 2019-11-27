//
//  CSID_CallShowSiteVC.swift
//  CallShow
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit

class CSID_CallShowSiteVC: CSID_BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var callShowSiteSectionArrays: Array<CSID_SiteModel> = []
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.backgroundColor = CSID_LineColor
    }
    override func viewDidLoad(){
        
       view.addSubview(CSID_CallShow_SiteCollView)
       self.call_show_SiteCollectionViewSettingHeaderWork()
       self.call_showFiledListNetwork()
    }
    
    func call_showFiledListNetwork(){
        
     CSID_HUDShow()
     CSID_RequestManager.request(.post, url:callShowFieldList, params:["page":"1",
                                                                         "pageSize":defaultPageSize], success: {(resltData) in


                 self.CSID_hideHUD()

                 NSLog("--分组列表--resltData = \(resltData)")

                 let responDict : NSDictionary = resltData as! NSDictionary
                 if let listArray = responDict["list"] as? [[String : Any]] {
                
                    self.callShowSiteSectionArrays = [CSID_SiteModel].deserialize(from: listArray) as! Array<CSID_SiteModel>
                  }
                                                                            
                 self.CSID_CallShow_SiteCollView.reloadData()

    
             }) { (error) in

                 self.CSID_hideHUD()
             }
     
      }

    
    /**CollectionView*/
    lazy var CSID_CallShow_SiteCollView : UICollectionView = {
    
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:(CSID_WidthScreen-40)/3,height:(CSID_WidthScreen-40)/3*1.5)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.headerReferenceSize = CGSize(width:CSID_WidthScreen, height:CSID_DefaultHeight)
        
        let CSID_CallShow_SiteCollView : UICollectionView = UICollectionView.init(frame: CGRect.init(x: 10, y: 0, width: CSID_WidthScreen-20, height: CSID_heightScreen-CSID_HeightTabBom), collectionViewLayout: layout)

        CSID_CallShow_SiteCollView.backgroundColor = UIColor.white
    CSID_CallShow_SiteCollView.register(CSID_CallShow_SiteCollectViewCell.classForCoder(), forCellWithReuseIdentifier:"SiteCell")
        CSID_CallShow_SiteCollView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SiteCollViewHeaderViewID")
        
        CSID_CallShow_SiteCollView.isPagingEnabled = true
        CSID_CallShow_SiteCollView.delegate = self
        CSID_CallShow_SiteCollView.dataSource = self
        CSID_CallShow_SiteCollView.showsVerticalScrollIndicator = false
        CSID_CallShow_SiteCollView.showsHorizontalScrollIndicator = false
        
        return CSID_CallShow_SiteCollView
        
    }()
    /**顶部View*/
    func call_show_SiteCollectionViewSettingHeaderWork(){
        
        CSID_CallShow_SiteCollView.contentInset = UIEdgeInsets(top: 160, left: 0, bottom: 0, right: 0)
        let headerImg = UIImageView(image: UIImage(named: "CSID_buy_BannerImg"))
        headerImg.frame = CGRect(x: 0, y: -150, width: CSID_WidthScreen-20, height:150)
        headerImg.isUserInteractionEnabled=true
        AddRadius(headerImg, rabF: 5)
        
        let headerImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(clickHeaderImageTapAction))
        headerImg.addGestureRecognizer(headerImageTapGesture)
        
        CSID_CallShow_SiteCollView.addSubview(headerImg)
    
    }
    /**顶部View详情*/
    @objc func clickHeaderImageTapAction(){
        
        let headerdetailVC = CSID_CallShowSiteHeaderDetailViewController.init()
        headerdetailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(headerdetailVC, animated: true)
    }
    
    
    /**组头*/
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        var headerView:UICollectionReusableView!
        let siteModel = callShowSiteSectionArrays[indexPath.section]
        
        if kind == UICollectionView.elementKindSectionHeader{
            
          headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SiteCollViewHeaderViewID", for: indexPath) as UICollectionReusableView
          headerView.backgroundColor=UIColor.white
            
            if headerView.subviews.count>0 {
                headerView.removeSubviews()
            }
          
          let call_showLine : UIView = UIView.init(frame: CGRect.init(x:0, y:20, width:2, height:headerView.height-40))
          call_showLine.backgroundColor=CSID_MainColor
          headerView.addSubview(call_showLine)
          
          let call_showTitleL :UILabel = UILabel.init(frame: CGRect.init(x:10, y: 0, width: 100, height: headerView.height))
          call_showTitleL.text = siteModel.groupName
          call_showTitleL.textColor = CSID_MainTextColor
          call_showTitleL.font = UIFont.font(size:CSID_FontNum_Second)
          
          headerView.addSubview(call_showTitleL)
          
          let arrowImgV = UIImageView(image: UIImage(named: "arrow_more"))
          arrowImgV.frame = CGRect(x:headerView.width-30, y: 15, width: 20, height:20)
          headerView.addSubview(arrowImgV)
          
          let sectionHeadaerTapGesture = UITapGestureRecognizer(target: self, action: #selector(sectionHeaderclickviewTapAction(_ :)))
            
           headerView.addGestureRecognizer(sectionHeadaerTapGesture)
           sectionHeadaerTapGesture.view!.tag = indexPath.section
            
            
        }
        return headerView
    }
     /**组详情*/
    @objc func sectionHeaderclickviewTapAction(_ sender:UITapGestureRecognizer){
        

        let sectionDetailVC = CSID_CallShowSectionHeaderDetailViewController.init()
        sectionDetailVC.siteSectionHeaderModel = self.callShowSiteSectionArrays[sender.view!.tag]
        sectionDetailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(sectionDetailVC, animated: true)
        
     }
    /**collectionView 代理数据源方法*/
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return self.callShowSiteSectionArrays.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let siteModel = callShowSiteSectionArrays[section]
        return siteModel.imageList!.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let siteModel = callShowSiteSectionArrays[indexPath.section]
        
        let cell_View:CSID_CallShow_SiteCollectViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:"SiteCell", for: indexPath) as! CSID_CallShow_SiteCollectViewCell
        
        let contentDic : NSDictionary = siteModel.imageList?[indexPath.row] as! NSDictionary
        let contentModel: CSID_CallShowListModel = CSID_CallShowListModel.deserialize(from: contentDic)!
        
         cell_View.csid_callshow_SiteImageView.kf.setImage(with: URL(string: contentModel.imageUrl ?? ""), placeholder: UIImage(named: "placeholder"))
                  
        
        return cell_View
    }
    /**点击事件*/
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
      let detailVC = CSID_CallShowSiteDetailVC.init()
      detailVC.hidesBottomBarWhenPushed = true
      self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    
}

