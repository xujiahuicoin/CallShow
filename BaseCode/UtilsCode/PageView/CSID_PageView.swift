//
//  PageView.swift
//  Pro
//
//  Created by mac on 2019/6/19.
//  Copyright © 2019 hhl. All rights reserved.
//

import UIKit

@objc protocol CSID_PageViewDelegate : NSObjectProtocol {
    
    @objc optional func pageView(_ pageView : CSID_PageView, didSelectIndexAt index : Int)
}

class CSID_PageView: UIView {

    weak var delegate : CSID_PageViewDelegate?
    
    var buttonNormalColor : UIColor!
    var buttonSelectedColor : UIColor!
    var CSID_LineColor : UIColor!
    
    var lastButton : UIButton?
    lazy var lineView : UIView = {
        
        let view = UIView.init()
        view.backgroundColor = self.CSID_LineColor
        self.addSubview(view)
        return view
        
    }()
    
    class func pageView() -> CSID_PageView {
        
        let pageView = CSID_PageView.init()
        pageView.initProperty()
        return pageView
    }
    
//    初始化
    func initProperty() {
        
        self.CSID_LineColor = .red
        self.buttonNormalColor = .gray
        self.buttonSelectedColor = .red
    }
    
    func updatePageView(titles : [String], currentIndex : Int = 0) {
        
        for (index, value) in titles.enumerated() {
            
            let button = UIButton.init(type: .custom)
            button.setTitle(value, for: .normal)
            button.setTitleColor(self.buttonNormalColor, for: .normal)
            button.setTitleColor(self.buttonSelectedColor, for: .selected)
            button.titleLabel?.font = FontBold(font: 15)
            button.addTarget(self, action: #selector(self.onButtonClick(button:)), for: .touchUpInside)
            button.tag = 100 + index
            self.addSubview(button)
            
            button.snp.makeConstraints { (make) in
                
                make.left.equalTo(CSID_WidthScreen / CGFloat(titles.count) * CGFloat(index))
                make.top.bottom.equalTo(0)
                make.width.equalTo(CSID_WidthScreen / CGFloat(titles.count))
            }

            if index == currentIndex {
               
                button.isSelected = true
                self.lastButton = button

            }
        }
        
        self.lineView.snp.makeConstraints({ (make) in
            
            make.centerX.equalTo(self.lastButton!)
            make.bottom.equalTo(0)
            make.size.equalTo(CGSize(width: 40, height: 4))
        })
    }
    
    @objc func onButtonClick(button : UIButton) {
        
        self.lastButton?.isSelected = false
        button.isSelected = true
        self.lastButton = button
        
        self.lineView.snp.remakeConstraints { (make) in
            
            make.centerX.equalTo(self.lastButton!)
            make.bottom.equalTo(0)
            make.size.equalTo(CGSize(width: 30, height: 4))
        }
        
        UIView.animate(withDuration: 0.4) {
            
            self.lineView.superview?.layoutIfNeeded()
        }
        
        if self.delegate != nil {
            
            self.delegate?.pageView?(self, didSelectIndexAt: self.lastButton!.tag - 100)
        }
    }
}
