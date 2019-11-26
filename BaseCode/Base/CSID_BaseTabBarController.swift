//
//  BaseTabBarController.swift
//  CustomizeProject
//
//  Created by mac on 2019/10/14.
//  Copyright © 2019 www.CustomizeProject.cn. All rights reserved.
//
import UIKit
import SwifterSwift
class CSID_BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //工具栏背景颜色
        self.tabBar.barTintColor = CSID_LineColor
        //tabbar 字体颜色
        self.tabBar.tintColor = CSID_MainTextColor
        
        self.addChildrenViewController(viewController: CSID_CallShowrecommend(), title: "经选推荐", image: UIImage(named: "mainpage_img10")?.original, selectedImage: UIImage(named: "mainpage_img11")?.original)
        
        self.addChildrenViewController(viewController: CSID_CallShowSiteVC(), title: "来电秀", image: UIImage(named: "qushitu_img0")?.original, selectedImage: UIImage(named: "qushitu_img1")?.original)
        
        self.addChildrenViewController(viewController: CSID_CallShowMe(), title: "我的", image: UIImage(named: "xinwend_img0")?.original, selectedImage: UIImage(named: "xinwend_img1")?.original)

    }

    func addChildrenViewController(viewController : UIViewController, title : String, image : UIImage?, selectedImage : UIImage?) {
        
        viewController.tabBarItem.image = image
        viewController.tabBarItem.selectedImage = selectedImage
        viewController.title = title
        
        let nav = CSID_BaseNavigationController.init(rootViewController: viewController)
        self.addChild(nav)
    }

}
