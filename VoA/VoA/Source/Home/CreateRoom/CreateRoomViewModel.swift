//
//  CreateRoomViewModel.swift
//  VoA
//
//  Created by saeng lin on 2020/01/31.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import RxSwift
import RxCocoa

class CreateRoomViewModel: NSObject, ReactiveViewModelable {
    
    typealias InputType = Input
    typealias OutputType = Output
    
    public struct Input {
        public let createRoomTitle = PublishRelay<String?>()
        public let confirmBtnTapped = PublishRelay<Void>()
    }
    
    public struct Output {
        public let roomTitleCountString = PublishRelay<String>()
        public let isValidCreateRoomTitle = BehaviorRelay<Bool>(value: false)
        public let limitRoomTitleAlert = PublishRelay<String>()
    }
    
    public lazy var input: InputType = Input()
    public lazy var output: OutputType = Output()
    
    private let bag = DisposeBag()
    
    override init() {
        super.init()
        
        rxBind()
    }
    
    private func rxBind() {
        
        input.createRoomTitle
            .map { roomTitle -> Int in
                return (roomTitle ?? "").count
        }.filter { count -> Bool in
            return count <= 20
        }.map { count -> String in
            return "\(count) / 20"
        }.bind(to: output.roomTitleCountString)
            .disposed(by: bag)
        
        input.createRoomTitle
            .map { (roomTitle) -> Int in
                return (roomTitle ?? "").count
        }.map { count -> Bool in
            // ture -> valid, false -> not Valid
            return !(count != 0)
        }.bind(to: output.isValidCreateRoomTitle)
            .disposed(by: bag)
        
        input.createRoomTitle
            .map { (roomTitle) -> (String, Int) in
                return ((roomTitle ?? ""), (roomTitle ?? "").count)
        }.subscribe(onNext: { [weak self] (response) in
            guard let self = self else { return }
            guard response.1 > 20 else { return }
            
            let overNickName = response.0
            
            var sumRoomTitle: [String.Element] = []
            
            for (index, nickNameChar) in overNickName.enumerated() {
                if index < 20 {
                    sumRoomTitle.append(nickNameChar)
                } else {
                    break
                }
            }
            
            let resultRoomTitle = sumRoomTitle.map { String($0) }.joined()
            self.output.limitRoomTitleAlert.accept(resultRoomTitle)
        }).disposed(by: bag)
    }
    
}
