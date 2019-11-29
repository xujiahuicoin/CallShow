//
//  CSID_CallShowSiteDetailVC.swift
//  CallShow
//
//  Created by 高燕 on 2019/11/26.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos
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
            if imageUrlStr == CSID_goBuyVip {
                
                self.CSID_Pub_GoToBuyVIPvc()
                
            }else{
                //展示插页广告
                self.doStarInterstitial()
            }
        }
        
        callShowFiledDetailView.hselectedPhotoBlock = { photo in
            let vc = BSImagePickerViewController()
            vc.maxNumberOfSelections = 1
            self.bs_presentImagePickerController(vc, animated: true,
                                            select: { (asset: PHAsset) -> Void in
            }, deselect: { (asset: PHAsset) -> Void in
            }, cancel: { (assets: [PHAsset]) -> Void in
            }, finish: { (assets: [PHAsset]) -> Void in
                let selcecImage:UIImage = CSID_ZxhPHAssetToImageTool.PHAssetToImage(asset: assets[0])
                
                let photo = CSID_LocalPhotoViewController.init()
                photo.localPhotoData = selcecImage.pngData()
                self.navigationController?.pushViewController(photo, animated: true)
                

            }, completion: nil)
        }
        
        callShowFiledDetailView.hsetCallBlock = {imageUrl in
            self.setCallShow(imageUrlStr: imageUrl)
        }
        
    }
    
    
    // 设置来电秀
    func setCallShow(imageUrlStr:String){
        let alertController = UIAlertController()
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let specifiedAction = UIAlertAction(title: "指定联系人设置", style: .default) { (action) in
            let callshow:CSID_CallShowViewController = CSID_CallShowViewController.init()
            //定义URL对象
            let url = URL(string: imageUrlStr )
            //从网络获取数据流
            let data = try! Data(contentsOf: url!)
            callshow.imageData = data
            callshow.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(callshow, animated: true)
        }
        let allAction = UIAlertAction(title: "全部人设置", style: .default) { (action) in
            
            if !CSID_BuyTool().CSID_JudgeIsVipBool() {
                //不是VIP 去购买
                self.CSID_Pub_GoToBuyVIPvc()
                return
            }
            
            let alertController = UIAlertController.init(title: "确定要给全部联系人设置来电秀吗？", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let sureAction = UIAlertAction(title: "确定", style: .default) { (action) in
                //定义URL对象
                let url = URL(string: imageUrlStr )
                //从网络获取数据流
                let data = try! Data(contentsOf: url!)
                CSID_CallShowContact.AllContactSettings(imageData: data)
                self.CSID_showSuccessWithText(text: "来电秀设置成功")
            }
            alertController.addAction(sureAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
        alertController.addAction(specifiedAction)
        alertController.addAction(allAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
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
