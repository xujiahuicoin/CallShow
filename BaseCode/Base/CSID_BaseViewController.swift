//
//  BaseViewController.swift
//  CustomizeProject
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 www.CustomizeProject.cn. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import PKHUD
import GoogleMobileAds
class CSID_BaseViewController: UIViewController,CSID_ViewEventsDelegate,NVActivityIndicatorViewable,GADInterstitialDelegate,GADBannerViewDelegate,GADUnifiedNativeAdLoaderDelegate, GADVideoControllerDelegate,GADRewardBasedVideoAdDelegate {
    
    
    ///是否显示banner广告 默认显示
    var bannerShow : Bool = true
    var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if (CSID_BuyTool().CSID_JudgeIsVipBool()) {
            ///是VIP了 设置为不显示广告
            bannerShow = false
            self.bannerView.removeSubviews()
            
        }
        
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.CSID_color(lightColor: CSID_BackgroundColor_dark, darkColor: CSID_BackgroundColor_dark)
        
        //设置导航栏的字体
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : CSID_MainTextColor, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.stopAnimating()
            
            //添加购买成功通知
            NotificationCenter.default.addObserver(self, selector: #selector(self.paySeccessAction), name: NSNotification.Name(rawValue:paySuccess), object: nil)
            
            //创建广告
            self.creatADSaction()
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    func CSID_UIViewCollectEvent(eventObject: ViewEventObject) {
        
    }
    
    //    创建左侧title
    func createLeftTitle(title : String) {
        
        self.navigationItem.title = ""
        
        let titleLabel = UILabel(Xframe: .zero, text: title, font: FontBold(font: 22), textColor: CSID_MainTextColor,alignment: .left, line: 1)
        
        let leftItem = UIBarButtonItem.init(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    //  创建右侧图片按钮
    func CSID_createRightButtonItem(image : UIImage, target : Any?, action : Selector?) {
        
        let buttonItem = UIBarButtonItem.init(image: image, style: .plain, target: target, action: action)
        self.navigationItem.rightBarButtonItem = buttonItem
    }
    
    //  创建右侧文字按钮
    func CSID_createRightButtonItem(title : String, target : Any?, action : Selector?) {
        
        let buttonItem = UIBarButtonItem.init(title: title, style: .plain, target: target, action: action)
        buttonItem.tintColor = CSID_MainTextColor
        self.navigationItem.rightBarButtonItem = buttonItem
    }
    
    
    /// 展示HUD
    func CSID_HUDShow(){
        
        startAnimating(CGSize(width:80, height: 80), message: "" as String, messageFont: .systemFont(ofSize: 14.0), type: .ballSpinFadeLoader, color: CSID_MainTextColor, padding: 15, displayTimeThreshold: 1, minimumDisplayTime: 2, backgroundColor: .clear, textColor: .darkGray, fadeInAnimation: NVActivityIndicatorView.DEFAULT_FADE_IN_ANIMATION)
        
    }
    
    ///隐藏HUD
    func CSID_hideHUD(){
        stopAnimating()
    }
    
    
    func CSID_showErrorWithText(text:String, view:UIView){
        HUD.flash(.labeledError(title: nil, subtitle: text as String), onView: view, delay: 2.0, completion: nil)
    }
    
    func CSID_showSuccessWithText(text:String, view:UIView){
        HUD.flash(.labeledSuccess(title: nil, subtitle: text as String), onView: view, delay: 1.0, completion: nil)
    }
    
    func CSID_showProgressHUDWithText(text:String,view:UIView){
        HUD.show(.progress, onView: view)
    }
    
    func CSID_hideProgressHUDForView(view:UIView){
        HUD.hide()
    }
    
    ///去登录
    func yxs_goToLoginVC(){
        
        //        self.navigationController?.pushViewController(CSID_LoginViewController(), animated: true)
    }
    
    //返回
    @objc func goLeftVC(){
        CSID_hideHUD()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    ///购买成功通知
    @objc func paySeccessAction(){
        //去除广告
        self.bannerView.removeSubviews()
        
        self.interstitial = nil
    }
    
    //--------------广告服务----------------------
    
    ///创建广告
    func creatADSaction(){
        if(bannerShow){
            
            //bannar广告
            self.bannerView = GADBannerView(adSize: kGADAdSizeBanner)
            self.addBannerViewToView(self.bannerView)
            self.bannerView.adUnitID = BannerADID
            self.bannerView.rootViewController = self
            //加载广告
            self.bannerView.load(GADRequest())
            //广告事件
            self.bannerView.delegate = self
            
        }
        //插页 广告
        self.interstitial = GADInterstitial(adUnitID: InteredADID)
        self.interstitial.delegate = self
        let request = GADRequest()
        self.interstitial.load(request)
        
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
        ])
    }
    
    ///bannar动画方式展示
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        self.bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            self.bannerView.alpha = 1
        })
    }
    
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADUnifiedNativeAd) {
        
    }

    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
        
    }
    
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: GADRequestError) {
        
    }
    
    //插页广告
    @objc func doStarInterstitial() {
        
        if self.interstitial.isReady {
            self.interstitial.present(fromRootViewController: self)
            
        } else {
            
            print("Ad wasn't ready")
            self.perform(#selector(doStarInterstitial), with: self, afterDelay: 1)
            
        }
    }
    ///插屏广告回调结束
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.interstitial = nil
    }
    
}

