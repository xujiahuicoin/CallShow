import UIKit

class CSID_ContactModel: NSObject {
    //是否选中，默认没有选中的
    var selected: Bool = false
    //商品图片名称
    var namestr : String?
    
    //字典转模型  重写构造方法
    init(name:String) {
        super.init()
        namestr = name
    }
    
}
