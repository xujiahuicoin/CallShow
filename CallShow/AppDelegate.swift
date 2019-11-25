//
//  AppDelegate.swift
//  CustomizeProject
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 www.CustomizeProject.cn. All rights reserved.

import UIKit
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = CSID_BaseTabBarController.init()
        self.window?.makeKeyAndVisible()
        
        //启用控制键盘功能
        IQKeyboardManager.shared.enable = true
        //点击空白 键盘收回
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
//        Bugly.startWithAppId(Tencent_APPID)
        return true
    }
    
}