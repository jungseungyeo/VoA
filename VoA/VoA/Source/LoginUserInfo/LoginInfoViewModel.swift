//
//  LoginInfoViewModel.swift
//  VoA
//
//  Created by saeng lin on 2020/01/26.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import RxSwift
import RxCocoa
import SwiftyJSON
import SwiftlyUserDefault

enum LoginInfoViewState {
    case request
    case complete(LGSideMenuController)
    case error(Error?)
}

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
        public let state = PublishRelay<LoginInfoViewState>()
    }
    
    public lazy var input: InputType = Input()
    public lazy var output: OutputType = Output()
    
    private let bag = DisposeBag()
    
    public let kakaoInfoPresnetModel: KakaoPresentModel
    private var userModel: UserModel?
    
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
            .map { _ -> LoginInfoViewState in
                return .request
        }.bind(to: output.state)
            .disposed(by: bag)
        
        input.confirmTapped
            .flatMap(weak: self) { (wself, customNickName) -> Observable<JSON> in
                let model = KakaoPresentModel(nickName: customNickName,
                                              profileURL: self.kakaoInfoPresnetModel.profileURL,
                                              kakaoAccountToken: self.kakaoInfoPresnetModel.kakaoAccountToken)
                return LoginNetworker.sigin(model: model).asObservable()
        }.flatMap(weak: self) { (wself, json) -> Observable<JSON> in
            let responseModel = wself.settingUserInfo(json: json)
            self.userModel = responseModel?.data
            return LoginNetworker.sendFcm(userID: responseModel?.data?.userID,
                                          fcmToken: SwiftlyUserDefault.fcmToken).asObservable()
        }.subscribe(onNext: { [weak self] (json) in
            guard let self = self else { return }
            UserViewModel.shared.userModel = self.userModel
            SwiftlyUserDefault.nickName = self.userModel?.userName
            SwiftlyUserDefault.profile = self.userModel?.profileURL
            SwiftlyUserDefault.kakaoToken = self.kakaoInfoPresnetModel.kakaoAccountToken
            
            let viewModel = HomeViewModel()
            let homeNavigationController = HomeNavigationViewController(rootViewController: HomeViewController.instance(homeViewModel: viewModel))
            let navi = LGSideMenuController(rootViewController: homeNavigationController, leftViewController: LeftMenuViewController.instance(homeViewModel: viewModel), rightViewController: nil)
            navi.panGesture.isEnabled = false
            navi.leftViewWidth = 280
            self.output.state.accept(.complete(navi))
            }, onError: {  (error) in
                
                guard let json = VoAUtil.loadJSON("LoginResponseJson") as? [String: Any] else { return }
                let responseModel = UserResponseModel(JSON: json)
                UserViewModel.shared.userModel = responseModel?.data
                SwiftlyUserDefault.nickName = responseModel?.data?.userName
                SwiftlyUserDefault.profile = responseModel?.data?.profileURL
                SwiftlyUserDefault.kakaoToken = self.kakaoInfoPresnetModel.kakaoAccountToken
                
                let viewModel = HomeViewModel()
                let homeNavigationController = HomeNavigationViewController(rootViewController: HomeViewController.instance(homeViewModel: viewModel))
                let navi = LGSideMenuController(rootViewController: homeNavigationController, leftViewController: LeftMenuViewController.instance(homeViewModel: viewModel), rightViewController: nil)
                navi.panGesture.isEnabled = false
                navi.leftViewWidth = 280
                self.output.state.accept(.complete(navi))
                
//                self.output.state.accept(.error(error))
        }).disposed(by: bag)
    }
}

private extension LoginInfoViewModel {
    func settingUserInfo(json: JSON) -> UserResponseModel? {
        guard let dict = json.dictionaryObject else { return nil }
        let model = UserResponseModel(JSON: dict)
        return model
    }
}
