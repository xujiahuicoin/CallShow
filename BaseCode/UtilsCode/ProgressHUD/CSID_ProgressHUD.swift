//
//  ProgressHUD.swift
//  Project
//
//  Created by mac on 2019/6/17.
//  Copyright © 2019 hhl. All rights reserved.
//

import UIKit
import PKHUD

class CSID_ProgressHUD: NSObject {

    class func showSuccess(message : String, view : UIView) {
        
        HUD.flash(.label(message), onView: view, delay: 2, completion: nil)
    }
    
    class func showSuccess(message : String) {
        
        HUD.flash(.label(message), delay: 2, completion: nil)
    }
    
    class func showError(message : String, view : UIView) {
        
        HUD.flash(.label(message), onView: view, delay: 2, completion: nil)
        
    }
    
    class func showError(message : String) {
        
        HUD.flash(.label(message), delay: 1.5, completion: nil)
    }
    
}
