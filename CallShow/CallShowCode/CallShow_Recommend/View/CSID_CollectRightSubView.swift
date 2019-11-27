//
//  CSID_CollectRightSubView.swift
//  CallShow
//
//  Created by MAC on 26/11/2019.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit
typealias  loveblock = ( _ loveButton : UIButton) -> Void
typealias  eyelookblock = (_ eyeButton : UIButton) ->Void
typealias setCallShowBlock = (_ callShowButton : UIButton) ->Void

class CSID_CollectRightSubView: UIView {
    
    @IBOutlet weak var call_show_loveButton: UIButton!
    
    var call_show_loveBlock : loveblock?
    var call_show_eyeBlock : eyelookblock?
    var call_show_callShowBlock : setCallShowBlock?
    
    static func newInstance() -> CSID_CollectRightSubView?{
        
        let nibView = Bundle.main.loadNibNamed("CSID_CollectRightSubView", owner: nil, options: nil)
        if let view = nibView?.first as? CSID_CollectRightSubView{
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
    
    func call_show_loveBlockAction ( loveblock: @escaping (_ loveButton: UIButton) -> Void ) {

        call_show_loveBlock = loveblock
     }
    //喜欢
    @IBAction func call_show_loveButtonAction(_ sender: UIButton) {
        
        if call_show_loveBlock != nil{
           call_show_loveBlock!(sender)
        }

    }
    func call_show_eyeLookBlockAction( eyelookblock: @escaping (_ eyeButton: UIButton) -> Void) {
        
         call_show_eyeBlock = eyelookblock
    }
    
    //预览
    @IBAction func call_show_eyeLookButtonAction(_ sender: UIButton) {
        
        if call_show_eyeBlock != nil {
           call_show_eyeBlock!(sender)
        }
    }
    
    func call_show_callShowBlockAction( callshowblock: @escaping (_ callshowBtn : UIButton) -> Void){
        
        call_show_callShowBlock = callshowblock
    }
    //设置来电秀
    @IBAction func call_show_callPhoneButtonAction(_ sender: UIButton) {
    
        if call_show_callShowBlock != nil {
            call_show_callShowBlock!(sender)
        }
    
    }
    
}


