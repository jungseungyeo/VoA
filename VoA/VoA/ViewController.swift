//
//  ViewController.swift
//  VoA
//
//  Created by Jung seoung Yeo on 2020/01/11.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let window = UIApplication.shared.windows.first
            window?.overrideUserInterfaceStyle = .light
            window?.rootViewController = self.moveSplash()
            window?.makeKeyAndVisible()
        }
    }
}

private extension ViewController {
    func moveSplash() -> BaseViewController {
        return SplashViewController.instance()
    }
}
