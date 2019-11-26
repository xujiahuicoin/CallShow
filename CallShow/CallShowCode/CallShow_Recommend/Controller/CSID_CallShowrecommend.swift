//
//  CSID_CallShowrecommend.swift
//  CallShow
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit

class CSID_CallShowrecommend: CSID_BaseViewController {
    
    override func viewDidLoad() {
    
        self.title="首页"
        self.call_showRecommandNetwork()
    }
    
   func call_showRecommandNetwork(){
        
        CSID_RequestManager.request(.post, url:callShowFieldList, params:["page":"1",
                                                                                                                "pageSize":"12","productId":"d0f140e5-1d1f-4171-a8e7-8a854d450a0b"], success: {(resltData) in
            
    
            NSLog("resltData = \(resltData)")
//            //定义model
//            let responDict : NSDictionary = resltData as! NSDictionary
//            let listArray = responDict["list"] as! NSArray
//
//           if let dit:Dictionary<String,Any> = responDict as? Dictionary<String,Any>{
//
//               let model = CSID_RecommModel.deserialize(from: dict)
//               self.callShowsRecArrays.add(model!)
//            }
//
                                                                                                                    
        }) { (error) in
            
        }
        
    }

}
