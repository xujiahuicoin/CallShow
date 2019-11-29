//
//  CSID_CollectRightSubView.swift
//  CallShow
//
//  Created by MAC on 26/11/2019.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit

typealias csid_rightToolsClickBlock = (_ toolsButton : UIButton , _ toolsTag:NSInteger) ->Void

class CSID_CollectRightSubView: UIView {
    
    @IBOutlet weak var call_show_loveButton: UIButton!
    @IBOutlet weak var call_show_TakePhotoButton: UIButton!
    
    @IBOutlet weak var call_show_musicPopButton: UIButton!
    
    @IBOutlet weak var call_show_settingMusicButton: UIButton!
    
    @IBOutlet weak var call_show_nextMusicView: UIView!
    
    @IBOutlet weak var call_show_musicPlayButton: UIButton!
    
    @IBOutlet weak var call_show_music_nextButton: UIButton!
    
    
    var csid_show_rightToolsClickBlock : csid_rightToolsClickBlock?
    
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
    /**喜欢*/
    @IBAction func call_show_loveButtonAction(_ sender: UIButton) {
        
        if csid_show_rightToolsClickBlock != nil {
               csid_show_rightToolsClickBlock!(sender,0)
         }

    }
  
    /**预览*/
    @IBAction func call_show_eyeLookButtonAction(_ sender: UIButton) {
        
        if csid_show_rightToolsClickBlock != nil {
               csid_show_rightToolsClickBlock!(sender,1)
         }
    }
    
    /**设置来电秀*/
    @IBAction func call_show_callPhoneButtonAction(_ sender: UIButton) {

         if csid_show_rightToolsClickBlock != nil {
                csid_show_rightToolsClickBlock!(sender,2)
          }
    }
    /**打开相机*/
    @IBAction func call_show_takePhotoButtonAction(_ sender: UIButton) {
        
        if csid_show_rightToolsClickBlock != nil {
            csid_show_rightToolsClickBlock!(sender,3)
        }
        
    }
    
    func call_show_rightToolsClickFinishBlockAction( csid_rightToolsClickBlock :  @escaping (_ toolsButton: UIButton , _ toolTag: NSInteger) -> Void){
        
        csid_show_rightToolsClickBlock = csid_rightToolsClickBlock
    }
    /**点击铃声*/
    @IBAction func call_show_musicPopButtonAction(_ sender: UIButton) {
    
        sender.isSelected = !sender.isSelected
        
        self.call_show_settingMusicButton.isHidden = !sender.isSelected
        self.call_show_nextMusicView.isHidden = !sender.isSelected
        
    }
    
    /**设置铃声*/
    @IBAction func call_show_settingMusicButtonAction(_ sender: UIButton) {
        
//        let videoUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "call_show_music1", ofType: "mp3") ?? "")
//        let activityVC = UIActivityViewController(activityItems: [videoUrl] , applicationActivities: nil)
//        present(activityVC, animated: true, completion: nil)
        
    }
    /**暂停播放*/
    
    @IBAction func call_show_playpasueButtonAction(_ sender: UIButton) {
        
        
    }
    /**下一首*/
    @IBAction func call_show_nextMusicButtonAction(_ sender: UIButton) {
        
    }
    
}


