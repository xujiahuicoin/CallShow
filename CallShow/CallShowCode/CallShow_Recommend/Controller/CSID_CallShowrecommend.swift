//
//  CSID_CallShowrecommend.swift
//  CallShow
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos
class CSID_CallShowrecommend: CSID_BaseViewController,UIScrollViewDelegate{

    var callShowsRecommArrays: Array<CSID_CallShowListModel> = []
    var callShowNewestArrays: Array<CSID_CallShowListModel> = []
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.backgroundColor = UIColor.clear
        self.tabBarController?.tabBar.shadowImage = UIImage()
        self.tabBarController?.tabBar.backgroundImage = UIImage()

    }
    override func viewWillDisappear(_ animated: Bool) {

        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {

        super.viewDidLoad()
        let appDelegate = (UIApplication.shared.delegate) as? AppDelegate
        appDelegate?.avPlayer.play()
        
        self.call_showRecommandListNetwork()
        self.call_showNewestListNetwork()

        view.addSubview(recommadnScrollView)
        recommadnScrollView.addSubview(callShowRecommendView)
        recommadnScrollView.addSubview(callShowNewestView)
        
        view.addSubview(call_ShowHeaderView)
        call_ShowHeaderView.addSubview(recommBotton)
        call_ShowHeaderView.addSubview(newestBotton)
        call_ShowHeaderView.addSubview(call_showMiddleLine)
        
        callShowRecommendView.recommendChangeblock = { (boolVaule) in
    
            self.call_show_ShowHeaderSettingwork(vaules: boolVaule)
        }
        callShowNewestView.recommendChangeblock = { (boolVaule) in
         
            self.call_show_ShowHeaderSettingwork(vaules: boolVaule)
        }
        //设置来电秀 block
        callShowRecommendView.callShowBlock = {imageUrlStr in
            
            if imageUrlStr == CSID_goBuyVip {
                
                self.CSID_Pub_GoToBuyVIPvc()
                
            }else{
                //展示插页广告
                self.doStarInterstitial()
            }
            
        }
        
        callShowNewestView.callShowBlock = {imageUrlStr in
            if imageUrlStr == CSID_goBuyVip {
                
                self.CSID_Pub_GoToBuyVIPvc()
                
            }else{
                //展示插页广告
                self.doStarInterstitial()
            }
        }
        
        // 选取照片
        callShowRecommendView.hselectedPhotoBlock = { photo in
            self.localphoto()
        }
        
        callShowNewestView.hselectedPhotoBlock = { photo in
            self.localphoto()
        }
        
        // 设置来电秀
        callShowRecommendView.hsetCallBlock = { imageUrl in
            self.setCallShow(imageUrlStr: imageUrl)
        }
        
        callShowNewestView.hsetCallBlock = { imageUrl in
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
    
    // 本地图片
    func localphoto(){
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
    
    func call_show_ShowHeaderSettingwork( vaules : Bool) -> Void {
        
        self.call_ShowHeaderView.isHidden = vaules
        self.tabBarController?.tabBar.isHidden=vaules
    }

    lazy var call_ShowHeaderView : UIView = {
        
        let call_ShowHeaderView : UIView = UIView.init(frame: CGRect.init(x: 0, y:CSID_Status_H, width:CSID_WidthScreen, height: CSID_HeightNav))
        
        return call_ShowHeaderView
    }()
    
    lazy var recommBotton : UIButton = {
            let recommBotton : UIButton = UIButton.init(frame: CGRect.init(x:0, y:0, width:CSID_WidthScreen/2, height:CSID_HeightNav))
        
            recommBotton.setTitle("推荐", for: .normal)
            recommBotton.titleLabel?.font = NameFont(nameT: regular, font: 16)
            recommBotton.setTitleColor(UIColor.white, for: .normal)
            recommBotton.setTitleColor(CSID_MainColor, for: .selected)
            recommBotton.addTarget(self, action: #selector(recommButtonViewAction), for: .touchUpInside)
            recommBotton.isSelected=true
            recommBotton.titleEdgeInsets=UIEdgeInsets(top: 0, left:CSID_ButtonEdgeInsetWidth, bottom: 0, right:0)
            return recommBotton
    }()
    //推荐
    @objc func recommButtonViewAction(sender:UIButton) -> Void {
          sender.isSelected=true
          newestBotton.isSelected=false
          recommadnScrollView.contentOffset=CGPoint(x:0,y:0)
           if self.callShowsRecommArrays.count<=0 {
                  self.call_showRecommandListNetwork()
            }
    callShowRecommendView.call_show_RightView.call_show_musicPlayButton.isSelected = callShowNewestView.call_show_RightView.call_show_musicPlayButton.isSelected
     
    callShowRecommendView.call_show_RightView.call_show_settingMusicButton.isHidden = callShowNewestView.call_show_RightView.call_show_settingMusicButton.isHidden
        
    callShowRecommendView.call_show_RightView.call_show_nextMusicView.isHidden = callShowNewestView.call_show_RightView.call_show_settingMusicButton.isHidden
          
    callShowRecommendView.call_show_RightView.call_show_musicPopButton.isSelected = callShowNewestView.call_show_RightView.call_show_musicPopButton.isSelected
     }
    lazy var newestBotton : UIButton = {
        
            let newestBotton : UIButton = UIButton.init(frame: CGRect.init(x:CSID_WidthScreen/2, y:0, width:CSID_WidthScreen/2, height:CSID_HeightNav))
            newestBotton.setTitle("最新", for: .normal)
            newestBotton.titleLabel?.font = NameFont(nameT: regular, font: 16)
            newestBotton.setTitleColor(UIColor.white, for: .normal)
            newestBotton.setTitleColor(CSID_MainColor, for: .selected)
            newestBotton.addTarget(self, action: #selector(newestBottonViewAction), for: .touchUpInside)
            newestBotton.titleEdgeInsets=UIEdgeInsets(top: 0, left:0, bottom: 0, right:CSID_ButtonEdgeInsetWidth)
        
            return newestBotton
    }()
    //最新
    @objc func newestBottonViewAction(sender:UIButton) -> Void {
        
        sender.isSelected=true
        recommBotton.isSelected=false
        recommadnScrollView.contentOffset=CGPoint(x:CSID_WidthScreen,y:0)
        
        if self.callShowNewestArrays.count<=0 {
            self.call_showNewestListNetwork()
        }
    callShowNewestView.call_show_RightView.call_show_musicPlayButton.isSelected = callShowRecommendView.call_show_RightView.call_show_musicPlayButton.isSelected
    callShowNewestView.call_show_RightView.call_show_settingMusicButton.isHidden = callShowRecommendView.call_show_RightView.call_show_settingMusicButton.isHidden
            
    callShowNewestView.call_show_RightView.call_show_nextMusicView.isHidden = callShowRecommendView.call_show_RightView.call_show_settingMusicButton.isHidden
        
    callShowNewestView.call_show_RightView.call_show_musicPopButton.isSelected = callShowRecommendView.call_show_RightView.call_show_musicPopButton.isSelected
        
     }
    lazy var call_showMiddleLine : UIView = {
        
        let call_showMiddleLine : UIView = UIView.init(frame: CGRect.init(x:CSID_WidthScreen/2, y:15, width:1, height:call_ShowHeaderView.height-30))
            call_showMiddleLine.backgroundColor=UIColor.white
        
            return call_showMiddleLine
    }()
    
    
    lazy var recommadnScrollView: UIScrollView = {
        
        let recommadnScrollView = UIScrollView(frame:CGRect(x: 0, y: -CSID_Status_H, width: CSID_WidthScreen, height: CSID_heightScreen+CSID_Status_H))
        recommadnScrollView.delegate = self
        recommadnScrollView.isPagingEnabled=true
        recommadnScrollView.bounces=false
        recommadnScrollView.showsHorizontalScrollIndicator=false
        recommadnScrollView.showsVerticalScrollIndicator=false
        recommadnScrollView.contentSize=CGSize(width:CSID_WidthScreen*2, height: CSID_heightScreen-CSID_Status_H)
        
        self.view.addSubview(recommadnScrollView)
        
        return recommadnScrollView
    }()
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let  currentPage = Int(scrollView.contentOffset.x/CSID_WidthScreen)
           if currentPage == 0 {
               recommBotton.isSelected=true
               newestBotton.isSelected=false
           }else{
               recommBotton.isSelected=false
               newestBotton.isSelected=true
           }
    }
    
    
    lazy var callShowRecommendView : CSID_CallShowListCommView = {
           
        let callShowRecommendView = CSID_CallShowListCommView(frame:.init(x: 0, y: 0, width: CSID_WidthScreen, height: recommadnScrollView.height))
        
        callShowRecommendView.zanUserType = UserDefaults.standard.string(forKey: homezanType)! as NSString
           return callShowRecommendView
    }()
       
      lazy var callShowNewestView : CSID_CallShowListCommView = {
                
           let callShowNewestView = CSID_CallShowListCommView(frame:.init(x:CSID_WidthScreen, y: 0, width: CSID_WidthScreen, height: recommadnScrollView.height))
    
        callShowNewestView.zanUserType = UserDefaults.standard.string(forKey: homezanType)! as NSString
        
           return callShowNewestView
    }()
    
    
   func call_showRecommandListNetwork(){
        
    CSID_HUDShow()
    
    let recommedIdValue = UserDefaults.standard.string(forKey: saverecommedCategoryId)
    
    CSID_RequestManager.request(.post, url:callShowRecommList, params:["categoryId":recommedIdValue!,"page":"1",
                                                                        "pageSize":defaultPageSize], success: {(resltData) in


                self.CSID_hideHUD()

                NSLog("resltData = \(resltData)")

                let responDict : NSDictionary = resltData as! NSDictionary
                if let listArray = responDict["list"] as? [[String : Any]] {
                
                    self.callShowsRecommArrays = [CSID_CallShowListModel].deserialize(from: listArray) as! Array<CSID_CallShowListModel>
                 }
             self.callShowRecommendView.csid_CallShow_recommCollectViewRefresh(needArray:self.callShowsRecommArrays as NSArray)

                                                                
            }) { (error) in

                self.CSID_hideHUD()
                self.call_showRecommandListNetwork()
            }
    
     }
      
      func call_showNewestListNetwork(){
        
        let newestIdValue = UserDefaults.standard.string(forKey: savenewestCategoryId)
        
        CSID_HUDShow()
        CSID_RequestManager.request(.post, url:callShowRecommList, params:["categoryId":newestIdValue!,"page":"1",
                                                                            "pageSize":defaultPageSize], success: {(resltData) in
                    
                    NSLog("resltData = \(resltData)")
                    self.CSID_hideHUD()
                                                                                
                    let responDict : NSDictionary = resltData as! NSDictionary
                    if let listArray = responDict["list"] as? [[String : Any]] {
                     
                        self.callShowNewestArrays = [CSID_CallShowListModel].deserialize(from: listArray) as! Array<CSID_CallShowListModel>

                     }
            self.callShowNewestView.csid_CallShow_recommCollectViewRefresh(needArray: self.callShowNewestArrays as NSArray)
                                                                                
                }) { (error) in
                    
                    self.CSID_hideHUD()
                    self.call_showNewestListNetwork()
                    
                }

         }
    

}
