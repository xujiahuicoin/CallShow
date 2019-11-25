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


class CSID_BaseViewController: UIViewController,CSID_ViewEventsDelegate,NVActivityIndicatorViewable {
    
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
}
