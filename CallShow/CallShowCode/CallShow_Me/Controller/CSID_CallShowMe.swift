//
//  CSID_MyViewController.swift
//  CallShow
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit
import StoreKit


class CSID_CallShowMe: CSID_BaseViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人中心"
        
        // Do any additional setup after loading the view.
    }
    
    
    ///点赞
    @IBAction func CSID_Pri_MyDianzan_Acion(){
        
        self.navigationController?.pushViewController(CSID_LikeListVC())
        
    }
    
    ///分享
    @IBAction func CSID_Pri_MyShare_Acion(){
        
        let textToShare = "来电秀"
         let imageToShare = UIImage.init(named: "CSID_buy_BannerImg")
         let urlToShare = NSURL.init(string: "")
         let items = [textToShare,imageToShare ?? "WeShare",urlToShare ?? "WeShare"] as [Any]
         let activityVC = UIActivityViewController(
             activityItems: items,
             applicationActivities: nil)
        activityVC.completionWithItemsHandler =  { activity, success, items, error in
        
             
         }
         self.present(activityVC, animated: true, completion: { () -> Void in
             
         })
        
    }
    
    ///用户好评
    @IBAction func CSID_Pri_MyFankui_Acion(){
        
//        self.navigationController?.pushViewController(CSID_MyHelpsVC())
     //一句话实现在App内直接评论了。然而需要注意的是：打开次数一年不能多于3次。（当然开发期间可以无限制弹出，方便测试）
        //import StoreKit
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            // Fallback on earlier versions
            //当前版本不支持
            CSID_showProgressHUDWithText(text: "当前版本不支持", view: self.view)
        }
        
        
    }
    
    ///清理缓存
    @IBAction func CSID_Pri_MyClear_Acion(){
        
        clearCache()
        
    }
    
    ///隐私政策
    @IBAction func CSID_Pri_MyYinSi_Acion(){
        
        let subVC = CSID_WkWebViC.init()
          subVC.hidesBottomBarWhenPushed = true
          subVC.CSID_Str_title = "隐私政策"
          subVC.CSID_Int_type =  2
          subVC.CSID_Str_UrlOrBody = "yinsi"
          self.navigationController?.pushViewController(subVC, animated: true)
    }
    
    ///购买APp
    @IBAction func CSID_Pri_MyBuyApp_Acion(){
        self.navigationController?.pushViewController(CSID_BuyVC())
    }
    
    //删除缓存
    func clearCache() {
        CSID_HUDShow()
        //cache文件夹
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        //文件夹下所有文件
        let files = FileManager.default.subpaths(atPath: cachePath!)!
        
        //遍历删除
        for file in files {
            //文件名
            let path = cachePath! + "/\(file)"
            //存在就删除
            if FileManager.default.fileExists(atPath: path) {
                do {
                    try FileManager.default.removeItem(atPath: path)
                } catch {
                    print("出错了！")
                }
            }
        }
        CSID_hideHUD()
//       let cacheSize = getCacheSize()
        
        CSID_showSuccessWithText(text: "清理缓存成功", view: self.view)
    }
    //获取缓存大小
    func getCacheSize() -> String {
        //cache文件夹
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        //文件夹下所有文件
        let files = FileManager.default.subpaths(atPath: cachePath!)!
        //遍历计算大小
        var size = 0
        for file in files {
            //文件名拼接到路径中
            let path = cachePath! + "/\(file)"
            //取出文件属性
            do {
                let floder = try FileManager.default.attributesOfItem(atPath: path)
                for (key, fileSize) in floder {
                    //累加
                    if key == FileAttributeKey.size {
                        size += (fileSize as AnyObject).integerValue
                    }
                }
            } catch {
                print("出错了！")
            }
            
        }
        
        let totalSize = Double(size) / 1024.0 / 1024.0
        return String(format: "%.1fM", totalSize)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
