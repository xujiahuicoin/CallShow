//
//  CSID_CallShowSiteDetailCollectViewCell.swift
//  CallShow
//
//  Created by 高燕 on 2019/11/27.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit

class CSID_CallShowSiteDetailCollectViewCell: UICollectionViewCell {
    
    let labelWidth : CGFloat = 60
    var csid_callshow_SiteDetailImageView: UIImageView!
    var call_showTitleL: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
         self.backgroundColor=CSID_backGrayColor
        addSiteDetailSubViewwork()
        
    }
    func addSiteDetailSubViewwork() {
        
        csid_callshow_SiteDetailImageView = UIImageView(frame: contentView.bounds)
        csid_callshow_SiteDetailImageView.clipsToBounds = true
        csid_callshow_SiteDetailImageView.contentMode = .scaleAspectFill
        AddRadius(csid_callshow_SiteDetailImageView, rabF: 4)
        contentView.addSubview(csid_callshow_SiteDetailImageView)
        
        call_showTitleL = UILabel.init(frame: CGRect.init(x:self.width-labelWidth, y: self.height-30, width:labelWidth, height:20))
        call_showTitleL.text = "0"
        call_showTitleL.textAlignment = NSTextAlignment.center
        call_showTitleL.textColor = UIColor.white
        call_showTitleL.font = UIFont.font(size:CSID_FontNum_Second)
        
        contentView.addSubview(call_showTitleL)
        
        let remenImgV = UIImageView(image: UIImage(named: "call_show_remen"))
        remenImgV.frame = CGRect(x:self.width-labelWidth-20, y: self.height-30, width: 20, height:20)
        contentView.addSubview(remenImgV)
    
        
    }
    

}
