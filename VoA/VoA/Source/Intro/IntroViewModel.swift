//
//  IntroViewModel.swift
//  VoA
//
//  Created by saenglin on 2019/12/30.
//  Copyright © 2019 linsaeng. All rights reserved.
//

import Combine
import CancelBag

enum IntroViewState {
    case showTitle(Int)
    case complete
}

class IntroViewModel: NSObject, ReactiveViewModelable {
    
    typealias InputType = Input
    typealias OutputType = Output
    
    struct Input {
        public let request = PassthroughSubject<Void, Error>()
    }
    
    struct Output {
        public let viewState = PassthroughSubject<IntroViewState, Error>()
    }
    
    public lazy var input: InputType = Input()
    public lazy var output: OutputType = Output()
    
    private var currentIndex: Int = -1
    
    private let cancelbag = CancelBag()
    
    override init() {
        super.init()
        
        input.request
            .sink(receiveCompletion: { (error) in
            
        }, receiveValue: { [weak self] _ in
            guard let self = self else { return }
            self.currentIndex += 1
            guard self.currentIndex < 4 else {
                self.output.viewState.send(.complete)
                return
            }
            
            self.output.viewState.send(.showTitle(self.currentIndex))
        }).cancel(with: cancelbag)
        
    }
}
