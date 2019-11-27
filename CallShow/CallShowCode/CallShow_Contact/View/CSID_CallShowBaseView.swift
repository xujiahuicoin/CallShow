import UIKit

class CSID_CallShowBaseView: UIView {

    func ParentController(viewself:UIView) -> UIViewController {
        var vc:UIResponder = viewself
        while vc.isKind(of: UIViewController.self) != true {
            vc = vc.next!
        }
        return vc as! UIViewController
    }
    
    

}
