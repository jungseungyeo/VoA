//
//  SceneDelegate.swift
//  VoA
//
//  Created by saenglin on 2019/12/29.
//  Copyright © 2019 linsaeng. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let seceneWindow = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: seceneWindow)
        window?.rootViewController = IntroViewController.instance()
        window?.backgroundColor = VoAColor.Style.background
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

