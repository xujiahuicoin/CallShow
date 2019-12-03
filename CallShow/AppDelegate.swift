//
//  AppDelegate.swift
//  CustomizeProject
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 www.CustomizeProject.cn. All rights reserved.

import UIKit
import IQKeyboardManagerSwift
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        /**默认保存---,请求后再保存*/
        UserDefaults.standard.set(false, forKey:playMusicShowVaule)
        UserDefaults.standard.set(false, forKey:playClickStatusVaule)
        
        let path = Bundle.main.path(forResource: "Call_Show_CommonMessageList", ofType: "json")
        let jsonData=NSData(contentsOfFile: path!)
        let jsonResult = try! JSONSerialization.jsonObject(with: jsonData! as Data,                                                     options: JSONSerialization.ReadingOptions.mutableContainers)
        let responDict : NSDictionary = jsonResult as! NSDictionary        
        self.call_show_StartSaveCommonParamsWork(responDict: responDict["data"] as! NSDictionary)
        self.call_showCommonParamsReuestNetwork()
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = CSID_BaseTabBarController.init()
        self.window?.makeKeyAndVisible()
        
        //启用控制键盘功能
        IQKeyboardManager.shared.enable = true
        //点击空白 键盘收回
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        // 友盟
        UMConfigure.initWithAppkey("", channel: "App Store")
        
        //免费次数
        CSID_getFreeTime()
        
        return true
    }
    /**--请求公共参数--*/
    func call_showCommonParamsReuestNetwork(){
        
    CSID_RequestManager.request(.get, url:callShowCommonParamsRequestUrl, params:nil, success: {(resltData) in

               let responDict : NSDictionary = resltData as! NSDictionary
        
                NSLog("resltData = \(responDict)")
                self.call_show_StartSaveCommonParamsWork(responDict: responDict)
        
            }) { (error) in
                
                
            }
    
     }
    
    func call_show_StartSaveCommonParamsWork(responDict : NSDictionary) -> Void {
        
                   let userDefault = UserDefaults.standard
                   userDefault.set(responDict, forKey:commonAllResultDic)
                   userDefault.set(responDict.object(forKey:"commonData"), forKey:commonDataDic)
           
                   userDefault.set(responDict.object(forKey:"callshowzanType"), forKey:callshowzanType)
                   userDefault.set(responDict.object(forKey:"homezanType"), forKey:homezanType)
                   userDefault.set(responDict.object(forKey:"newestCategoryId"), forKey:savenewestCategoryId)
                   userDefault.set(responDict.object(forKey:"recommedCategoryId"), forKey:saverecommedCategoryId)
        
    }
    
    
    ///获取/设置 Vip 免费次数
    func CSID_getFreeTime(){
        CSID_BuyTool().CSID_Pub_GetFreeTimeSet()
    }
    
    lazy var avPlayer:AVAudioPlayer = {
        
        var avPlayer = AVAudioPlayer.init()
        
        let file = Bundle.main.path(forResource: ("call_show_music1" ), ofType: "mp3")
        let url = NSURL(fileURLWithPath: file!)
        do{
            avPlayer = try AVAudioPlayer(contentsOf: url as URL)
            avPlayer.numberOfLoops = -1
            avPlayer.prepareToPlay()
            
        }catch{
            print("mp3 error")
        }
        
        return avPlayer
    }()
    
}
