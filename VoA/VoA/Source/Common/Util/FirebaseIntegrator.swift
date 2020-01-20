//
//  FirebaseIntegrator.swift
//  VoA
//
//  Created by Jung seoung Yeo on 2020/01/19.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import Firebase

class FirebaseIntegrator: NSObject, Integratorable {
    
    func didFinishLaunch(launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        FirebaseApp.configure()
    }
}
