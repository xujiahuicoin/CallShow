//
//  BaseCollectionViewCell.swift
//  Project
//
//  Created by mac on 2019/6/13.
//  Copyright © 2019 hhl. All rights reserved.
//

import UIKit

class CSID_BaseCollectionViewCell: UICollectionViewCell {
    
    weak var delegate : CSID_ViewEventsDelegate? {
        
        didSet{
            
            self.initBuilds()
        }
    }

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.CSID_initCreatView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     赋值代理（当父View的代理被赋值后，会调用initConfig方法。）
     */
    func initBuilds() {}

    func CSID_initCreatView() {
        
    }
    
//    发送代理方法
    func sendViewDelegateEvent(eventObject : ViewEventObject) {
        
        if self.delegate != nil {
            self.delegate!.CSID_UIViewCollectEvent?(eventObject: eventObject)
        }
    }

//    更新cell
    func CSID_updateCollectionDataToCell(datas : ViewDataObject) {}

}
