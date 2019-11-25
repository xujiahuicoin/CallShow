//
//  BaseCollectionView.swift
//  Project
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 hhl. All rights reserved.
//

import UIKit

class CSID_BaseCollectionView: CSID_BaseView,UICollectionViewDelegate,UICollectionViewDataSource {

    var datas = [Any]()
    var collectionView : UICollectionView?
    
//    重写父类初始化方法
    override class func view() -> Self! {
        
        let instance = self.init()
        instance.makeCollectionView()
        instance.initCSID_View()
        return instance
    }
    
    override class func view(parmas : ViewDataObject) -> Self! {
        
        let instance = self.init()
        instance.makeCollectionView()
        instance.initCSID_View(parmas: parmas)
        return instance
    }
    
    func cCreateErrorView(_ error: CSID_Error, showErrorMessage: Bool = true, errorMessage: String? = nil) {
                
        if self.datas.count == 0 {
            super.createErrorView(error, showErrorMessage: showErrorMessage)
        }else {
            if showErrorMessage == true {
                if errorMessage == nil {
                    CSID_ProgressHUD.showError(message: error.localizedDescription)
                }else {
                    CSID_ProgressHUD.showError(message: errorMessage!)
                }
            }
        }
        
        self.endRefresh()
    }

    func makeCollectionView() {
        
        self.collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        self.collectionView?.backgroundColor = CSID_LineColor
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.autoresizesSubviews = true
        self.collectionView?.autoresizingMask = .flexibleHeight
        self.collectionView?.keyboardDismissMode = .onDrag
        self.addSubview(self.collectionView!)
        
        if #available(iOS 11.0, *){
            self.collectionView?.contentInsetAdjustmentBehavior = .never
        }
        
        self.collectionView?.snp.makeConstraints({ (make) in
            
            make.edges.equalTo(0)
        })
    }

//    默认更新collectionView方法
    func CSID_updateCollecDataToView(datas : Array<Any>) {
        
        self.datas = datas
        
        DispatchQueue.main.async {
            self.CSID_hiddenHud()
            self.collectionView?.reloadData()
        }
    }

    func CSID_addDownPullToRefresh() {
        
        self.collectionView?.es.addPullToRefresh {
            
            self.sendViewDelegateEvent(eventObject: ViewEventObject.CSID_viewEventObject(eventType: CSID_PullDown, params: nil, uiView: self))
        }
    }
    
    func CSID_addUpPullToRefresh() {
        
        self.collectionView?.es.addInfiniteScrolling {
            
            self.sendViewDelegateEvent(eventObject: ViewEventObject.CSID_viewEventObject(eventType: CSID_PullUp, params: nil, uiView: self))
        }
    }
    
    func endRefresh() {
        
        if self.collectionView?.header?.isRefreshing == true {
            self.collectionView?.header?.stopRefreshing()
        }
        
        if self.collectionView?.footer?.isRefreshing == true {
            self.collectionView?.footer?.stopRefreshing()
        }
    }

//    UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = CSID_BaseCollectionViewCell.init()
        return cell
    }
}
