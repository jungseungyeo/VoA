//
//  SplashViewController.swift
//  VoA
//
//  Created by Jung seoung Yeo on 2020/01/11.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import SwiftlyIndicator

class SplashViewController: BaseViewController {
    
    static func instance() -> BaseViewController {
        return SplashViewController()
    }
    
    private lazy var splashView: SplashView = {
        let splashView = SplashView()
        return splashView
    }()
    
    private lazy var indicator: SwiftlyIndicator = {
        let indicator = SwiftlyIndicator(splashView)
        return indicator
    }()
    
    private let viewModel = SplashViewModel()
    private let bag = DisposeBag()
    
    override func setup() {
        super.setup()
        
        view = splashView
    }
    
    override func bind() {
        super.bind()
        
        viewModel.output.viewState
            .subscribe(onNext: { [weak self] (state) in
                guard let self = self else { return }
                switch state {
                case .request:
                    self.indicator.start()
                case .complete:
                    self.indicator.stop()
                    self.moveLogin()
                case .error(let error):
                    self.handleError(error: error)
                }
            }).disposed(by: bag)
    }
    
    override func handleError(error: Error?) {
        super.handleError(error: error)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.input.requestNextMove.accept(())
    }
}

private extension SplashViewController {
    func moveLogin() {
        let window = UIApplication.shared.windows.first
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = LoginViewController.instance()
        window?.makeKeyAndVisible()
    }
}
