//
//  BaseTableViewCell.swift
//  Project
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 hhl. All rights reserved.
//

import UIKit

class CSID_BaseTableViewCell: UITableViewCell {

    weak var delegate : CSID_ViewEventsDelegate? {
        
        didSet{
            
            self.initConfig()
        }
    }
    
    required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.CSID_initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     赋值代理（当父View的代理被赋值后，会调用initConfig方法。）
     */
    func initConfig() {}

    func CSID_initView() {
        
    }
    
//    发送代理方法
    func sendViewDelegateEvent(eventObject : ViewEventObject) {
        
        if self.delegate != nil {
            self.delegate!.CSID_UIViewCollectEvent?(eventObject: eventObject)
        }
    }

//    更新cell
    func CSID_updateTableViewCell(datas : ViewDataObject?) {}
}
