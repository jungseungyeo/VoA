//
//  HomeViewController.swift
//  VoA
//
//  Created by saenglin on 2019/12/30.
//  Copyright © 2019 linsaeng. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    lazy var homeView = HomeView(frame: view.bounds)
    
    static func instance() -> HomeViewController {
        return HomeViewController(nibName: nil, bundle: nil)
    }
    
    override func setup() {
        super.setup()
        
        view = homeView
    }
    
    override func bind() {
        super.bind()
    }
}
