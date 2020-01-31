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
    
    func setupTitle(_ text: String, color: UIColor, font: UIFont) {
        title = text
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: color, .font: font]
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
    
    func animationPresent(_ viewControllerToPresent: UIViewController,
                          presentAnimated flag: Bool,
                          modaltype: UIModalPresentationStyle  = .fullScreen,
                          animationType: UIView.AnimationOptions = .transitionCrossDissolve,
                          duration: TimeInterval = 0.3,
                          isPresent: Bool = true,
                          completion: (() -> Void)? = nil) {
        guard let window = UIApplication.shared.windows.first else { return }
        UIView.transition(with: window,
                          duration: duration,
                          options: animationType, animations: { [weak self] in
                            guard let self = self else { return }
                            if isPresent {
                                self.present(viewControllerToPresent, animated: flag, completion: nil, type: modaltype)
                            } else {
                                self.dismiss(animated: false, completion: nil)
                            }
            }, completion: { _ in
                completion?()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = (navigationController?.viewControllers.count ?? 0) == 1 ? false : true
    }
}

extension BaseViewController: UIGestureRecognizerDelegate { }
