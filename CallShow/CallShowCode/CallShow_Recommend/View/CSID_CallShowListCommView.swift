//
//  CSID_CallShowListCommView.swift
//  CallShow
//
//  Created by MAC on 26/11/2019.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit
import PKHUD
import BSImagePicker
import Photos
typealias  recommendChangeblock = (_ changBool : Bool) -> Void

class CSID_CallShowListCommView: CSID_CallShowBaseView,UICollectionViewDelegate,UICollectionViewDataSource{

    var recommendChangeblock:recommendChangeblock?
    
    var listdataArr : NSArray = NSArray.init()
    var currentModel : CSID_CallShowListModel!
var callShowBlock: (_ imageUrlStr: String) -> Void = {_ in}
    
    var zanUserType : NSString = "1"
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(CSID_CallShow_RecommlistCollView)
        addSubview(call_show_RightView)
        addSubview(call_show_PreviewView)
        
        call_show_RightView.call_show_rightToolsClickFinishBlockAction { (toolsButton, tooltag) in
            
            if tooltag == 0{/**点赞*/
                
                CSID_RequestManager.request(.post, url:callShowloveurl, params:["upType":self.zanUserType,"relationId":self.currentModel.relationId], success: {(resltData) in
                
                            NSLog("resltData = \(resltData)")
                            toolsButton.isSelected = !toolsButton.isSelected
                        self.currentModel.haveUp = !(self.currentModel.haveUp ?? false)
                
                        }) { (error) in

                    }
            }else if tooltag == 1{/**预览*/
                
                self.callShowBlock("")
                
                    self.call_show_PreviewView.isHidden=false
                    self.call_show_RightView.isHidden=true
                    if self.recommendChangeblock != nil {
                        self.recommendChangeblock!(true)
                    }
                
            }else if tooltag == 2{/**设置来电秀*/
                
                 self.callShowBlock("")
                
                let imageUrlStr:String = self.currentModel.imageUrl.count > 0 ? self.currentModel.imageUrl : self.currentModel.imgUrl
                let alertController = UIAlertController()
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                let specifiedAction = UIAlertAction(title: "指定联系人设置", style: .default) { (action) in
                    let callshow:CSID_CallShowViewController = CSID_CallShowViewController.init()
                    //定义URL对象
                    let url = URL(string: imageUrlStr )
                    //从网络获取数据流
                    let data = try! Data(contentsOf: url!)
                    callshow.imageData = data
                    callshow.hidesBottomBarWhenPushed = true
                    self.ParentController(viewself: self).navigationController?.pushViewController(callshow, animated: true)
                }
                let allAction = UIAlertAction(title: "全部人设置", style: .default) { (action) in
                    let alertController = UIAlertController.init(title: "确定要给全部联系人设置来电秀吗？", message: nil, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                    let sureAction = UIAlertAction(title: "确定", style: .default) { (action) in
                        //定义URL对象
                        let url = URL(string: imageUrlStr )
                        //从网络获取数据流
                        let data = try! Data(contentsOf: url!)
                        CSID_CallShowContact.AllContactSettings(imageData: data)
                        HUD.flash(.labeledSuccess(title: nil, subtitle: "来电秀设置成功"), onView: self, delay: 1.0, completion: nil)
                    }
                    alertController.addAction(sureAction)
                    alertController.addAction(cancelAction)
                    self.ParentController(viewself: self).present(alertController, animated: true, completion: nil)
                }
                alertController.addAction(specifiedAction)
                alertController.addAction(allAction)
                alertController.addAction(cancelAction)
                self.ParentController(viewself: self).present(alertController, animated: true, completion: nil)
            }else if tooltag == 3{/**打开相册*/
                
//                self.callShowBlock("")
//
//                let photo = CSID_LocalPhotoViewController.init()
//                photo.hidesBottomBarWhenPushed = true
//                self.ParentController(viewself: self).navigationController?.pushViewController(photo, animated: true)
                
                
                let vc = BSImagePickerViewController()
                vc.maxNumberOfSelections = 1
                
                self.ParentController(viewself: self).bs_presentImagePickerController(vc, animated: true,
                                                select: { (asset: PHAsset) -> Void in
                                                    
                                                    
                                                    // User selected an asset.
                                                    // Do something with it, start upload perhaps?
                }, deselect: { (asset: PHAsset) -> Void in
                    // User deselected an assets.
                    // Do something, cancel upload?
                }, cancel: { (assets: [PHAsset]) -> Void in
                    // User cancelled. And this where the assets currently selected.
                }, finish: { (assets: [PHAsset]) -> Void in
                    // User finished with these assets
                    let selcecImage:UIImage = CSID_ZxhPHAssetToImageTool.PHAssetToImage(asset: assets[0])
                    
                    let photo = CSID_LocalPhotoViewController.init()
                    photo.localPhotoData = selcecImage.pngData()
                    self.ParentController(viewself: self).navigationController?.pushViewController(photo, animated: true)
                    

                }, completion: nil)
                
                
            }
            
        }

        call_show_PreviewView.call_show_preViewHiddeneBlock = { () -> Void in
            
            self.call_show_RightView.isHidden=false
            self.call_show_PreviewView.isHidden = true
            if self.recommendChangeblock != nil {
                self.recommendChangeblock!(false)
            }
        }
        
    }
    
    lazy var call_show_RightView: CSID_CollectRightSubView = {
        () -> CSID_CollectRightSubView in
        
        let call_show_RightView = CSID_CollectRightSubView.newInstance()
        call_show_RightView?.frame = CGRect(x:CSID_WidthScreen-80, y:(CSID_heightScreen-270)/2, width:80, height:270)
        
        return call_show_RightView!
    }()
    
    lazy var call_show_PreviewView: CSID_ShowPreviewSubView = {
         () -> CSID_ShowPreviewSubView in

         let call_show_PreviewView = CSID_ShowPreviewSubView.previewInstance()
         call_show_PreviewView?.frame = CGRect(x:0, y:0, width:CSID_CallShow_RecommlistCollView.width, height:CSID_CallShow_RecommlistCollView.height)
         call_show_PreviewView?.isHidden = true
         call_show_PreviewView?.call_showTtileHeightConstriant.constant = CSID_HeightNav_top+3*CSID_Status_H
    call_show_PreviewView?.call_showMiddleViewWidthConstraint.constant=(CSID_WidthScreen-120)/2
        
        call_show_PreviewView?.call_show_refuceBottomHeightConstriant.constant = CSID_HeightTabBom+CSID_DefaultHeight
        call_show_PreviewView?.call_show_acceptBottomHeightConstraint.constant = CSID_HeightTabBom+CSID_DefaultHeight
           
         return call_show_PreviewView!
     }()
    
    public func csid_CallShow_recommCollectViewRefresh(needArray:NSArray) -> Void {
        
        listdataArr=needArray
        if listdataArr.count>0 {
          self.currentModel = (listdataArr[0] as! CSID_CallShowListModel)
        }
        CSID_CallShow_RecommlistCollView.reloadData()
    }
    
    public func csid_callShow_collectScrollViewCurrentIndex(currentIndex:NSInteger) ->Void{
    
        CSID_CallShow_RecommlistCollView.contentOffset=CGPoint(x: 0, y: self.height * CGFloat(currentIndex))
        
        self.currentModel = (listdataArr[currentIndex] as! CSID_CallShowListModel)
    }
    
    lazy var CSID_CallShow_RecommlistCollView : UICollectionView = {
        
        var layout = UICollectionViewFlowLayout()
        //设置每一个cell_View的宽高
        layout.itemSize = CGSize(width:CSID_WidthScreen,height:CSID_heightScreen+CSID_Status_H)
        
        //设置最小的行间距
        layout.minimumLineSpacing = 0
        //设置最小的列间距
        layout.minimumInteritemSpacing = 0
        
        let CSID_CallShow_RecommlistCollView : UICollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: CSID_WidthScreen, height: CSID_heightScreen+CSID_Status_H), collectionViewLayout: layout)
        CSID_CallShow_RecommlistCollView.backgroundColor = CSID_MainTextColor
    CSID_CallShow_RecommlistCollView.register(CSID_CallShowRecommCellCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "RecommCell")
        CSID_CallShow_RecommlistCollView.isPagingEnabled = true
        CSID_CallShow_RecommlistCollView.delegate = self
        CSID_CallShow_RecommlistCollView.dataSource = self
        CSID_CallShow_RecommlistCollView.showsVerticalScrollIndicator = false
        CSID_CallShow_RecommlistCollView.showsHorizontalScrollIndicator = false
        
        return CSID_CallShow_RecommlistCollView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return listdataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell_View:CSID_CallShowRecommCellCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommCell", for: indexPath) as! CSID_CallShowRecommCellCollectionViewCell
              
        let model = listdataArr[indexPath.row] as! CSID_CallShowListModel
        
        call_show_RightView.call_show_loveButton.isSelected = model.haveUp ?? false
        
        cell_View.configCellWithModel(model: model)
        
        return cell_View
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        
        let currentPage = Int(scrollView.contentOffset.y/CSID_heightScreen)
        if listdataArr.count>0 {
            currentModel = (listdataArr[currentPage] as! CSID_CallShowListModel)
            call_show_RightView.call_show_loveButton.isSelected = currentModel.haveUp ?? false
        }

    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
