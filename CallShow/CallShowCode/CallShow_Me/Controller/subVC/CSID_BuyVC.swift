//
//  CSID_BuyVC.swift
//  CallShow
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit

class CSID_BuyVC: CSID_BaseViewController {
    
    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var juhua: UIActivityIndicatorView!
    @IBOutlet weak var xiaojuhua: UIView!
    
    @IBOutlet weak var serverBtn: UIButton!
    
    @IBOutlet weak var restoreBtn: UIButton!
    
    @IBOutlet weak var yinsiBtn: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addlineDown()
        //隐藏 bannar 广告
        self.bannerShow = false
        // Do any additional setup after loading the view.
    }
    ///购买成功
    @objc override func paySeccessAction(){
        
        goLeftVC()
    }
    func addlineDown(){
        
        serverBtn.underline()
        restoreBtn.underline()
        yinsiBtn.underline()
        
    }
    
    ///试用3天，月订阅
    @IBAction func buyActionTesting(_ sender: Any) {
        buyChangeUI()
        
        CSID_BuyTool().applePayWithProductId(ProductId: "78909")
        
    }
    ///购买半年
    @IBAction func buyActionHalfYear(_ sender: Any) {
        buyChangeUI()
        
        CSID_BuyTool().applePayWithProductId(ProductId: "78909")
    }
    
    ///    购买恢复 事件UI
    func buyChangeUI(){
        xiaojuhua.isHidden = false
        juhua.isHidden = false
        closeBtn.isHidden = true
    }
    
    ///服务协议
    @IBAction func searverAction(_ sender: Any) {
        
        let subVC = CSID_WkWebViC.init()
        subVC.hidesBottomBarWhenPushed = true
        subVC.CSID_Str_title = "服务条款"
        subVC.CSID_Int_type =  2
        subVC.CSID_Str_UrlOrBody = "server"
        self.navigationController?.pushViewController(subVC, animated: true)
        
    }
    ///恢复购买
    @IBAction func returnbuyAction(_ sender: Any) {
        buyChangeUI()
        
        CSID_BuyTool().restorePurchase()
    }
    ///隐私政策
    @IBAction func yinsiAction(_ sender: Any) {
        
        let subVC = CSID_WkWebViC.init()
        subVC.hidesBottomBarWhenPushed = true
        subVC.CSID_Str_title = "隐私政策"
        subVC.CSID_Int_type =  2
        subVC.CSID_Str_UrlOrBody = "yinsi"
        self.navigationController?.pushViewController(subVC, animated: true)
    }
    
    
    @IBAction func leftCloseAction(_ sender: Any) {
        
        goLeftVC()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}