//
//  BaseViewController.swift
//  VoA
//
//  Created by Jung seoung Yeo on 2020/01/13.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

protocol BaseViewControllerable {
    func setup()
    func bind()
    func handleError(error: Error?)
}

class BaseViewController: UIViewController, BaseViewControllerable {
    
    lazy var refreshControl: UIRefreshControl = {
        var control = UIRefreshControl()
        control.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControl.Event.valueChanged)
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setup() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    func bind() { }
    func handleError(error: Error?) { }
    
    @objc
    func handleRefresh(_ sender: UIRefreshControl) { }
    
    open func present(_ viewControllerToPresent: UIViewController,
                               animated flag: Bool,
                               completion: (() -> Void)? = nil, type: UIModalPresentationStyle  = .fullScreen) {
        viewControllerToPresent.modalPresentationStyle = type
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}

extension BaseViewController: UIGestureRecognizerDelegate { }
