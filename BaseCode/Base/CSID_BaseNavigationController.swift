//
//  BaseNavigationController.swift
//  CustomizeProject
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 www.CustomizeProject.cn. All rights reserved.
//

import UIKit

class CSID_BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = CSID_LineColor
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
        
    }
    

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "fanhuibai_img1")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backAction))
            
        }
        
        super.pushViewController(viewController, animated: true)
        
    }
    
    //返回按钮点击事件
    @objc func backAction(){
        self.popViewController(animated: true)
    }

}
