//
//  CSID_CallShowRecommCellCollectionViewCell.swift
//  CallShow
//
//  Created by MAC on 26/11/2019.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit

class CSID_CallShowRecommCellCollectionViewCell: UICollectionViewCell {
    
     var csid_callshow_ImageView: UIImageView!
    
     required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = CSID_MainTextColor
        addImageView()
    }
    func addImageView() {
        
        csid_callshow_ImageView = UIImageView(frame: contentView.bounds)
        csid_callshow_ImageView.clipsToBounds = true
        csid_callshow_ImageView.contentMode = .scaleAspectFill
        contentView.addSubview(csid_callshow_ImageView)
    }
    
    func configCellWithModel(model:CSID_CallShowListModel){

        csid_callshow_ImageView.kf.setImage(with: URL(string: model.imageUrl.count > 0 ? model.imageUrl : model.imgUrl ), placeholder: UIImage(named: "placeholder"))
    }
}
