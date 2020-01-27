//
//  LoginInfoViewModel.swift
//  VoA
//
//  Created by saeng lin on 2020/01/26.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import RxSwift
import RxCocoa

class LoginInfoViewModel: ReactiveViewModelable {
    
    typealias InputType = Input
    typealias OutputType = Output
    
    struct Input {
        public let nickNameString = PublishRelay<String?>()
        public let confirmTapped = PublishRelay<String>()
    }
    
    struct Output {
        public let nickNameCount = PublishRelay<String>()
        public let isValidNickName = BehaviorRelay<Bool>(value: false)
        public let limitNickNameAlert = PublishRelay<String>()
        public let moveHome = PublishRelay<LGSideMenuController>()
    }
    
    public lazy var input: InputType = Input()
    public lazy var output: OutputType = Output()
    
    private let bag = DisposeBag()
    
    public let kakaoInfoPresnetModel: KakaoPresentModel
    
    init(model: KakaoPresentModel) {
        kakaoInfoPresnetModel = model
        
        rxBind()
    }
    
    private func rxBind() {
        
        input.nickNameString
            .map { (nickName) -> Int in
                return (nickName ?? "").count
        }.filter({ (count) -> Bool in
            return count <= 10
        })
        .map { (count) -> String in
            return "\(count) / 10"
        }
        .bind(to: output.nickNameCount)
            .disposed(by: bag)
        
        input.nickNameString
            .map { (nickName) -> Int in
                return (nickName ?? "").count
        }.map { count -> Bool in
            // ture -> valid, false -> not Valid
            return !(count != 0)
        }.bind(to: output.isValidNickName)
            .disposed(by: bag)
        
        input.nickNameString
            .map { (nickName) -> (String, Int) in
                return ((nickName ?? ""), (nickName ?? "").count)
        }.subscribe(onNext: { [weak self] (response) in
            guard let self = self else { return }
            guard response.1 > 10 else { return }
            
            let overNickName = response.0
            
            var sumNickName: [String.Element] = []
            
            for (index, nickNameChar) in overNickName.enumerated() {
                if index < 10 {
                    sumNickName.append(nickNameChar)
                } else {
                    break
                }
            }
            
            let resultNickName = sumNickName.map { String($0) }.joined()
            self.output.limitNickNameAlert.accept(resultNickName)
            }).disposed(by: bag)
        
        input.confirmTapped
            .subscribe(onNext: { [weak self] (nickName) in
                guard let self = self else { return }
                
                let model = KakaoPresentModel(nickName: nickName,
                                              profileURL: self.kakaoInfoPresnetModel.profileURL)
                
                UserViewModel.shared.kakaoPresentModel = model
                
                let viewModel = HomeViewModel()
                let homeNavigationController = HomeNavigationViewController(rootViewController: HomeViewController.instance(homeViewModel: viewModel))
                let navi = LGSideMenuController(rootViewController: homeNavigationController, leftViewController: LeftMenuViewController.init(homeViewModel: viewModel), rightViewController: nil)
                navi.panGesture.isEnabled = false
                navi.leftViewWidth = 280
                self.output.moveHome.accept(navi)
            }).disposed(by: bag)
        
    }
    
    
}
