//
//  CSID_MyViewController.swift
//  CallShow
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit



class CSID_CallShowMe: CSID_BaseViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人中心"
        
        // Do any additional setup after loading the view.
    }
    
    
    ///点赞
    @IBAction func CSID_Pri_MyDianzan_Acion(){
        
    }
    
    ///分享
    @IBAction func CSID_Pri_MyShare_Acion(){
        
    }
    
    ///用户反馈
    @IBAction func CSID_Pri_MyFankui_Acion(){
        
        self.navigationController?.pushViewController(CSID_MyHelpsVC())
        
    }
    
    ///清理缓存
    @IBAction func CSID_Pri_MyClear_Acion(){
        
    }
    
    ///隐私政策
    @IBAction func CSID_Pri_MyYinSi_Acion(){
        
    }
    
    ///购买APp
    @IBAction func CSID_Pri_MyBuyApp_Acion(){
        self.navigationController?.pushViewController(CSID_BuyVC())
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
