//
import UIKit
import WebKit
class CSID_WkWebViC: CSID_BaseViewController,WKUIDelegate,WKNavigationDelegate {

    ///标题
    var CSID_Str_title : String!
    ///类型：1 直接加载url，2加载body
    var CSID_Int_type : Int!
    ///1、请求URL 2\、本地Html。  3、 StringBody
    var CSID_Str_UrlOrBody : String!
    
    ///加载时候 覆盖的图层
    var CSID_View_topview : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = CSID_BackgroundColor_dark
        return view
    }()
    
    
    
    lazy var CSID_Wk_webV : WKWebView = {
        let config = WKWebViewConfiguration()
        config.selectionGranularity = .character
        let webview = WKWebView(frame: self.view.frame, configuration: config)
        webview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webview.backgroundColor = CSID_BackgroundColor_dark
        webview.navigationDelegate = self
        webview.scrollView.backgroundColor = CSID_BackgroundColor_dark
        return webview
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //隐藏 bannar 广告
        self.bannerShow = false
        
        self.title = CSID_Str_title
        self.view.addSubview(CSID_Wk_webV)
        CSID_Wk_webV.snp.makeConstraints { (ma) in
            ma.edges.equalTo(0)
        }
        self.view.addSubview(CSID_View_topview)
        CSID_View_topview.snp.makeConstraints { (ma) in
            ma.edges.equalTo(0)
        }
        
        CSID_HUDShow()
        
        loadWebViewData()
    }
    
    ///加载数据
    func loadWebViewData(){
        
       
        
        if CSID_Int_type == 1{
            self.CSID_Wk_webV.load(URLRequest(url: URL(string: CSID_Str_UrlOrBody)!))
            
        }else if CSID_Int_type == 2{
            //加载本地Html
            let fileURL = NSURL.init(fileURLWithPath: Bundle.main.path(forResource: CSID_Str_UrlOrBody, ofType: "html")!)
            self.CSID_Wk_webV.load(URLRequest(url: fileURL as URL))
            
        }else if CSID_Int_type == 3{
            self.CSID_Wk_webV.loadHTMLString(CSID_Str_UrlOrBody, baseURL: nil)
        }
        
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        //判断当前模式来设置字体、背景颜色
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                
                self.changeTextBackgroundStyle(style: "dark")
            }else{
                changeTextBackgroundStyle(style: "light")
            }
        } else {
            // Fallback on earlier versions
        }
        
        self.perform(#selector(hideTopView), with: nil, afterDelay: 0.5)
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hideTopView()
        CSID_Wk_webV.scrollView.set(loadType: .noData)
    }
    
    ///隐藏上层的 view
    @objc func hideTopView(){
        
        UIView.animate(withDuration: 1) {
            self.CSID_View_topview.alpha = 0
        }
       CSID_hideHUD()
        
    }
    
    //监听 暗黑模式变化
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        super.traitCollectionDidChange(previousTraitCollection)
        
        //判断两个UITraitCollection 对象是否不同
        if #available(iOS 13.0, *) {
            
            if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection){
                
                //判断模式
                if traitCollection.userInterfaceStyle == .dark {
                    
                    changeTextBackgroundStyle()
                    
                }else {
                    changeTextBackgroundStyle(style: "light")
                }
                
            }
            
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    // 设置字体背景 暗黑 白色
    func changeTextBackgroundStyle(style : String = "dark"){
        
        if style == "dark" {
            
            //字体颜色
            self.CSID_Wk_webV.evaluateJavaScript("document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#F8F8FF'", completionHandler: nil)
            //背景颜色
            self.CSID_Wk_webV.evaluateJavaScript("document.body.style.backgroundColor=\"#1E1E1E\"", completionHandler: nil)
            
        }else{
            self.CSID_Wk_webV.evaluateJavaScript("document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#000000'", completionHandler: nil)
            self.CSID_Wk_webV.evaluateJavaScript("document.body.style.backgroundColor=\"#FFFFFF\"", completionHandler: nil)
        }
    }
    
    
    
}
