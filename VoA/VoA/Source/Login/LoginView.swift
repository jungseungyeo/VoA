//
//  LoginView.swift
//  VoA
//
//  Created by Jung seoung Yeo on 2020/01/20.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

import AuthenticationServices

class LoginView: SplashView {
    
    lazy var kakaoBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.layer.cornerRadius = Const.btnHeight / 2
        btn.backgroundColor = VoAColor.Login.kakaoColor
        btn.setAttributedTitle(Const.kakaoText, for: .normal)
        btn.contentEdgeInsets = Const.kakaoTextInset
        return btn
    }()
    
    private lazy var kakaoImg: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "imgKakaologin"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var appleBtn: ASAuthorizationAppleIDButton = {
        let btn = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn,
                                               authorizationButtonStyle: .black)
        btn.cornerRadius = Const.btnHeight / 2
        return btn
    }()
    
    private let const = Const()
    
    private struct Const {
        static let kakaoText: NSAttributedString = .init(string: "카카오톡으로 로그인",
                                                         font: .systemFont(ofSize: 18,
                                                                           weight: .bold),
                                                         color: VoAColor.Login.kakaoTextColor)
        static let kakaoTextInset: UIEdgeInsets = .init(top: 0,
                                                        left: 36,
                                                        bottom: 0,
                                                        right: 0)
        static let btnHeight: CGFloat = 55
        static let sideInset: CGFloat = 30
        static let kakaoBottomInset: CGFloat = 242
    }
    
    override func setup() {
        super.setup()
        
        addSubviews(kakaoBtn,
                    kakaoImg,
                    appleBtn)
        
    }
    
    override func setupUI() {
        super.setupUI()
        
        kakaoBtn.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().inset(Const.kakaoBottomInset)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().inset(Const.sideInset)
            make.right.equalToSuperview().inset(Const.sideInset)
            make.height.equalTo(Const.btnHeight)
        }

        kakaoImg.snp.remakeConstraints { make in
            make.centerY.equalTo(kakaoBtn.snp.centerY)
            make.left.equalToSuperview().inset(80)
        }
        
        appleBtn.snp.makeConstraints { make in
            make.top.equalTo(kakaoBtn.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().inset(Const.sideInset)
            make.right.equalToSuperview().inset(Const.sideInset)
            make.height.equalTo(Const.btnHeight)
        }
    }
}
