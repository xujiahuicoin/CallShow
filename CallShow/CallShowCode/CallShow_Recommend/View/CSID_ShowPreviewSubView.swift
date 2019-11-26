//
//  CSID_ShowPreviewSubView.swift
//  CallShow
//
//  Created by MAC on 26/11/2019.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit
typealias preViewHiddenBlock = () -> Void

class CSID_ShowPreviewSubView: UIView {
    
    var call_show_preViewHiddeneBlock : preViewHiddenBlock?

    @IBOutlet weak var call_showMiddleViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var call_show_refuceBottomHeightConstriant: NSLayoutConstraint!
    @IBOutlet weak var call_show_acceptBottomHeightConstraint: NSLayoutConstraint!
    
   
    @IBOutlet weak var call_showTtileHeightConstriant: NSLayoutConstraint!
    
    static func previewInstance() -> CSID_ShowPreviewSubView?{
           
           let nibView = Bundle.main.loadNibNamed("CSID_ShowPreviewSubView", owner: nil, options: nil)
           if let view = nibView?.first as? CSID_ShowPreviewSubView{
               return view
           }
           return nil
       }
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           load_init()
       }
       func load_init(){
           
       }
    
    @IBAction func hiddenPreViewButtonAction(_ sender: UIButton) {
        
         if self.call_show_preViewHiddeneBlock != nil {
            self.call_show_preViewHiddeneBlock!()
         }
        self.isHidden = true
    }
      
   
    
    
    
    
 
    
}
