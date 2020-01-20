//
//  HomeViewController.swift
//  VoA
//
//  Created by Jung seoung Yeo on 2020/01/20.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    static func instance() -> HomeViewController {
        return HomeViewController()
    }
    
    private lazy var homeView = HomeView(frame: view.bounds)
    
    override func setup() {
        super.setup()
        view = homeView
    }
    
    override func bind() {
        super.bind()
    }
}
