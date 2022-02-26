//
//  AppDelegate.swift
//  F-U17
//
//  Created by ZhouRui on 2022/2/10.
//

import UIKit
import Alamofire
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var reachability: NetworkReachabilityManager? = {
        return NetworkReachabilityManager(host: "http://app.u17.com")
    }()
    
    var orientation: UIInterfaceOrientationMask = .portrait
    
    func configBase() {
        // 键盘处理
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        // 性别缓存
        let defaults = UserDefaults.standard
        if defaults.value(forKey: String.sexTypeKey) == nil {
            defaults.set(1, forKey: String.sexTypeKey)
            defaults.synchronize()
        }
        
        // 网络监控
        reachability?.listener = { status in
            switch status {
            case .reachable(.wwan):
                print("dd")
            default:break
            }
        }
        reachability?.startListening()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        configBase()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = UTabBarController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientation
    }
}

