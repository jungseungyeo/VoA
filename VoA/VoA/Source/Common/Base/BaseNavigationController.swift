//
//  BaseNavigationController.swift
//  VoA
//
//  Created by saeng lin on 2020/01/26.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

class BaseNaivgationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().barTintColor = .clear
        //        UINavigationBar.appearance().tintColor = UIColor.white
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: VoAColor.Style.background]
    }
}
