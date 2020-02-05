//
//  HomeViewController.swift
//  VoA
//
//  Created by Jung seoung Yeo on 2020/01/20.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import SwiftlyIndicator

class HomeNavigationViewController: BaseNaivgationController {
    
}

class HomeViewController: BaseViewController {
    
    static func instance(homeViewModel: HomeViewModel) -> HomeViewController {
        return HomeViewController(homeViewModel: homeViewModel)
    }
    
    private lazy var menuBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(named: "menu"),
                                  style: .plain,
                                  target: self,
                                  action: #selector(menuTapped(sender:)))
        btn.tintColor = VoAColor.Style.white
        return btn
    }()
    
    private lazy var logoBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "다옴",
                                  style: .plain, target: nil, action: nil)
        btn.setTitleTextAttributes([.foregroundColor : VoAColor.Home.logoColor,
                                    .font: UIFont.systemFont(ofSize: 20,
                                                             weight: .bold)],
                                   for: .disabled)
        btn.isEnabled = false
        return btn
    }()
    
    private lazy var alertView: StartArriveAlertViewController = {
        let vc = StartArriveAlertViewController()
        vc.delegate = self
        return vc
    }()
    private lazy var indicator: SwiftlyIndicator = .init(view)
    
    private let viewModel: HomeViewModel
    private let bag = DisposeBag()
    
    init(homeViewModel: HomeViewModel) {
        viewModel = homeViewModel
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private struct Const {
        static let createRoomString: NSAttributedString = .init(string: "귀가방 만들기",
                                                                font: .systemFont(ofSize: 18,
                                                                                  weight: .bold),
                                                                color: VoAColor.Style.white)
        
        static let leftGradient: UIColor = VoAColor.AppleLoginAlert.leftGradient
        static let rightGradient: UIColor = VoAColor.AppleLoginAlert.rightGradient
    }
    
    @IBOutlet weak var createRoomBtn: UIButton!
    
    override func setup() {
        super.setup()

        navigationItem.leftBarButtonItems = [menuBtn, logoBtn]
        setupCreateRoomBtn()
    }
    
    private func setupCreateRoomBtn() {
        createRoomBtn.setWidthGradient(colorLeft: Const.leftGradient, colorRight: Const.rightGradient)
        createRoomBtn.layer.cornerRadius = 60 / 2
        createRoomBtn.clipsToBounds = true
        createRoomBtn.setAttributedTitle(Const.createRoomString, for: .normal)
    }
    
    override func bind() {
        super.bind()
        
        createRoomBtn.rx.tap
            .map { _ in return }
            .bind(to: viewModel.input.createRoomBtnTapped)
        .disposed(by: bag)
        
        viewModel.output.createBtnAction
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                self.navigationController?.pushViewController(CreateRoomViewController.instance(),
                                                              animated: true)
            }).disposed(by: bag)
        
        viewModel.output.networkState
            .subscribe(onNext: { [weak self] (state) in
                guard let self = self else { return }
                switch state {
                case .request:
                    self.indicator.start()
                case .complete:
                    self.indicator.stop()
                case .error(let error):
                    self.handleError(error: error)
                }
                
            }).disposed(by: bag)
        
        viewModel.output.changedView
            .subscribe(onNext: { [weak self] (state) in
                guard let self = self else { return }
                switch state {
                case .noneRoomView:
                    print("noneRoomView")
                case .noneStartRoomView:
                    print("noneStartRoomView")
                case .startingRoomView:
                    print("startingRoomView")
                }
                
            }).disposed(by: bag)
        
        viewModel.input.request.accept(())
    }
    
    override func handleError(error: Error?) {
        super.handleError(error: error)
    }

}

extension HomeViewController: StartArriveAlertViewControllerable {
    func confirm() {
        
    }
    
    func cancel() {
        animationPresent(alertView, presentAnimated: false, isPresent: false)
    }
    
    
}

private extension HomeViewController {
    @objc
    func menuTapped(sender: UIBarButtonItem) {
        sideMenuController?.showLeftViewAnimated()
    }
}
