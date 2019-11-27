//
//  CSID_CallShow_SiteCollectViewCell.swift
//  CallShow
//
//  Created by 高燕 on 2019/11/26.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit

class CSID_CallShow_SiteCollectViewCell: UICollectionViewCell {
    
    var csid_callshow_SiteImageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=CSID_backGrayColor
        addImageView()
    }
    func addImageView() {
        
        csid_callshow_SiteImageView = UIImageView(frame: contentView.bounds)
        csid_callshow_SiteImageView.clipsToBounds = true
        csid_callshow_SiteImageView.contentMode = .scaleAspectFill
        AddRadius(csid_callshow_SiteImageView, rabF: 4)
        contentView.addSubview(csid_callshow_SiteImageView)
    }
}
