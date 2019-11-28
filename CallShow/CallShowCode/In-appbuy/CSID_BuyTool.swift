//
//  CSID_BuyTool.swift
//  CallShow
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

let paySuccess = "paySuccess"

import UIKit
import StoreKit
class CSID_BuyTool: NSObject,SKPaymentTransactionObserver,SKProductsRequestDelegate {
    
    let vipKeyStr = "vipKeyString"
    ///免费试用次数——Key
    let getFreeTime_key = "getFreeTime"
    
    ///判断还有没有免费试用次数，根据UUID
    func CSID_JudgeHaveFreeTime()->Bool{
        
        let freetime : Bool = UserDefaults.standard.object(forKey: getFreeTime_key) as! Bool
        
        if freetime {
            return true
        }else{
            return false
        }
        
    }
    
    //    设置免费次数
    func CSID_Pub_setFreeTime0(){
        
        let manager = KeychainManager.default()
         manager.save(getFreeTime_key, data: "yes")
        //已有数据 设置次数为
        UserDefaults.standard.set(false, forKey: getFreeTime_key)
        
    }
    ///查看有么有免费次数
    func CSID_Pub_GetFreeTimeSet(){
        let manager = KeychainManager.default()
        
        let data:String = manager.load(getFreeTime_key) as? String ?? ""
        
        if data.count < 1 {
            //还没有数据 设置次数为true
            UserDefaults.standard.set(true, forKey: getFreeTime_key)
            
        }else {
            //已有数据 设置次数为0
            UserDefaults.standard.set(false, forKey: getFreeTime_key)
        }
    }
    
    ///判断是不是VIP
    func CSID_JudgeIsVipBool() -> Bool{
        
        let vip = UserDefaults.standard.object(forKey: vipKeyStr)
        if (vip != nil) {
            return vip! as! Bool
        }else{
            return false
        }
        
    }
    
    ///设置VIP用户
    func CSID_SetVipUser(){
        UserDefaults.standard.set(true, forKey: vipKeyStr)
    }
    //--------------购买----------------------
    ///开始购买产品 根据产品ID
    func applePayWithProductId(ProductId: String){
        
        
        SKPaymentQueue.default().add(self)
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
            CSID_ProgressHUD.showError(message: "购买失败，请重试")
        }
        
    }
    
    
    // 1.接收到产品的返回信息,然后用返回的商品信息进行发起购买请求
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        //判断服务器是否有产品
        if response.products.count < 1 {
            //服务器没有产品
            
            CSID_ProgressHUD.showError(message: "购买失败，请重试")
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
        
        
        CSID_ProgressHUD.showError(message: "购买失败，请重试")
    }
    
    func requestDidFinish(_ request: SKRequest) {
        print("信息返回结束")
    }
    
    //---------------恢复购买---------------------
    ///恢复购买
    func restorePurchase(){
        
        //回调已经购买过的商品
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    ///获取已经购买过的内购项目
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        
        if queue.transactions.count < 1{
            //没有已购买项目。恢复失败
            
            CSID_ProgressHUD.showError(message: "恢复购买失败")
            
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
        
        
    }
    
    //------------------------------------购买和恢复都会回调
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        
        for tran:SKPaymentTransaction in transactions {
            
            switch tran.transactionState {
            case .purchasing:
                do {
                    
                    print("商品添加进列表")
                }
                
            case .purchased:
                do {
                    //购买成功-第一次购买和恢复已购项目都会回调这个
                    
                    addUserCount()
                    SKPaymentQueue.default().finishTransaction(tran)
                }
            case .restored:
                do{
                    //购买已经购买过的商品的商品会回调这个
                    addUserCount()
                    SKPaymentQueue.default().finishTransaction(tran)
                }
            case .failed:
                do{
                    
                    //购买失败
                    SKPaymentQueue.default().finishTransaction(tran)
                }
            default:
                
                SKPaymentQueue.default().finishTransaction(tran)
            }
        }
        
    }
    
    ///添加用户权益
    func addUserCount(){
        //成功回调
        //设置VIP
        self.CSID_SetVipUser()
        CSID_ProgressHUD.showSuccess(message: "购买成功")
        //发送购买成功通知
        NotificationCenter.default.post(name: NSNotification.Name(paySuccess), object: nil)
    }
}
