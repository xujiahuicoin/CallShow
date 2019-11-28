//
//  CSID_CallShowSiteHeaderDetailViewController.swift
//  CallShow
//
//  Created by 高燕 on 2019/11/27.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit

let gBtn = UIButton.init(type: UIButton.ButtonType.custom)
var gImgV4BottomSide : UIImageView!
var gImgV4TopSide : UIImageView!
var lBool4ChangeImgV : Bool = false
var call_show_PreviewView : CSID_ShowPreviewSubView!

class CSID_CallShowSiteHeaderDetailViewController: CSID_BaseViewController {
    
    var call_show_SiteHeaderDetailArray :Array<CSID_CallShowListModel> = []
    var clickCurrentInteger : NSInteger = 0
  
    override func viewWillAppear(_ animated: Bool){
        
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()

         self.call_showSettingoverturnViewUI()
         view.addSubview(leftnavBackBotton)
         view.addSubview(rightUseBotton)
    
        /**切换collectionView*/
        call_show_PreviewView.call_show_preViewHiddeneBlock = { () -> Void in
            self.btnDidClick()
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
        var model:CSID_CallShowListModel?
        if clickCurrentInteger == 0{
            model = call_show_SiteHeaderDetailArray[clickCurrentInteger]
        }else{
            model = call_show_SiteHeaderDetailArray[clickCurrentInteger+1]
        }
        //展示插页广告
        self.doStarInterstitial()
        let imageUrlStr:String = model?.imageUrl ?? ""
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
            self.navigationController?.pushViewController(callshow)
        }
        let allAction = UIAlertAction(title: "全部人设置", style: .default) { (action) in
            let alertController = UIAlertController.init(title: "确定要给全部联系人设置来电秀吗？", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let sureAction = UIAlertAction(title: "确定", style: .default) { (action) in
                //定义URL对象
                let url = URL(string: imageUrlStr )
                //从网络获取数据流
                let data = try! Data(contentsOf: url!)
                CSID_CallShowContact.AllContactSettings(imageData: data)
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
    
    func call_showSettingoverturnViewUI()  {
        
        gImgV4BottomSide = UIImageView(frame: self.view.bounds)
        gImgV4BottomSide.clipsToBounds = true
        gImgV4BottomSide.contentMode = .scaleAspectFill
        
        gImgV4TopSide = UIImageView(frame: self.view.bounds)
        gImgV4TopSide.clipsToBounds = true
        gImgV4TopSide.contentMode = .scaleAspectFill
        
        view.addSubview(gBtn)
        gBtn.backgroundColor = UIColor.clear
        gBtn.addTarget(self, action: #selector(btnDidClick), for: UIControl.Event.touchUpInside)
        gBtn.center = view.center
        gBtn.addSubview(gImgV4BottomSide)
        gBtn.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi), 0, 1, 0)
        gBtn.addSubview(gImgV4TopSide)
        
        //按钮大小设置为与图片大小一致
        gBtn.bounds = gImgV4BottomSide.bounds
        
        call_show_PreviewView = CSID_ShowPreviewSubView.previewInstance()
        call_show_PreviewView.frame = CGRect(x:0, y:0, width:CSID_WidthScreen, height:CSID_heightScreen)
        call_show_PreviewView?.call_showTtileHeightConstriant.constant = CSID_HeightNav_top+3*CSID_Status_H
        call_show_PreviewView?.call_showMiddleViewWidthConstraint.constant=(CSID_WidthScreen-120)/2
            
        call_show_PreviewView?.call_show_refuceBottomHeightConstriant.constant = CSID_HeightTabBom+CSID_DefaultHeight
        call_show_PreviewView?.call_show_acceptBottomHeightConstraint.constant = CSID_HeightTabBom+CSID_DefaultHeight
        
        view.addSubview(call_show_PreviewView)
    }
    @objc func btnDidClick()  {
    
        let lAni = CAKeyframeAnimation.init(keyPath: "transform.rotation.y")
        lAni.duration = 1
        lAni.values = [0, Double.pi];
            
        //使得动画结束后，保持动画效果
        lAni.isRemovedOnCompletion = false
        lAni.fillMode = CAMediaTimingFillMode.forwards
        lAni.delegate = (self as CAAnimationDelegate);
            
        gBtn.layer.add(lAni, forKey: nil)
        
        self.clickCurrentInteger = self.clickCurrentInteger + 1
        self.call_showSettinTopBottomImageViewwork()

    }
    
    func call_showSiteHeaderDetialListNetwork(){
        
    CSID_HUDShow()
    CSID_RequestManager.request(.post, url:callShowFieldTopDetailList, params:nil, success: {(resltData) in

                self.CSID_hideHUD()

                NSLog("resltData = \(resltData)")

                let responDict : NSDictionary = resltData as! NSDictionary
                if let listArray = responDict["wallpaperList"] as? [[String : Any]] {
                
                    self.call_show_SiteHeaderDetailArray = [CSID_CallShowListModel].deserialize(from: listArray) as! Array<CSID_CallShowListModel>
                 }

                self.call_showSettinTopBottomImageViewwork()
                                                                
            }) { (error) in

                self.CSID_hideHUD()
         }
    
     }
    
    func call_showSettinTopBottomImageViewwork(){
        
        if self.clickCurrentInteger>=self.call_show_SiteHeaderDetailArray.count {
            self.clickCurrentInteger = 0
        }
        if self.call_show_SiteHeaderDetailArray.count>0 {
            
            if self.clickCurrentInteger == 0 {
                
                let upmodel = self.call_show_SiteHeaderDetailArray[self.clickCurrentInteger]
                        let downmodel = self.call_show_SiteHeaderDetailArray[self.clickCurrentInteger+1]
                gImgV4TopSide.kf.setImage(with: URL(string: upmodel.imageUrl ?? ""), placeholder: UIImage(named: "placeholder"))
                gImgV4BottomSide.kf.setImage(with: URL(string: downmodel.imageUrl ?? ""), placeholder: UIImage(named: "placeholder"))
                
            }else{
                
                let model = self.call_show_SiteHeaderDetailArray[self.clickCurrentInteger+1]
                if self.clickCurrentInteger % 2 == 0 {
                    
                    gImgV4TopSide.kf.setImage(with: URL(string: model.imageUrl ?? ""), placeholder: UIImage(named: "placeholder"))
                }else{
                    gImgV4BottomSide.kf.setImage(with: URL(string: model.imageUrl ?? ""), placeholder: UIImage(named: "placeholder"))
                }
            
            }
        
        }

    }

}
extension UIViewController: CAAnimationDelegate{
    public func animationDidStart(_ anim: CAAnimation) {
        
        let lDur:CFTimeInterval = anim.duration
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + lDur * 0.3) {
            gBtn.bringSubviewToFront(lBool4ChangeImgV == false ? gImgV4BottomSide : gImgV4TopSide)
            lBool4ChangeImgV = !lBool4ChangeImgV
        }
    }
}
