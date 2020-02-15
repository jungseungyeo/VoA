//
//  CreateRoomViewController.swift
//  VoA
//
//  Created by saeng lin on 2020/01/30.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

protocol CreateRoomViewControllerdelegate: class {
    func complete(roomID: Int?)
}

class CreateRoomViewController: BaseViewController {
    
    private lazy var createRoomView: CreateRoomView = {
        let createRoomView = CreateRoomView(frame: view.bounds)
        return createRoomView
    }()
    
    static func instance() -> CreateRoomViewController {
        return CreateRoomViewController(nibName: nil, bundle: nil)
    }
    
    private let viewModel = CreateRoomViewModel()
    private let bag = DisposeBag()
    
    private lazy var backBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(named: "back"),
                                  style: .plain,
                                  target: self,
                                  action: #selector(backTapped(sender:)))
        btn.tintColor = VoAColor.Style.white
        return btn
    }()
    
    private lazy var nextBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "완료",
                                  style: .done,
                                  target: self,
                                  action: #selector(nextTapped(sender:)))
        btn.tintColor = VoAColor.LoinInfo.confirmColor
        btn.setTitleTextAttributes([.foregroundColor : VoAColor.CreateRoom.validNextBtnColor], for: .normal)
        btn.isEnabled = false
        return btn
    }()
    
    private struct Const {
        static let navigationTitleString: String = "귀가방 이름"
        static let navigationTitleFont: UIFont = .systemFont(ofSize: 16, weight: .bold)
    }
    
    weak var delegate: CreateRoomViewControllerdelegate?
    
    override func setup() {
        super.setup()
        
        view = createRoomView
        
        createRoomView.roomTitleTextField.delegate = self
        setupNavigation()
    }
    
    private func setupNavigation() {
        navigationItem.leftBarButtonItem = backBtn
        navigationItem.rightBarButtonItem = nextBtn
        
        setupTitle(Const.navigationTitleString,
                   color: VoAColor.Style.white,
                   font: Const.navigationTitleFont)
    }
    
    override func bind() {
        super.bind()
        
        viewModel.output.isValidCreateRoomTitle
            .skip(1)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (flag) in
                guard let self = self else { return }
                self.createRoomView.clearRoomTitleBtn.isHidden = flag
                self.navigationItem.rightBarButtonItem?.isEnabled = !flag
                self.navigationItem.rightBarButtonItem?.tintColor = !flag ? VoAColor.LoinInfo.confirmColor : VoAColor.LoinInfo.notValidConfirmColor
            }).disposed(by: bag)
        
        viewModel.output.roomTitleCountString
            .subscribe(onNext: { [weak self] (countString) in
                guard let self = self else { return }
                self.createRoomView.countRoomTitle.text = countString
            }).disposed(by: bag)
        
        viewModel.output.limitRoomTitleAlert
            .subscribe(onNext: { [weak self] (limitString) in
                guard let self = self else { return }
                self.createRoomView.roomTitleTextField.text = limitString
                self.showLimitRoomtCountAlert()
            }).disposed(by: bag)
        
        createRoomView.clearRoomTitleBtn.rx.tap
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                self.createRoomView.roomTitleTextField.text = ""
                self.viewModel.input.createRoomTitle.accept("")
            }).disposed(by: bag)
        
        viewModel.output.moveMemberInvitte
            .subscribe(onNext: { [weak self] (vc) in
                guard let self = self else { return }
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: bag)
        
        viewModel.output.completeRoom
            .subscribe(onNext: { [weak self] (roomID) in
                guard let self = self else { return }
                self.navigationController?.popViewController(animated: true)
                self.delegate?.complete(roomID: roomID)
            }).disposed(by: bag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        createRoomView.roomTitleTextField.becomeFirstResponder()
    }
    
}

private extension CreateRoomViewController {
    func showLimitRoomtCountAlert() {
        UIAlertController.alert("",
                                message: "방 제목은 20글자를 넘을 수 없습니다.",
                                cancelString: "확인",
                                cancelHandler: {
                                    
        }).show(self)
    }
}

private extension CreateRoomViewController {
    @objc
    func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func nextTapped(sender: UIBarButtonItem) {
        viewModel.input.confirmBtnTapped.accept(createRoomView.roomTitleTextField.text)
    }
}

extension CreateRoomViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.input.createRoomTitle.accept(textField.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard !viewModel.output.isValidCreateRoomTitle.value else { return false }
        viewModel.input.confirmBtnTapped.accept(createRoomView.roomTitleTextField.text)
        return false
    }
}
