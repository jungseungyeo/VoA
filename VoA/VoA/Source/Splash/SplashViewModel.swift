//
//  SplashViewModel.swift
//  VoA
//
//  Created by Jung seoung Yeo on 2020/01/13.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import RxSwift
import RxCocoa
import SwiftyJSON
import SwiftlyUserDefault

import KakaoOpenSDK

enum SplashViewState {
    case request
    case complete
    case error(Error?)
}

enum AutoLoginState {
    case request
    case complete(LGSideMenuController)
    case error(Error?)
}

class SplashViewModel: NSObject, ReactiveViewModelable {
    typealias InputType = Input
    typealias OutputType = Output
    
    struct Input {
        public let requestNextMove = PublishRelay<Void>()
        public let authoLoginRequest = PublishRelay<Void>()
    }
    
    struct Output {
        public let viewState = PublishRelay<SplashViewState>()
        public let autoLoingState = PublishRelay<AutoLoginState>()
    }
    
    public lazy var input: InputType = Input()
    public lazy var output: OutputType = Output()
    
    private let bag = DisposeBag()
    
    private var userModel: UserModel?
    
    public var isKakaoSession: Bool {
        guard let session = KOSession.shared(), let toekn = session.token else {
            return false
        }
        return !toekn.accessTokenExpiresAt.timeIntervalSinceNow.isZero
    }
    
    override init() {
        super.init()
        
        rxBind()
    }
    
    private func rxBind() {
        
        input.requestNextMove
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                self.output.viewState.accept(.complete)
            }).disposed(by: bag)
        
        input.authoLoginRequest
            .map { _ -> AutoLoginState in
                return .request
        }.bind(to: output.autoLoingState)
            .disposed(by: bag)
        
        input.authoLoginRequest
            .flatMap { _ -> Single<APIResult> in
                let kakaoModel = KakaoPresentModel(nickName: SwiftlyUserDefault.nickName,
                                                   profileURL: URL(string: SwiftlyUserDefault.profile ?? ""),
                                                   kakaoAccountToken: SwiftlyUserDefault.kakaoToken)
                return LoginNetworker.sigin(model: kakaoModel)
        }
//        .flatMap(weak: self) { (wself, result) -> Observable<APIResult> in
//            switch result {
//            case .success(let json):
//                let responseModel = wself.settingUserInfo(json: json)
//                self.userModel = responseModel?.data
//                return LoginNetworker.sendFcm(userID: responseModel?.data?.userID,
//                                              fcmToken: SwiftlyUserDefault.fcmToken).asObservable()
//            case .failure(let error):
//                return Observable.just(APIResult.failure(error))
//            }
//        }
        .subscribe(onNext: {  [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let json):
                UserViewModel.shared.userModel = self.userModel
                let viewModel = HomeViewModel()
                let homeNavigationController = HomeNavigationViewController(rootViewController: HomeViewController.instance(homeViewModel: viewModel))
                let navi = LGSideMenuController(rootViewController: homeNavigationController, leftViewController: LeftMenuViewController.instance(homeViewModel: viewModel), rightViewController: nil)
                navi.panGesture.isEnabled = false
                navi.leftViewWidth = 280
                self.output.autoLoingState.accept(.complete(navi))
            case .failure(let error):
                guard let json = VoAUtil.loadJSON("LoginResponseJson") as? [String: Any] else { return }
                let responseModel = UserResponseModel(JSON: json)
                UserViewModel.shared.userModel = responseModel?.data
                
                let viewModel = HomeViewModel()
                let homeNavigationController = HomeNavigationViewController(rootViewController: HomeViewController.instance(homeViewModel: viewModel))
                let navi = LGSideMenuController(rootViewController: homeNavigationController, leftViewController: LeftMenuViewController.instance(homeViewModel: viewModel), rightViewController: nil)
                navi.panGesture.isEnabled = false
                navi.leftViewWidth = 280
                self.output.autoLoingState.accept(.complete(navi))
            }
        }).disposed(by: bag)
        
    }
    
}

private extension SplashViewModel {
    func settingUserInfo(json: JSON) -> UserResponseModel? {
        guard let dict = json.dictionaryObject else { return nil }
        let model = UserResponseModel(JSON: dict)
        return model
    }
}
