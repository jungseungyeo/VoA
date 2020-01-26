//
//  LoginViewModel.swift
//  VoA
//
//  Created by Jung seoung Yeo on 2020/01/20.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import RxSwift
import RxCocoa

enum LoginViewState {
    case requeste
    case complete
    case error(Error?)
}

struct KakaoPresentModel {
    let nickName: String?
    let profileURL: URL?
}

class LoginViewModel: NSObject, ReactiveViewModelable {
    
    typealias InputType = Input
    typealias OutputType = Output
    
    struct Input {
        public let kakaoLoginTapped = PublishRelay<Void>()
    }
    
    struct Output {
        public let viewState = PublishRelay<LoginViewState>()
    }
    
    public lazy var input: InputType = Input()
    public lazy var output: OutputType = Output()
    
    private let bag = DisposeBag()
    
    private(set) var kakaoPresentModel: KakaoPresentModel? = nil
    
    override init() {
        super.init()
        
        rxBind()
    }
    
    private func rxBind() {

        input.kakaoLoginTapped
            .subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                self.kakaoLogin()
            }).disposed(by: bag)
    }
    
    func kakaoLogin() {
        guard let session = KOSession.shared() else { return }

        // session이 있으면 닫아주는 역할
        if session.isOpen() {
            session.close()
        }
        // open 시도
        session.open(completionHandler: { [weak self] error in
            guard let self = self else { return }
            guard error == nil else {
                self.output.viewState.accept(.error(error))
                return
            }

            //인증되어 있는지 여부. [token canRefresh]와 동일한 결과를 리턴합니다.
            if session.isOpen() {
                KOSessionTask.userMeTask(completion: { [weak self] error, userInfo in
                    guard let self = self else { return }
                    
                    let nickname = userInfo?.account?.profile?.nickname
                    let profileUrl = userInfo?.account?.profile?.profileImageURL
                    
                    let kakaoPresentModel = KakaoPresentModel(nickName: nickname,
                                                              profileURL: profileUrl)
                    
                    self.kakaoPresentModel = kakaoPresentModel
                    self.output.viewState.accept(.complete)
                })
            } else {
                // 카카오 로그인이 열리지 않음
                self.output.viewState.accept(.error(nil))
            }
        })
    }
}
