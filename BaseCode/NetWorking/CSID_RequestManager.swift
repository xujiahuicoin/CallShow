//
//  RequestManager.swift
//  Project
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 hhl. All rights reserved.
//

import Foundation
import Alamofire

// 请求方式
enum CSID_MethodType : String {
    
    case get = "get"
    case post = "post"
}

class CSID_RequestManager {

    // - Parameters:
    //   - type: 请求类型 get/post
    //   - url: 链接
    //  - params: 参数
    //   - success: 成功回调
    //  - failure: 失败回调
    class func request(_ type : CSID_MethodType = .get, url : String, params : [String : Any]?, success : @escaping(_ data : Any) ->(), failure : @escaping (_ error : CSID_Error) ->()){
        
        var commonDict = ["productId":"d0f140e5-1d1f-4171-a8e7-8a854d450a0b","channel":"appstore","osType":"ios","token":"ddmh%402018","udid":"com.CallShow.www","version":"1.0","vestId":"be5d3132-ff21-4add-a95c-50f3104abc4b"]as[String:Any]
        
        for(key,value)in params!{
            commonDict[key]=value
        }
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(url, method: method, parameters: commonDict).responseJSON(completionHandler: { (response) in
            
            if let json = response.result.value {
        
                
                let responDict : NSDictionary = json as! NSDictionary
                
                let codeString : NSInteger = responDict["code"] as! NSInteger
                
                if codeString == 0 {
                    
                    let dataDic = responDict["data"] as! NSDictionary
                    success(dataDic)
                    
                }else{//提示错误信息
                    
                  let msgStirng : NSString = responDict["msg"] as! NSString
                    
                }
            
            }else {
                
                if let httpResponse = response.response {
                    
                    failure(CSID_Error(code: httpResponse.statusCode, message: "不在状态啦..."))
                    
                }else {
                    
                    failure(CSID_Error(code: -1004, message: "网络出现了问题，轻触重试"))
                    
                }
                
            }
        })
    }
    
    
    class func requestHeader(_ type : CSID_MethodType = .get, url : String, params : [String : Any]?,headers:[String:Any], success : @escaping(_ data : Any) ->(), failure : @escaping (_ error : CSID_Error) ->()){
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers:(headers as! HTTPHeaders)).responseJSON(completionHandler: { (response) in
            
            if let json = response.result.value {
               
                    success(json)
            }else {
                
                if let httpResponse = response.response {
                    
                    failure(CSID_Error(code: httpResponse.statusCode, message: "不在状态啦..."))
                    
                }else {
                    
                    failure(CSID_Error(code: -1004, message: "网络出现了问题，轻触重试"))
                    
                }
                
            }
        })
    }
    
}
