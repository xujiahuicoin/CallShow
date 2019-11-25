///
///  ConstHeader.swift
///  CustomizeProject
///
///  Created by mac on 2019/10/14.
///  Copyright © 2019 www.CustomizeProject.cn. All rights reserved.
///
import UIKit
import Foundation
import SnapKit
import ESPullToRefresh
import Kingfisher
import SCLAlertView

///是否测试
let appTesting = true

let basePrice = "USD"
let CSID_PullDown = "CSID_PullDown"
let CSID_PullUp = "CSID_PullUp"
let CSID_Reload_Data = "CSID_Reload_Data"
let CSID_down_jian = "▼"
/// 屏幕的宽
let CSID_WidthScreen = UIScreen.main.bounds.size.width
/// 屏幕的高
let CSID_heightScreen = UIScreen.main.bounds.size.height

///比例尺适配
func iPhoneWidth(w:CGFloat)->CGFloat {
    return UIScreen.main.bounds.size.width * (w/750.0)
}
func iPhoneHeight(h:CGFloat)->CGFloat {
    return UIScreen.main.bounds.size.height * (h/1334.0)
}

let CSID_IsiPhoneX = __CGSizeEqualToSize(CGSize.init(width: 1125/3, height: 2436/3), UIScreen.main.bounds.size)

let CSID_IsiPhoneXr = __CGSizeEqualToSize(CGSize.init(width: 828/2, height: 1792/2), UIScreen.main.bounds.size)

let CSID_IsiPhoneXs = __CGSizeEqualToSize(CGSize.init(width: 1125/3, height: 2436/3), UIScreen.main.bounds.size)

let CSID_IsiPhoneXs_Max = __CGSizeEqualToSize(CGSize.init(width: 1242/3, height: 2688/3), UIScreen.main.bounds.size)

let isIphoneX = (CSID_IsiPhoneX || CSID_IsiPhoneXr || CSID_IsiPhoneXs||CSID_IsiPhoneXs_Max)

/// 导航栏高度
let CSID_HeightNav : CGFloat = 44
///x安全底部距离
let CSID_TabMustAddSafe : CGFloat = (isIphoneX ? 34:0)
/**
 状态栏高度
 */
let CSID_Status_H : CGFloat = (isIphoneX ? 44:20)
/**
 顶部状态栏+导航高度
 */
let CSID_HeightNav_top : CGFloat = (isIphoneX ? 88:64)
/**
 底部安全区域的高度
 */
let CSID_HeightTabBom : CGFloat = (isIphoneX ? 83:49)


/// 十六进制设置颜色
func ABCHexColor(_ rgbValue:Int) -> UIColor {
    
    return UIColor.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: 1.0)
}

///不透明
func RGB (_ r:CGFloat,g:CGFloat,b:CGFloat)-> UIColor{
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}
///自定义透明
func RGBA (_ r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat)-> UIColor{
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
///随机色
var ABCRandomColor: UIColor {
    get {
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

/// 主色
let CSID_MainColor : UIColor          = RGB(255,g: 255, b: 255)
/// 背景色
let CSID_BackgroundColor_dark :UIColor = RGB(255,g: 255, b: 255)
/// 分割线颜色
let CSID_LineColor : UIColor          = RGB(244,g: 245, b: 245)
/// 一级字体颜色
let CSID_MainTextColor : UIColor = RGB(18,g: 19, b: 19)
/// 次级字体颜色
let CSID_SecondTextColor : UIColor    = RGB(123,g: 124, b: 125)

/// 按钮颜色 浅蓝色
let CSID_ButtonColor_Blue: UIColor    = RGB(37,g: 94, b: 234)
///一级字体大小 Text font --14
let CSID_FontNum_Main : CGFloat = 16
///二级字体大小Second Text font --13
let CSID_FontNum_Second : CGFloat = 14
///三级字体大小Small Text font --13
let CSID_FontNum_Small : CGFloat = 13

///加粗字体
func FontBold(font: CGFloat) -> (UIFont) {
    
    return UIFont.boldSystemFont(ofSize: font)
    
}

///正常
func Font(font: CGFloat) -> (UIFont) {
    
    return UIFont.systemFont(ofSize: font)
    
}

///自定义字体
func NameFont(nameT:String ,font:CGFloat)-> (UIFont){
    return UIFont(name:nameT , size:font)!
}
///字体名称
let light = "PingFangSC-Light"///苹方细体
let regular = "PingFangSC-Regular"///苹方体

///label高度自适应
func getLabelHegit(str: String, font: UIFont, width: CGFloat)-> CGFloat {
    
    let statusLabelText: String = str as String
    
    let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
    
    let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
    
    let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : AnyObject], context: nil).size
    
    return strSize.height
}

///切圆角
func AddRadius (_ RView:UIView,rabF:CGFloat){
    RView.layer.cornerRadius = rabF
    RView.layer.masksToBounds = true
}

///边框
func AddBorder(bordV:UIView , bordColor:UIColor ,bordWidth:CGFloat) -> Void {
    bordV.layer.borderColor = bordColor.cgColor
    bordV.layer.borderWidth = bordWidth
}

///阴影
func AddShadow(shadowView:UIView, shadowColor:UIColor, shadowOpacity:CGFloat, shadowRadius:CGFloat, shadowOffset:CGSize){
    shadowView.layer.shadowColor = shadowColor.cgColor
    shadowView.layer.shadowOffset = shadowOffset
    shadowView.layer.shadowRadius = shadowRadius
    shadowView.layer.shadowOpacity = Float(shadowOpacity)
}

///获取本地图片
func getImage(imageName:String) -> UIImage? {
    return UIImage.init(named: imageName)
}

func timeStampToString(timeStamp:String)->String {
    
    let string = NSString(string: timeStamp)
    
    let timeSta:TimeInterval = string.doubleValue
    let dfmatter = DateFormatter()
    dfmatter.dateFormat="MM-dd HH:mm"
    
    let date = NSDate(timeIntervalSince1970: timeSta)
    
    print(dfmatter.string(from: date as Date))
    return dfmatter.string(from: date as Date)
}
///------------登录判断------------------------
func CSID_loginISOk(){
    UserDefaults.standard.set(true, forKey: "login")
    ///登录成功
     NotificationCenter.default.post(name: NSNotification.Name("loginIn"), object: nil)
}

func CSID_loginISNil(){
    UserDefaults.standard.set(false, forKey: "login")
    ///退出成功
    NotificationCenter.default.post(name: NSNotification.Name("loginOut"), object: nil)
}

func CSID_isLoginIs() -> Bool {
    
    let loginBool:Bool = UserDefaults.standard.bool(forKey: "login")
    
    return loginBool
}




///控件边线设置
func setBorderWithView(bordView:UIView , top:Bool , left:Bool , bottom:Bool , right:Bool , bordColor:UIColor , bordWidth:CGFloat) -> Void {
    if top {
        let topLayer = CALayer.init()
        topLayer.frame = CGRect(x: 0, y: 0, width: bordView.frame.size.width, height: bordWidth)
        topLayer.backgroundColor = bordColor.cgColor;
        bordView.layer.addSublayer(topLayer)
    }
    
    if left {
        let leftLayer = CALayer.init()
        leftLayer.frame = CGRect(x: 0, y: 0, width: bordWidth, height: bordView.frame.size.height)
        leftLayer.backgroundColor = bordColor.cgColor;
        bordView.layer.addSublayer(leftLayer)
    }
    
    if  bottom{
        let bottomLayer = CALayer.init()
        bottomLayer.frame = CGRect(x: 0, y: bordView.frame.size.height - bordWidth, width: bordView.frame.size.width, height: bordWidth)
        bottomLayer.backgroundColor = bordColor.cgColor;
        bordView.layer.addSublayer(bottomLayer)
    }
    
    if right {
        let rightLayer = CALayer.init()
        rightLayer.frame = CGRect(x: bordView.frame.size.width - bordWidth, y: 0, width: bordWidth, height: bordView.frame.size.height)
        rightLayer.backgroundColor = bordColor.cgColor;
        bordView.layer.addSublayer(rightLayer)
    }
    
    
   
}
