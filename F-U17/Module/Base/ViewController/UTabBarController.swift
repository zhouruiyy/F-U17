//
//  UTabBarController.swift
//  F-U17
//
//  Created by ZhouRui on 2022/2/12.
//

import UIKit

class UTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        
        //首页
//        let onePageVC =
    }
    
    func addChildViewController(_ childController: UIViewController, title: String?, image: UIImage?, selectedImage: UIImage?) {
        
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: nil, image: image?.withRenderingMode(.alwaysOriginal), selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        if UIDevice.current.userInterfaceIdiom == .phone {
            childController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        addChild(UNavigationController(rootViewController: childController))
    }
}

extension UTabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else { return .lightContent }
        return select.preferredStatusBarStyle
    }
}
