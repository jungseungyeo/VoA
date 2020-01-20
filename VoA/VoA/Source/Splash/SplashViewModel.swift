//
//  SplashViewModel.swift
//  VoA
//
//  Created by Jung seoung Yeo on 2020/01/13.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import RxSwift
import RxCocoa

import KakaoOpenSDK

enum SplashViewState {
    case request
    case complete
    case error(Error?)
}

class SplashViewModel: NSObject, ReactiveViewModelable {
    typealias InputType = Input
    typealias OutputType = Output
    
    struct Input {
        public let requestNextMove = PublishRelay<Void>()
    }
    
    struct Output {
        public let viewState = PublishRelay<SplashViewState>()
    }
    
    public lazy var input: InputType = Input()
    public lazy var output: OutputType = Output()
    
    private let bag = DisposeBag()
    
    override init() {
        super.init()
        
        rxBind()
    }
    
    private func rxBind() {

        input.requestNextMove
            .map { _ -> SplashViewState in
                return .request
        }.bind(to: output.viewState)
        .disposed(by: bag)
        
        
        input.requestNextMove
            .delay(1.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                self.output.viewState.accept(.complete)
            }).disposed(by: bag)
        
    }

}
