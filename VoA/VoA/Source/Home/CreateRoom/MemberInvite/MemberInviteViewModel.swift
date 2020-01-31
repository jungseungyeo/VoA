//
//  MemberInviteViewModel.swift
//  VoA
//
//  Created by saeng lin on 2020/01/31.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class MemberInviteViewModel: NSObject, ReactiveViewModelable {
    
    typealias InputType = Input
    typealias OutputType = Output
    
    struct Input {
        public let kakaoInviteBntTapped = PublishRelay<Void>()
    }
    
    struct Output {
        
    }
    
    public lazy var input: InputType = Input()
    public lazy var output: OutputType = Output()
    
    private let roomTitle: String
    
    private let bag = DisposeBag()
    
    init(title: String) {
        roomTitle = title
        super.init()
        
        rxBind()
    }
    
    private func rxBind() {
     
        input.kakaoInviteBntTapped
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                print("kakaoInvite")
            }).disposed(by: bag)
    }
}
