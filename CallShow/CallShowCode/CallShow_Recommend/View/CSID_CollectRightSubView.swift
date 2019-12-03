//
//  CSID_CollectRightSubView.swift
//  CallShow
//
//  Created by MAC on 26/11/2019.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit
import AVFoundation

typealias csid_rightToolsClickBlock = (_ toolsButton : UIButton , _ toolsTag:NSInteger) ->Void

class CSID_CollectRightSubView: UIView {
    
    @IBOutlet weak var call_show_loveButton: UIButton!
    @IBOutlet weak var call_show_TakePhotoButton: UIButton!
    
    @IBOutlet weak var call_show_musicPopButton: UIButton!
    
    @IBOutlet weak var call_show_settingMusicButton: UIButton!
    
    @IBOutlet weak var call_show_nextMusicView: UIView!
    
    @IBOutlet weak var call_show_musicPlayButton: UIButton!
    
    @IBOutlet weak var call_show_music_nextButton: UIButton!
    @IBOutlet weak var call_show_musci_upButton: UIButton!
    
    var call_show_musicAllArray :NSArray!
    var call_show_nextMusictag :NSInteger!
    var csid_show_rightToolsClickBlock : csid_rightToolsClickBlock?
    
    var appDelegate : AppDelegate!
    
    static func newInstance() -> CSID_CollectRightSubView?{
        
        let nibView = Bundle.main.loadNibNamed("CSID_CollectRightSubView", owner: nil, options: nil)
        if let view = nibView?.first as? CSID_CollectRightSubView{
            
            view.call_show_nextMusictag = 0
            view.call_show_musicAllArray = ["call_show_music1","call_show_music2","call_show_music3","call_show_music4","call_show_music5","call_show_music6","call_show_music7","call_show_music8","call_show_music9","call_show_music10"]
            
            return view
        }
        
        return nil
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load_init()
    }
    
    func load_init(){
        
        appDelegate = (UIApplication.shared.delegate) as? AppDelegate

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
        //--ture
        sender.isSelected = !sender.isSelected
        
        self.call_show_settingMusicButton.isHidden = !sender.isSelected
        self.call_show_nextMusicView.isHidden = !sender.isSelected
        
        let NotifyRecvName = NSNotification.Name(rawValue:playMusicShowNotification)
        NotificationCenter.default.post(name:NotifyRecvName, object: nil, userInfo: ["playmusicShowStatus": sender.isSelected])
        
    }
    
    /**设置铃声*/
    @IBAction func call_show_settingMusicButtonAction(_ sender: UIButton) {
        
        let videoUrl = URL(fileURLWithPath: Bundle.main.path(forResource: (self.call_show_musicAllArray?[self.call_show_nextMusictag] as! String), ofType: "mp3") ?? "")
        let activityVC = UIActivityViewController(activityItems: [videoUrl] , applicationActivities: nil)
        self.getCurrentVC?.present(activityVC, animated: true, completion: nil)
        
    }
    /**暂停播放 通知状态*/
    
    @IBAction func call_show_playpasueButtonAction(_ sender: UIButton){
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            appDelegate.avPlayer.pause()
        }else{
            appDelegate.avPlayer.play()
        }
        
        let NotifyMsgRecvName = NSNotification.Name(rawValue:playClickStatusNotification)
        NotificationCenter.default.post(name:NotifyMsgRecvName, object: nil, userInfo: ["playPauseButton":sender.isSelected])
        
    }
    /**下一首*/
    @IBAction func call_show_nextMusicButtonAction(_ sender: UIButton) {
        
        self.call_show_nextMusictag = self.call_show_nextMusictag+1
        if self.call_show_nextMusictag >= self.call_show_musicAllArray.count{
            self.call_show_nextMusictag = 0
        }
        self.call_show_differentVideoMusicPlayerwork()
        
    }
    //上一首
    @IBAction func call_show_upMusicButtonAction(_ sender: UIButton) {
        
        self.call_show_nextMusictag = self.call_show_nextMusictag-1
        if self.call_show_nextMusictag < 0  {
            self.call_show_nextMusictag = self.call_show_musicAllArray.count-1
        }
        self.call_show_differentVideoMusicPlayerwork()
        
    }
    func call_show_differentVideoMusicPlayerwork() -> Void {
        
        self.call_show_musicPlayButton.isSelected = false
        
        appDelegate.avPlayer.pause()
        let file = Bundle.main.path(forResource: (self.call_show_musicAllArray[self.call_show_nextMusictag] as! String), ofType: "mp3")
        let url = NSURL(fileURLWithPath: file!)
        
        do{
             appDelegate.avPlayer = try AVAudioPlayer(contentsOf: url as URL)
             appDelegate.avPlayer.numberOfLoops = -1
             appDelegate.avPlayer.play()
        }catch{
            
        }
    }
    var getCurrentVC: CSID_BaseViewController? {
        
        var next = superview
        while (next != nil) {
            let nextResponder = next?.next
            if (nextResponder is CSID_BaseViewController) {
                return nextResponder as? CSID_BaseViewController
            }
            next = next?.superview
        }
        return nil
    }
    
}


