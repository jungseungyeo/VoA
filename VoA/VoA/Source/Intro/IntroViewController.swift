//
//  IntroViewController.swift
//  VoA
//
//  Created by saenglin on 2019/12/30.
//  Copyright © 2019 linsaeng. All rights reserved.
//

import UIKit
import SwiftlyIndicator
import Combine
import CancelBag

class IntroViewController: BaseViewController {
    
    private lazy var introView = IntroView(frame: view.bounds)
    private lazy var indicator: SwiftlyIndicator = {
        let indicator = SwiftlyIndicator(self.introView)
        indicator.updateType(type: .normal)
        return indicator
    }()
    
    private let viewModel = IntroViewModel()
    private let cancelbag = CancelBag()
    
    static func instance() -> IntroViewController {
        return IntroViewController(nibName: nil, bundle: nil)
    }
    
    override func setup() {
        super.setup()
        view = introView
    }
    
    override func bind() {
        super.bind()
        
        viewModel.output.viewState
            .sink(receiveCompletion: { (error) in
                
            }, receiveValue: { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .showTitle(let currentIndex):
                    self.showTitle(to: currentIndex)
                case .complete:
                    self.moveHome()
                }
            }).cancel(with: cancelbag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.input.request.send(())
    }
}

private extension IntroViewController {
    func showTitle(to index: Int) {
        var showTitle: UILabel? = nil
        
        switch index {
        case 0:
            showTitle = introView.title0
        case 1:
            showTitle = introView.title1
        case 2:
            showTitle = introView.title2
        case 3:
            showTitle = introView.title3
        default:
            break
        }
        
        
        UIView.animate(withDuration: 1.5, animations: {
            showTitle?.alpha = 1.0
            }, completion: { [weak self] finish in
                guard let self = self else { return }
                if finish {
                    self.viewModel.input.request.send(())
                }
        })
    }
    
    func moveHome() {
        guard let window = UIApplication.shared.windows.first else { return }
        
        let homeViewController = HomeViewController.instance()
        homeViewController.view.alpha = 0.0
        UIApplication.shared.windows.first?.rootViewController = homeViewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()

        UIView.transition(with: window, duration: 1.5, options: [.transitionCrossDissolve], animations: {
            homeViewController.view.alpha = 1.0
        }, completion: nil)
    }
}
