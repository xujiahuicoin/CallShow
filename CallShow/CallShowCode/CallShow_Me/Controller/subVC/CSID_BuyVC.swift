//
//  CSID_BuyVC.swift
//  CallShow
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit
import StoreKit
class CSID_BuyVC: CSID_BaseViewController,SKPaymentTransactionObserver,SKProductsRequestDelegate {
    
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
        
        SKPaymentQueue.default().add(self)
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
        
        self.applePayWithProductId(ProductId: "78909")
        
    }
    ///购买半年
    @IBAction func buyActionHalfYear(_ sender: Any) {
        buyChangeUI()
        
        self.applePayWithProductId(ProductId: "78909")
    }
    
    ///    购买恢复 事件UI
    func buyChangeUI(){
        //        xiaojuhua.isHidden = false
        //        juhua.isHidden = false
        //        closeBtn.isHidden = true
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
        
        self.restorePurchase()
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
    
    //--------------购买----------------------
    ///开始购买产品 根据产品ID
    func applePayWithProductId(ProductId: String){
        
        CSID_ProgressHUD.show()
        //判断app是否支持支付
        if SKPaymentQueue.canMakePayments(){
            //支持购买
            //请求苹果商品
            let request = SKProductsRequest.init(productIdentifiers: Set(arrayLiteral: ProductId))
            request.delegate = self
            //开始请求
            request.start()
            
        }else{
            //不支持购买
            self.buyReturnState(.buy_noSupport)
        }
        
    }
    
    
    // 1.接收到产品的返回信息,然后用返回的商品信息进行发起购买请求
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        //判断服务器是否有产品
        if response.products.count < 1 {
            //服务器没有产品
          self.buyReturnState(.buy_noOrder)
            
        }else{
            //有商品  获取订单  目前是一个商品的支付
            let requestProduct: SKProduct = response.products[0]
            
            //发起购买请求
            let payment = SKPayment(product: requestProduct)
            
            SKPaymentQueue.default().add(payment)
            
        }
    }
    
    ///请求失败 回调
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        self.buyReturnState(.buy_false)
        
    }
    
    func requestDidFinish(_ request: SKRequest) {
        print("信息返回结束")
        
    }
    
    //---------------恢复购买---------------------
    ///恢复购买
    func restorePurchase(){
        CSID_ProgressHUD.show()
        //回调已经购买过的商品
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    ///获取已经购买过的内购项目
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        
        if queue.transactions.count < 1{
            //没有已购买项目。恢复失败
         self.buyReturnState(.buy_reBuy)
            
            
        }else{
            
            for transaction: SKPaymentTransaction in queue.transactions {
                //恢复购买的商品ID
                let productID = transaction.payment.productIdentifier
                print("可以恢复购买的商品ID\(productID)")
                
                //                if transaction.transactionState == SKPaymentTransactionStateRestored{
                //
                //                }
                
            }
            
        }
    }
    
    //恢复内购失败调用-比如用户没有登录apple id 手动取消恢复
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        self.buyReturnState(.buy_reBuy)
        
    }
    
    //------------------------------------购买和恢复都会回调
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        
        for tran:SKPaymentTransaction in transactions {
            
            switch tran.transactionState {
            case .purchasing:
                do {
                    ///正在购买
                    print("商品添加进列表")
                }
                
            case .purchased:
                do {
                    //购买成功-第一次购买和恢复已购项目都会回调这个
                    buySuccessAddUserCount()
                    SKPaymentQueue.default().finishTransaction(tran)
                }
            case .restored:
                do{
                    //购买已经购买过的商品的商品会回调这个
                    buySuccessAddUserCount()
                    SKPaymentQueue.default().finishTransaction(tran)
                }
            case .failed:
                do{
                    
                    //购买失败
                    SKPaymentQueue.default().finishTransaction(tran)
                  self.buyReturnState(.buy_false)
                    
                }
            default:
                
                SKPaymentQueue.default().finishTransaction(tran)
                
                self.buyReturnState(.buy_false)
            }
        }
        
    }
    
    ///添加用户权益
    func buySuccessAddUserCount(){
        //成功回调
        //设置VIP
        DispatchQueue.main.async(execute: {
            ///设置VIP yes
            CSID_BuyTool().CSID_SetVipUser()
            
            self.buyReturnState(.buy_success)

            //发送购买成功通知
            NotificationCenter.default.post(name: NSNotification.Name(paySuccess), object: nil)
        })
    }
    
    ///购买失败
    func buyReturnState(_ state:buyStateErrro){
        
        DispatchQueue.main.async(execute: {
            CSID_ProgressHUD.hide()
            CSID_ProgressHUD.showError(message: state.rawValue)
        })
        
    }
    
    enum buyStateErrro : String {
        case buy_noSupport = "当前手机不支持购买"
        case buy_success = "购买成功"
        case buy_false = "购买失败，请重试"
        case buy_reBuy = "恢复购买失败"
        case buy_noOrder = "当前产品已失效"
    }
}
