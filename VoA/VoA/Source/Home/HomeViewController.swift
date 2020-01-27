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
        let btn = UIBarButtonItem(title: "Lamp",
                                  style: .plain, target: self, action: nil)
        btn.tintColor = VoAColor.Home.logoColor
        return btn
    }()
    
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
        
        createRoomBtn.setWidthGradient(colorLeft: Const.leftGradient, colorRight: Const.rightGradient)
        createRoomBtn.layer.cornerRadius = 60 / 2
        createRoomBtn.clipsToBounds = true
        createRoomBtn.setAttributedTitle(Const.createRoomString, for: .normal)
    }
    
    override func bind() {
        super.bind()
    }
}

private extension HomeViewController {
    @objc
    func menuTapped(sender: UIBarButtonItem) {
        sideMenuController?.showLeftViewAnimated()
    }
}
