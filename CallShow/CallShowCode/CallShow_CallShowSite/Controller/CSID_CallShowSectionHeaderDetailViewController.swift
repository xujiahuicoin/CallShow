//
//  CSID_CallShowSectionHeaderDetailViewController.swift
//  CallShow
//
//  Created by MAC on 27/11/2019.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit

class CSID_CallShowSectionHeaderDetailViewController: CSID_BaseViewController,UICollectionViewDataSource,UICollectionViewDelegate{

     override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "城市风光"
        view.addSubview(CSID_CallShow_SiteDetailCollView)
        
    }
    lazy var CSID_CallShow_SiteDetailCollView : UICollectionView = {
        
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:(CSID_WidthScreen-30)/2,height:(CSID_WidthScreen-30)/2*1.5)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
    
        let CSID_CallShow_SiteDetailCollView : UICollectionView = UICollectionView.init(frame: CGRect.init(x: 10, y: 0, width: CSID_WidthScreen-20, height: CSID_heightScreen-CSID_HeightTabBom), collectionViewLayout: layout)
        
        CSID_CallShow_SiteDetailCollView.backgroundColor = UIColor.white
        CSID_CallShow_SiteDetailCollView.register(CSID_CallShowSiteDetailCollectViewCell.classForCoder(), forCellWithReuseIdentifier:"SiteDetailCell")
        CSID_CallShow_SiteDetailCollView.delegate = self
        CSID_CallShow_SiteDetailCollView.dataSource = self
        CSID_CallShow_SiteDetailCollView.showsVerticalScrollIndicator = false
        CSID_CallShow_SiteDetailCollView.showsHorizontalScrollIndicator = false
        
        return CSID_CallShow_SiteDetailCollView
        
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell_View:CSID_CallShowSiteDetailCollectViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:"SiteDetailCell", for: indexPath) as! CSID_CallShowSiteDetailCollectViewCell
        
        return cell_View
    }

}
