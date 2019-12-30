//
//  BaseViewController.swift
//  VoA
//
//  Created by saenglin on 2019/12/30.
//  Copyright © 2019 linsaeng. All rights reserved.
//

import UIKit

protocol BaseViewControllerable {
    func setup()
    func bind()
    func errorHandling(error: Error?)
}

class BaseViewController: UIViewController, BaseViewControllerable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }

    func setup() { }
    func bind() { }
    func errorHandling(error: Error?) { }
}
