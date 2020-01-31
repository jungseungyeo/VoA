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
                let template = KMTFeedTemplate.init(builderBlock: { [weak self] (feedTemplateBuilder) in
                    guard let self = self else {return }
                    feedTemplateBuilder.content = KMTContentObject(builderBlock: { (contentBuilder) in
                        contentBuilder.title = self.roomTitle
                        contentBuilder.desc = self.roomTitle
                        contentBuilder.imageURL = URL(string: "https://miro.medium.com/fit/c/96/96/2*leGDnXsn4vEC85RCecbceA.png")!
                        contentBuilder.link = KMTLinkObject(builderBlock: { (klklinkBuilder) in
                        })
                        
                    })
                    
//                    feedTemplateBuilder.addButton(KMTButtonObject(builderBlock: { (buttonBuilder) in
//                        buttonBuilder.title = "웹으로 이동"
//                        buttonBuilder.link = KMTLinkObject(builderBlock: { (linkBuilder) in
////                            linkBuilder.mobileWebURL = URL(string: "https://promissu.com/?roomid=\(self.invitingModel?.id ?? -999)")
//                        })
//                    }))
                    
                    feedTemplateBuilder.addButton(KMTButtonObject(builderBlock: { (buttonBuilder) in
                        buttonBuilder.title = "앱으로 이동"
                        buttonBuilder.link = KMTLinkObject(builderBlock: { [weak self] (linkBuilder) in
                            guard let self = self else { return }
                            linkBuilder.iosExecutionParams = "roomid=\(123123)"
//                            linkBuilder.androidExecutionParams = "roomid=\(self.invitingModel?.id ?? -999)"
                        })
                    }))
                })
                
                KLKTalkLinkCenter.shared().sendDefault(with: template, success: { (warningMsg, argumentMsg) in
                    print("warningMsg: \(warningMsg)")
                    print("argumentMsg : \(argumentMsg)")
                }, failure: { (error) in
                    print("error \(error.localizedDescription)")
                })
            }).disposed(by: bag)
    }
}
