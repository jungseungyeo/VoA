//
//  LeftMenuViewController.swift
//  VoA
//
//  Created by saeng lin on 2020/01/27.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class LeftMenuViewController: BaseViewController {
    
    lazy var leftMenuView: LeftMenuView = LeftMenuView(frame: view.bounds)
    
    private let viewModel: HomeViewModel
    private let bag = DisposeBag()
    
    static func instance(homeViewModel: HomeViewModel) -> LeftMenuViewController {
        return LeftMenuViewController(homeViewModel: homeViewModel)
    }
    
    private init(homeViewModel: HomeViewModel) {
        viewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        super.setup()
        view = leftMenuView
        
        if let profileString = UserViewModel.shared.userModel?.profileURL, let profileUrl = URL(string: profileString) {
            leftMenuView.profileImg.kf.setImage(with: profileUrl)
        }
        leftMenuView.userName.text = UserViewModel.shared.userModel?.userName
    }
    
    override func bind() {
        super.bind()
        
        leftMenuView.dismissBtn.rx.tap
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                self.sideMenuController?.hideLeftViewAnimated()
            }).disposed(by: bag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("leftMenu viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("leftMenu viewDidAppear")
    }
}
