//
//  IntroViewModel.swift
//  VoA
//
//  Created by saenglin on 2019/12/30.
//  Copyright © 2019 linsaeng. All rights reserved.
//

import Combine
import CancelBag
import RxSwift
import RxCocoa

enum IntroViewState {
    case showTitle(Int)
    case complete
}

class IntroViewModel: NSObject, ReactiveViewModelable {
    
    typealias InputType = Input
    typealias OutputType = Output
    
    struct Input {
        public let request = PublishRelay<Void>()
    }
    
    struct Output {
        public let state = PublishRelay<IntroViewState>()
    }
    
    public lazy var input: InputType = Input()
    public lazy var output: OutputType = Output()
    
    private var currentIndex: Int = -1
    
    private let cancelbag = CancelBag()
    private let bag = DisposeBag()
    
    override init() {
        super.init()
        
        input.request
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.currentIndex += 1
                guard self.currentIndex < 4 else {
                    self.output.state.accept(.complete)
                    return
                }
                
                self.output.state.accept(.showTitle(self.currentIndex))
            }).disposed(by: bag)
    }
}
