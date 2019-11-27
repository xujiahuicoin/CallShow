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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor=UIColor.red
        addSiteDetailSubViewwork()
        
    }
    func addSiteDetailSubViewwork() {
        
        csid_callshow_SiteDetailImageView = UIImageView(frame: contentView.bounds)
        csid_callshow_SiteDetailImageView.clipsToBounds = true
        csid_callshow_SiteDetailImageView.contentMode = .scaleAspectFill
        contentView.addSubview(csid_callshow_SiteDetailImageView)
        
        let call_showTitleL :UILabel = UILabel.init(frame: CGRect.init(x:self.width-labelWidth, y: self.height-30, width:labelWidth, height:20))
        call_showTitleL.text = "1921"
        call_showTitleL.textAlignment = NSTextAlignment.center
        call_showTitleL.textColor = UIColor.white
        call_showTitleL.backgroundColor = UIColor.blue
        call_showTitleL.font = UIFont.font(size:CSID_FontNum_Second)
        
        contentView.addSubview(call_showTitleL)
        
        let arrowImgV = UIImageView(image: UIImage(named: "pt_header_bg"))
        arrowImgV.frame = CGRect(x:self.width-labelWidth-20, y: self.height-30, width: 20, height:20)
        arrowImgV.backgroundColor=UIColor.green
        contentView.addSubview(arrowImgV)
    
        
    }
    

}
