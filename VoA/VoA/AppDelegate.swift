//
//  AppDelegate.swift
//  VoA
//
//  Created by Jung seoung Yeo on 2020/01/11.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

import KakaoOpenSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        guard #available(iOS 13, *) else {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.backgroundColor = VoAColor.Style.background
            window?.rootViewController = ViewController()
            window?.makeKeyAndVisible()
            return true
        }
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      if KOSession.isKakaoAccountLoginCallback(url.absoluteURL) {
        return KOSession.handleOpen(url)
      }
      
      return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
      if KOSession.isKakaoAccountLoginCallback(url.absoluteURL) {
        return KOSession.handleOpen(url)
      }
      return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

