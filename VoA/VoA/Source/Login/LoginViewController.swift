//
//  LoginViewController.swift
//  VoA
//
//  Created by Jung seoung Yeo on 2020/01/20.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import AuthenticationServices
import UIKit

import RxSwift
import RxCocoa

class LoginNavigationController: BaseNaivgationController {
    
    static func instance(controller: LoginViewController) -> LoginNavigationController {
        return LoginNavigationController(rootViewController: controller)
    }
}

class LoginViewController: BaseViewController {
    
    static func instance() -> LoginViewController {
        return LoginViewController(nibName: nil, bundle: nil)
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
        
        loginView.appleBtn.addTarget(self, action: #selector(appleLoginTapped), for: .touchUpInside)
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func handleError(error: Error?) {
        super.handleError(error: error)
        
        
    }
    
}

private extension LoginViewController {
    func moveHome() {
        guard let kakaoInfo = viewModel.kakaoPresentModel else {
            return
        }
        navigationController?.pushViewController(LoginInfoViewController.instance(viewModel: LoginInfoViewModel(model: kakaoInfo)), animated: true)
    }
    
    @objc
    private func appleLoginTapped() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
        
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let user = credential.user
            let email = credential.email
            let fullName = credential.fullName
            
            print("user : \(user)")
            print("email : \(email ?? "")")
            print("fullname: \(fullName)")
            
        } else {
            handleError(error: VoAError.unknown)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        handleError(error: error)
    }
}
