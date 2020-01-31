//
//  HomeViewModel.swift
//  VoA
//
//  Created by saeng lin on 2020/01/27.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import RxSwift
import RxCocoa

class HomeViewModel: NSObject, ReactiveViewModelable {
    
    typealias InputType = Input
    typealias OutputType = Output
    
    struct Input {
        public let createRoomBtnTapped = PublishRelay<Void>()
    }
    
    struct Output {
        public let createBtnAction: Observable<Void>
    }
    
    private let bag = DisposeBag()
    
    public lazy var input: InputType = Input()
    public lazy var output: OutputType = {
        
        let obervableCreateBtnAction = input.createRoomBtnTapped
            .map { _ in return }
       
        return Output(createBtnAction: obervableCreateBtnAction)
    }()
}
