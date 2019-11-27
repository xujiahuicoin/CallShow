//
//  CSID_CallShowSiteHeaderDetailViewController.swift
//  CallShow
//
//  Created by 高燕 on 2019/11/27.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit

class CSID_CallShowSiteHeaderDetailViewController: CSID_BaseViewController {

    var call_show_SiteHeaderDetailArray :Array<CSID_CallShowListModel> = []
    
    override func viewWillAppear(_ animated: Bool){
        
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()

         
         view.backgroundColor=UIColor.red
         view.addSubview(call_show_PreviewView)
         view.addSubview(leftnavBackBotton)
         view.addSubview(rightUseBotton)
    
        /**切换collectionView位置*/
        call_show_PreviewView.call_show_preViewHiddeneBlock = { () -> Void in
              
        }
        
        self.call_showSiteHeaderDetialListNetwork()

    }
     /**返回按钮*/
    lazy var leftnavBackBotton : UIButton = {
           
            let navBackBotton : UIButton = UIButton.init(frame: CGRect.init(x:0, y:CSID_Status_H, width:CSID_HeightNav, height:CSID_HeightNav))
            navBackBotton.setImage(UIImage.init(named: "fanhuibai_img1"), for:.normal)
            navBackBotton.addTarget(self, action: #selector(backButtonViewAction), for: .touchUpInside)
        
            return navBackBotton
    }()
       
    @objc func backButtonViewAction(sender:UIButton) -> Void {
           
        self.navigationController?.popViewController(animated: true)
    }
    /**使用按钮*/
    lazy var rightUseBotton : UIButton = {
           
            let rightUseBotton : UIButton = UIButton.init(frame: CGRect.init(x:CSID_WidthScreen-CSID_HeightNav, y:CSID_Status_H, width:CSID_HeightNav, height:CSID_HeightNav))
            rightUseBotton.setImage(UIImage.init(named: "call_show_rightUse"), for:.normal)
            rightUseBotton.addTarget(self, action: #selector(rightUseButtonViewAction), for: .touchUpInside)
        
            return rightUseBotton
    }()
    /**----使用电话---*/
    @objc func rightUseButtonViewAction(sender:UIButton) -> Void {
           
        
        
    }
    /**电话遮罩*/
    lazy var call_show_PreviewView: CSID_ShowPreviewSubView = {
         () -> CSID_ShowPreviewSubView in

         let call_show_PreviewView = CSID_ShowPreviewSubView.previewInstance()
         call_show_PreviewView?.frame = CGRect(x:0, y:0, width:CSID_WidthScreen, height:CSID_heightScreen)
         call_show_PreviewView?.call_showTtileHeightConstriant.constant = CSID_HeightNav_top+3*CSID_Status_H
    call_show_PreviewView?.call_showMiddleViewWidthConstraint.constant=(CSID_WidthScreen-120)/2
        
        call_show_PreviewView?.call_show_refuceBottomHeightConstriant.constant = CSID_HeightTabBom+CSID_DefaultHeight
        call_show_PreviewView?.call_show_acceptBottomHeightConstraint.constant = CSID_HeightTabBom+CSID_DefaultHeight
           
         return call_show_PreviewView!
     }()
    
    func call_showSiteHeaderDetialListNetwork(){
        
    CSID_HUDShow()
    CSID_RequestManager.request(.post, url:callShowFieldTopDetailList, params:nil, success: {(resltData) in

                self.CSID_hideHUD()

                NSLog("resltData = \(resltData)")

                let responDict : NSDictionary = resltData as! NSDictionary
                if let listArray = responDict["wallpaperList"] as? [[String : Any]] {
                
                    self.call_show_SiteHeaderDetailArray = [CSID_CallShowListModel].deserialize(from: listArray) as! Array<CSID_CallShowListModel>
                 }
                                                                
            }) { (error) in

                self.CSID_hideHUD()
         }
    
     }
    
    

}
