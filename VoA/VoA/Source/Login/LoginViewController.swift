//
//  LoginViewController.swift
//  VoA
//
//  Created by Jung seoung Yeo on 2020/01/20.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {
    
    static func instance() -> LoginViewController {
        return LoginViewController()
    }
    
    private lazy var loginView = LoginView(frame: view.bounds)
    
    private let viewModel = LoginViewModel()
    private let bag = DisposeBag()
    
    override func setup() {
        super.setup()
        
        view = loginView
    }
    
    override func bind() {
        super.bind()
        
        loginView.kakaoBtn.rx.tap
            .map { _ in return }
            .bind(to: viewModel.input.kakaoLoginTapped)
        .disposed(by: bag)
        
        viewModel.output.viewState
            .subscribe(onNext: { [weak self] (state) in
                guard let self = self else { return }
                switch state {
                case .requeste:
                    print()
                case .complete:
                    self.moveHome()
                case .error(let error):
                    self.handleError(error: error)
                }
            }).disposed(by: bag)
    }
    
    override func handleError(error: Error?) {
        super.handleError(error: error)
        
        
    }
    
}

private extension LoginViewController {
    func moveHome() {
        let window = UIApplication.shared.windows.first
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = HomeViewController.instance()
        window?.makeKeyAndVisible()    }
}
