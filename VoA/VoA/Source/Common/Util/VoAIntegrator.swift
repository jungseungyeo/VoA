//
//  Ingrator.swift
//  VoA
//
//  Created by Jung seoung Yeo on 2020/01/19.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

protocol Integratorable {
    func didFinishLaunch(launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
}

class VoAIntegrator: NSObject {
    
    static let shared = VoAIntegrator()
    
    private var integrators: [Integratorable] = []
    
    private let firegrator: FirebaseIntegrator = FirebaseIntegrator()
    
    private override init() {
        super.init()
        integrators = [firegrator]
    }
    
    func didFinishLaunch(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        for integrator in integrators {
            integrator.didFinishLaunch(launchOptions: launchOptions)
        }
    }
}
