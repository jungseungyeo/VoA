//
//  SplashViewModel.swift
//  VoA
//
//  Created by Jung seoung Yeo on 2020/01/13.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import RxSwift
import RxCocoa

import KakaoOpenSDK

class SplashViewModel: NSObject, ReactiveViewModelable {
    typealias InputType = Input
    typealias OutputType = Output
    
    struct Input {

        public let kakaoLoginTapped = PublishRelay<Void>()
    }
    
    struct Output {
        
    }
    
    public lazy var input: InputType = Input()
    public lazy var output: OutputType = Output()
    
    private let bag = DisposeBag()
    
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
        session.open(completionHandler: { [unowned self] error in
            guard error == nil else {
                
                return
            }

            //인증되어 있는지 여부. [token canRefresh]와 동일한 결과를 리턴합니다.
            if session.isOpen() {
                KOSessionTask.userMeTask(completion: { error, userInfo in

                    
                    print("UserInfo : \(userInfo)")
                    
                })
            } else {
                // 카카오 로그인이 열리지 않음
                
            }
        })
    }
    
}
