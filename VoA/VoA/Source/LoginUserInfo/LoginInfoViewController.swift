//
//  LoginInfoViewController.swift
//  VoA
//
//  Created by saeng lin on 2020/01/26.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

import Kingfisher
import RxSwift
import RxCocoa

class LoginInfoViewController: BaseViewController {
    
    static func instance(viewModel: LoginInfoViewModel) -> LoginInfoViewController {
        return LoginInfoViewController(loginViewModel: viewModel)
    }
    
    private let viewModel: LoginInfoViewModel
    private let bag = DisposeBag()
    
    init(loginViewModel: LoginInfoViewModel) {
        viewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(named: "back"),
                                  style: .plain,
                                  target: self,
                                  action: #selector(backTapped(sender:)))
        btn.tintColor = VoAColor.Style.white
        return btn
    }()
    
    private lazy var confirm: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "완료",
                                  style: .done,
                                  target: self,
                                  action: #selector(confirmTapped(sender:)))
        btn.tintColor = VoAColor.LoinInfo.confirmColor
        return btn
    }()
    
    private lazy var loginInfoView: LoginInfoView = {
        let loginInfoView = LoginInfoView(frame: view.bounds)
        return loginInfoView
    }()
    
    override func setup() {
        super.setup()
        
        view = loginInfoView
        
        setupNavigation()
        setupView()
        
    }
    
    private func setupNavigation() {
        navigationItem.leftBarButtonItem = backBtn
        navigationItem.rightBarButtonItem = confirm
    }
    
    private func setupView() {
        loginInfoView.nameTextField.delegate = self
        loginInfoView.nameTextField.text = viewModel.kakaoInfoPresnetModel.nickName
        
        if let profileURL = viewModel.kakaoInfoPresnetModel.profileURL {
            loginInfoView.proImg.kf.setImage(with: profileURL)
        }
    }
    
    override func bind() {
        super.bind()
        
        viewModel.output.nickNameCount
            .subscribe(onNext: { [weak self] (resultString) in
                guard let self = self else { return }
                self.loginInfoView.nicknameCount.text = resultString
            }).disposed(by: bag)
        
        viewModel.output.isValidNickName
            .subscribe(onNext: { [weak self] (flag) in
                guard let self = self else { return }
                self.loginInfoView.clearNickNameBtn.isHidden = flag
                self.loginInfoView.nameTextField.enablesReturnKeyAutomatically = !flag
                self.navigationItem.rightBarButtonItem?.isEnabled = !flag
                self.navigationItem.rightBarButtonItem?.tintColor = !flag ? VoAColor.LoinInfo.confirmColor : VoAColor.LoinInfo.notValidConfirmColor
                
            }).disposed(by: bag)
        
        viewModel.output.limitNickNameAlert
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (nickName) in
                guard let self = self else { return }
                self.loginInfoView.nameTextField.text = nickName
                self.showlimtNickNameAlert()
            }).disposed(by: bag)
        
        loginInfoView.clearNickNameBtn.rx.tap
            .map { _ -> String in
                return ""
        }.subscribe(onNext: { [weak self] (clearStirng) in
            guard let self = self else { return }
            self.viewModel.input.nickNameString.accept(clearStirng)
            self.loginInfoView.nameTextField.text = clearStirng
            }).disposed(by: bag)
        
        viewModel.input.nickNameString.accept(viewModel.kakaoInfoPresnetModel.nickName)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loginInfoView.nameTextField.becomeFirstResponder()
    }
}

private extension LoginInfoViewController {
    @objc
    func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func confirmTapped(sender: UIBarButtonItem) {
        viewModel.input.confirmTapped.accept(())
    }
    
    func showlimtNickNameAlert() {
        UIAlertController.alert("",
                                message: "이름은 10글자를 초과 할 수 없습니다.",
                                defaultString: "확인",
                                defaultHandler: {
                                    
        }).show(self)
    }
}

extension LoginInfoViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.input.nickNameString.accept(textField.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard !viewModel.output.isValidNickName.value else { return false }
        viewModel.input.confirmTapped.accept(())
        return true
    }
}
