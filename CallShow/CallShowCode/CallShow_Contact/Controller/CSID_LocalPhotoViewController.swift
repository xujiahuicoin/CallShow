import UIKit
import BSImagePicker
import Photos
class CSID_LocalPhotoViewController: CSID_BaseViewController {
    
    @IBOutlet weak var backgroudImg: UIImageView!
    @IBOutlet weak var rightView: UIView!
    var call_show_PreviewView:CSID_ShowPreviewSubView?
    var localPhotoData:Data?
    var isHidesPreview:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bannerShow = false
        self.isHidesPreview = true
        let image:UIImage = UIImage.init(named: "call_show_localbg")!
        self.localPhotoData = image.pngData()
        self.call_show_PreviewView = CSID_ShowPreviewSubView.previewInstance()
        self.call_show_PreviewView?.frame = CGRect(x:0, y:0, width:CSID_WidthScreen, height:CSID_heightScreen)
        self.call_show_PreviewView?.call_showTtileHeightConstriant.constant = CSID_HeightNav_top+3*CSID_Status_H
        self.call_show_PreviewView?.call_showMiddleViewWidthConstraint.constant=(CSID_WidthScreen-120)/2
        self.call_show_PreviewView?.call_show_refuceBottomHeightConstriant.constant = CSID_HeightTabBom+CSID_DefaultHeight
        self.call_show_PreviewView?.call_show_acceptBottomHeightConstraint.constant = CSID_HeightTabBom+CSID_DefaultHeight
        view.addSubview(self.call_show_PreviewView!)
        self.call_show_PreviewView?.isHidden = true
        
        
        
        self.call_show_PreviewView!.call_show_preViewHiddeneBlock = { () -> Void in
            self.rightView.isHidden=false
            self.call_show_PreviewView?.isHidden = true
        }
        
        
        view.addSubview(BackBotton)
        
        clickLocalPhotoButton(UIButton())
        
        if !self.CSID_Pub_isVip() {
            showAlert(title: "提示", message: "非VIP用户，有一次【指定联系人设置】体验机会")
        }
    }
    
    
    
    /**返回按钮*/
    lazy var BackBotton : UIButton = {
        
        let back : UIButton = UIButton.init(frame: CGRect.init(x:0, y:CSID_Status_H, width:CSID_HeightNav, height:CSID_HeightNav))
        back.setImage(UIImage.init(named: "fanhuibai_img1"), for:.normal)
        back.addTarget(self, action: #selector(backButtonViewAction), for: .touchUpInside)
        
        return back
    }()
    
    @objc func backButtonViewAction(sender:UIButton) -> Void {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool){
        
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    @IBAction func clickYuLanButton(_ sender: UIButton) {
        self.rightView.isHidden = true
        self.call_show_PreviewView?.isHidden = false
    }
    
    
    
    @IBAction func clickSetButton(_ sender: UIButton) {
        let alertController = UIAlertController()
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let specifiedAction = UIAlertAction(title: "指定联系人设置", style: .default) { (action) in
            
            ///是不是VIP
            if !self.CSID_Pub_isVip() {
                
                ///提示 非VIP用户有一次试用机会
                if  CSID_BuyTool().CSID_JudgeHaveFreeTime() {
                    //有
                    //设置免费次数为0
                    CSID_BuyTool().CSID_Pub_setFreeTime0()
                    
                }else{
                    //没有   去购买
                    self.CSID_showErrorWithText(text: "已没有免费次数，请购买VIP")
                    self.CSID_Pub_GoToBuyVIPvc()
                    return
                }
                
            }
            ///没有机会了去购买VIP
            
            let callshow:CSID_CallShowViewController = CSID_CallShowViewController.init()
            
            callshow.imageData = self.localPhotoData
            callshow.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(callshow)
        }
        let allAction = UIAlertAction(title: "全部人设置", style: .default) { (action) in
            
            if !self.CSID_Pub_isVip() {
                
                //不是VIP 去购买
                self.CSID_Pub_GoToBuyVIPvc()
                return
            }
            
            let alertController = UIAlertController.init(title: "确定要给全部联系人设置来电秀吗？", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let sureAction = UIAlertAction(title: "确定", style: .default) { (action) in
                
                //设置全部
                CSID_CallShowContact.AllContactSettings(imageData: self.localPhotoData!)
                self.CSID_showSuccessWithText(text: "来电秀设置成功", view: self.view)
            }
            alertController.addAction(sureAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
        alertController.addAction(specifiedAction)
        alertController.addAction(allAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func clickLocalPhotoButton(_ sender: Any) {
        let vc = BSImagePickerViewController()
        vc.maxNumberOfSelections = 1
        
        bs_presentImagePickerController(vc, animated: true,
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
            
            self.backgroudImg.image = selcecImage
            self.localPhotoData = selcecImage.pngData()
        }, completion: nil)
    }
    
}
