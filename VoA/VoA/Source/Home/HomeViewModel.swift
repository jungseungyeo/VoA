//
//  HomeViewModel.swift
//  VoA
//
//  Created by saeng lin on 2020/01/27.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import RxSwift
import RxCocoa

import SwiftyJSON

enum HomeViewSatus: Int {
    case noneRoomView = 0 // 내가 속한 방이 없고 방을 만들어야하는 View
    case noneStartRoomView = 1 // 내가 속한 귀가방이 귀가 시작한 View
    case startingRoomView = 2 // 내가 속한 귀가방이 아직 귀가를 시작하지 않은 View
}

enum StartingRoomViewSection: Int {
    case myStatus = 0
    case memberStatus = 1
    case endMemberStatus = 2
}

enum HomeNetworkState {
    case request
    case complete
    case error(Error?)
}

class HomeViewModel: NSObject, ReactiveViewModelable {
    
    typealias InputType = Input
    typealias OutputType = Output
    
    struct Input {
        public let createRoomBtnTapped = PublishRelay<Void>()
        public let request = PublishRelay<Void>()
        public let requestRoomInfo = PublishRelay<Int?>()
    }
    
    struct Output {
        public let createBtnAction: Observable<Void>
        public let networkState = PublishRelay<HomeNetworkState>()
        
        public let changedView = BehaviorRelay<HomeViewSatus>(value: .noneStartRoomView)
    }
    
    private let bag = DisposeBag()
    
    public private(set) var viewState: HomeViewSatus = .noneRoomView
    
    // left Menu
    public private(set) var roomDataModels: [RoomIDModel]?
    public private(set) var listRoomDataModels: [RoomIDModel]?
    
    // starting Home
    public private(set) lazy var roomInfoModel: RoomInfoModel? = nil
    public private(set) lazy var myInfo: Participant? = nil
    public private(set) lazy var normalParticipants: [Participant]? = nil
    public private(set) lazy var endParticipants: [Participant]? = nil
    
    public private(set) lazy var sectionCount: Int = {
        guard let participants = self.roomInfoModel?.participants else {
            return 2
        }
        let count = participants
            .filter({ (model) -> Bool in
                guard let myUserID = UserViewModel.shared.userModel?.userID else { return false }
                return (model.userID ?? 0) != myUserID
            })
            .filter { (model) -> Bool in
                
            return model.userStatus == .end
        }.count
        return count >= 1 ? 3 : 2
    }()
    
    public private(set) var currentRoomID: Int?
    
    public lazy var input: InputType = Input()
    public lazy var output: OutputType = {
        
        let obervableCreateBtnAction = input.createRoomBtnTapped
            .map { _ in return }
        
        return Output(createBtnAction: obervableCreateBtnAction)
    }()
    
    override init() {
        super.init()
        
        input.requestRoomInfo
            .map { otionalRoomID -> Int in
                return otionalRoomID ?? 0
        }.filter { (roomID) -> Bool in
            return roomID != 0
        }.flatMap { (roomID) -> Observable<JSON> in
            return HomeNetworker.getRommInfo(roomID: roomID).asObservable()
        }.subscribe(onNext: { [weak self] (json) in
            guard let self = self else { return }
            let model = self.settingRoomInfo(json: json)
            self.roomInfoModel = model
            self.sortRoomInfo()
            self.myInfo = self.getMyInfo()
            
            if (self.roomInfoModel?.participants?.count ?? 1) <= 1 {
                // 귀가 방을 시작 할 수 없는 상태
                self.output.networkState.accept(.complete)
                self.output.changedView.accept(.noneStartRoomView)
            } else {
                // 귀가 방을 시작하는 상태
                self.output.networkState.accept(.complete)
                self.output.changedView.accept(.startingRoomView)
            }
            }, onError: { [weak self] (error) in
                guard let self = self else { return }
                //            self.output.networkState.accept(.error(error))
                let model = self.demoRoomInfo()
                self.roomInfoModel = model
                self.sortRoomInfo()
                self.myInfo = self.getMyInfo()
                
                if (self.roomInfoModel?.participants?.count ?? 1) <= 1 {
                    // 귀가 방을 시작 할 수 없는 상태
                    self.output.networkState.accept(.complete)
                    self.output.changedView.accept(.noneStartRoomView)
                } else {
                    // 귀가 방을 시작하는 상태
                    self.output.networkState.accept(.complete)
                    self.output.changedView.accept(.startingRoomView)
                }
        }).disposed(by: bag)
        
        input.request
            .map { _ -> HomeNetworkState in
                return .request
        }.bind(to: output.networkState)
            .disposed(by: bag)
        
        input.request
            .flatMap {
                return HomeNetworker.getRoomID(userID: UserViewModel.shared.userModel?.userID)
        }.subscribe(onNext: { [weak self] (json) in
            guard let self = self else { return }
            let roomDataModels = self.settingRoomIDs(json: json)
            self.roomDataModels = roomDataModels
            self.sortRoomIDs()
            self.settingReuqestRoomtID()
            
            guard (roomDataModels?.count ?? 0) != 0 else {
                // 귀가방 없는 상태
                self.viewState = .noneRoomView
                self.output.networkState.accept(.complete)
                return
            }
            
            self.input.requestRoomInfo.accept(self.currentRoomID)
            }, onError: { [weak self] (error) in
                guard let self = self else { return }
                //            self.output.networkState.accept(.error(error))
                
                let roomDataModels = self.demoRoomIDs()
                self.roomDataModels = roomDataModels
                self.sortRoomIDs()
                self.settingReuqestRoomtID()
                
                guard (roomDataModels?.count ?? 0) != 0 else {
                    // 귀가방 없는 상태
                    
                    self.output.networkState.accept(.complete)
                    self.output.changedView.accept(.noneRoomView)
                    return
                }
                
                self.input.requestRoomInfo.accept(self.currentRoomID)
        }).disposed(by: bag)
        
    }
}

private extension HomeViewModel {
    func settingRoomIDs(json: JSON) -> [RoomIDModel]? {
        guard let dict = json.dictionaryObject else { return nil }
        let responseModel = RoomIDsResponseModel(JSON: dict)
        return responseModel?.data?.roomDatas
    }
    
    func settingRoomInfo(json: JSON) -> RoomInfoModel? {
        guard let dict = json.dictionaryObject else { return nil }
        let responseModel = RoomInfoRespnseModel(JSON: dict)
        return responseModel?.data
    }
    
    func sortRoomIDs() {
        guard let roomDatas = self.roomDataModels else { return }
        roomDataModels = roomDatas.sorted { (first, second) -> Bool in
            return (first.roomID ?? 0) > (second.roomID ?? 1)
        }
    }
    
    func sortRoomInfo() {
        guard let roomInfoModel = self.roomInfoModel else { return }
        let endParticipants = roomInfoModel.participants?.filter({ (model) -> Bool in
            return model.userStatus == .end
        })
        let normalParticipants = roomInfoModel.participants?.filter({ (model) -> Bool in
            return model.userStatus != .end
        }).filter({ (model) -> Bool in
            guard let myUserID = UserViewModel.shared.userModel?.userID else { return false }
            return (model.userID ?? 0) != myUserID
        })
        self.normalParticipants = normalParticipants
        self.endParticipants = endParticipants
        
    }
    
    func settingReuqestRoomtID() {
        guard let roomID = roomDataModels?.last?.roomID else { return }
        currentRoomID = roomID
        listRoomDataModels = roomDataModels?.filter({ (roomData) -> Bool in
            return (roomData.roomID ?? 0) != roomID
        })
    }
    
    func demoRoomIDs() -> [RoomIDModel]? {
        guard let dict = VoAUtil.loadJSON("RoomDatas") as? [String: Any] else { return nil }
        let responseModel = RoomIDsResponseModel(JSON: dict)
        return responseModel?.data?.roomDatas
    }
    
    func demoRoomInfo() -> RoomInfoModel? {
        guard let dict = VoAUtil.loadJSON("RoomInfoData") as? [String: Any] else { return nil }
        let responseModel = RoomInfoRespnseModel(JSON: dict)
        return responseModel?.data
    }
}

// Starting My Header
extension HomeViewModel {
    func getMyInfo() -> Participant? {
        guard let myUserID = UserViewModel.shared.userModel?.userID else { return nil }
        guard let myInfoModel = self.roomInfoModel?.participants else { return nil }
        let myInfo = myInfoModel.filter { (model) -> Bool in
            return (model.userID ?? 0) == myUserID
        }.first
        
        return myInfo
    }
}
