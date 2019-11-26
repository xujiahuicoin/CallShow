//
//  func_Expantion.swift
//  ChangeCoin
//
//  Created by mac on 2019/11/6.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import Foundation

//----------------扩展--------------------

///下划线 背景色
extension UIButton {
 
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
 
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
 
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
 
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
 
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
 
        UIGraphicsEndImageContext()
 
        self.setBackgroundImage(colorImage, for: forState)
 
    }
 
    func underline() {
 
        guard let text = self.titleLabel?.text else { return }
 
        let attributedString = NSMutableAttributedString(string: text)
 
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
 
        self.setAttributedTitle(attributedString, for: .normal)
 
    }
 
}
extension String {
    // base64编码
    func toBase64() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }

    // base64解码
    func fromBase64() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}

extension Double {
    
    ///保留x位小数的
    
    func CSID_roundToDouble(places:Int) -> Double {
        
        let divisor = pow(10.0, Double(places))
        
        return (self * divisor).rounded() / divisor
        
    }
    func CSID_roundToString(places:Int) -> String {
        
        let divisor = pow(10.0, Double(places))
        
        return "\((self * divisor).rounded() / divisor)"
        
    }
    
    ///小数自动取位数
    func CSID_AutoRoundToString() -> String {
        
        var places:Int = 4
        
        if self > 1 {
            places = 3
        }
        
        if self  > 10{
            places = 2
        }
        
        if self  > 100{
            places = 1
        }
 
        let divisor = pow(10.0, Double(places))
        return "\((self * divisor).rounded() / divisor)"
    }
    
}


extension Date {
    
    /// 获取当前 秒级 时间戳 - 10位
    var timeStamp : Int {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return timeStamp
    }
    
    /// 获取当前 毫秒级 时间戳 - 13位
    var milliStamp : Int {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return Int(millisecond)
    }
}


