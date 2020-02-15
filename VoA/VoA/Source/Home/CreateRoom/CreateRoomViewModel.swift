//
//  CreateRoomViewModel.swift
//  VoA
//
//  Created by saeng lin on 2020/01/31.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import RxSwift
import RxCocoa
import SwiftyJSON

class CreateRoomViewModel: NSObject, ReactiveViewModelable {
    
    typealias InputType = Input
    typealias OutputType = Output
    
    public struct Input {
        public let createRoomTitle = PublishRelay<String?>()
        public let confirmBtnTapped = PublishRelay<String?>()
    }
    
    public struct Output {
        public let roomTitleCountString = PublishRelay<String>()
        public let isValidCreateRoomTitle = BehaviorRelay<Bool>(value: false)
        public let limitRoomTitleAlert = PublishRelay<String>()
        public let moveMemberInvitte = PublishRelay<MemberInviteViewController>()
        
        public let errorMessage = PublishRelay<Error?>()
        public let completeRoom = PublishRelay<Int?>()
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
        
        input.confirmBtnTapped
            .flatMap { (roomTItle) -> Observable<APIResult> in
                HomeNetworker.makeRoom(roomTitle: roomTItle).asObservable()
        }.subscribe(onNext: { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let json):
                let roomID = self.settingRoomID(json: json)
                self.output.completeRoom.accept(roomID)
            case .failure(let error):
                self.output.errorMessage.accept(error)
            }
            
            }).disposed(by: bag)
        
        
//            .subscribe(onNext: { [weak self] (roomTitle) in
//                guard let self = self else { return }
//                guard let roomTitle = roomTitle else { return }
//                let memberViewModel = MemberInviteViewModel(title: roomTitle)
//                let memberInviteViewController = MemberInviteViewController.instance(viewModel: memberViewModel)
//                self.output.moveMemberInvitte.accept(memberInviteViewController)
//            }).disposed(by: bag)
    }
    
}

private extension CreateRoomViewModel {
    func settingUserInfo(json: JSON) -> UserResponseModel? {
        guard let dict = json.dictionaryObject else { return nil }
        let model = UserResponseModel(JSON: dict)
        return model
    }
    
    func settingRoomID(json: JSON) -> Int? {
        guard let dict = json.dictionaryObject else { return nil }
        let responseModel = RoomInfoRespnseModel(JSON: dict)
        return responseModel?.data?.roomID
    }
}
