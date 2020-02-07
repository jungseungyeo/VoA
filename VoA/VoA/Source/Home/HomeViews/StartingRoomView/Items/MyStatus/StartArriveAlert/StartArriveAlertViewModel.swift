//
//  StartArriveAlertViewModel.swift
//  VoA
//
//  Created by saeng lin on 2020/02/07.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import RxSwift
import RxCocoa

class StartArriveAlertViewModel: NSObject, ReactiveViewModelable {
    
    typealias InputType = Input
    typealias OutputType = Output
    
    public lazy var input: InputType = Input()
    public lazy var output: OutputType = Output()
    
    public private(set) lazy var goHomeTime: Int = 30
    private let offetTime: Int = 5
    
    private let bag = DisposeBag()
    
    struct Input {
        public let updateTimeTapped = PublishRelay<Void>()
        public let donwTimeBtnTapped = PublishRelay<Void>()
    }
    
    struct Output {
        public let showGoHomeTime = PublishRelay<Int>()
    }
    
    override init() {
        super.init()
        
        input.updateTimeTapped
            .flatMap(weak: self) { (wself, _) -> Observable<Int> in
                if wself.goHomeTime < 95 {
                    wself.goHomeTime += wself.offetTime
                }
                return Observable.just((wself.goHomeTime))
        }.filter { (showTime) -> Bool in
            return showTime < 95
        }.bind(to: output.showGoHomeTime)
        .disposed(by: bag)
        
        input.donwTimeBtnTapped
            .flatMap(weak: self) { (wself, _) -> Observable<Int> in
                wself.goHomeTime -= wself.offetTime
                if wself.goHomeTime <= 0 {
                    wself.goHomeTime += wself.offetTime
                }
                return Observable.just(wself.goHomeTime)
        }.bind(to: output.showGoHomeTime)
        .disposed(by: bag)
    }
}
