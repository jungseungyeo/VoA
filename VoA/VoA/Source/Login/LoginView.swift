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
    
    private lazy var kakaoBackShadowBtn: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setAttributedTitle(Const.kakaLoginTitle, for: .normal)
        btn.clipsToBounds = true
        btn.contentEdgeInsets = .init(top: 0, left: 34, bottom: 0, right: 0)
        btn.backgroundColor = VoAColor.Login.kakaoColor
        btn.layer.cornerRadius = Const.loginBtnHeigth / 2
        btn.layer.shadowColor = VoAColor.Login.topShadowColor.cgColor
        btn.layer.shadowOffset = CGSize(width: -3.0, height: -3.0)
        btn.layer.shadowOpacity = 1.0
        btn.layer.shadowRadius = 4.0
        btn.layer.masksToBounds = false
        return btn
    }()
    
    lazy var kakaoBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setAttributedTitle(Const.kakaLoginTitle, for: .normal)
        btn.clipsToBounds = true
        btn.contentEdgeInsets = .init(top: 0, left: 34, bottom: 0, right: 0)
        btn.backgroundColor = VoAColor.Login.kakaoColor
        btn.layer.cornerRadius = Const.loginBtnHeigth / 2
        btn.layer.shadowColor = VoAColor.Login.bottomShadowColor.cgColor
        btn.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        btn.layer.shadowOpacity = 1.0
        btn.layer.shadowRadius = 4.0
        btn.layer.masksToBounds = false
        return btn
    }()
    
    lazy var kakaoLogoImg: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "icKakao"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var appleBakcShadowBtn: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setAttributedTitle(Const.appleLoginTitle, for: .normal)
        btn.clipsToBounds = true
        btn.contentEdgeInsets = .init(top: 0, left: 27, bottom: 0, right: 0)
        btn.backgroundColor = VoAColor.Login.kakaoColor
        btn.layer.cornerRadius = Const.loginBtnHeigth / 2
        btn.layer.shadowColor = VoAColor.Login.topShadowColor.cgColor
        btn.layer.shadowOffset = CGSize(width: -3.0, height: -3.0)
        btn.layer.shadowOpacity = 1.0
        btn.layer.shadowRadius = 4.0
        btn.layer.masksToBounds = false
        return btn
    }()
    
    lazy var appleBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setAttributedTitle(Const.appleLoginTitle, for: .normal)
        btn.clipsToBounds = true
        btn.contentEdgeInsets = .init(top: 0, left: 27, bottom: 0, right: 0)
        btn.backgroundColor = VoAColor.Login.kakaoColor
        btn.layer.cornerRadius = Const.loginBtnHeigth / 2
        btn.layer.shadowColor = VoAColor.Login.bottomShadowColor.cgColor
        btn.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        btn.layer.shadowOpacity = 1.0
        btn.layer.shadowRadius = 4.0
        btn.layer.masksToBounds = false
        return btn
    }()
    
    lazy var appleImg: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "icApple"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private struct Const {
        static let loginBtnHeigth: CGFloat = 55
        static let kakaoImg: UIImageView = UIImageView(image: UIImage(named: "icKakao"))
        static let kakaLoginTitle: NSAttributedString = .init(string: "카카오톡으로 로그인",
                                                              font: .systemFont(ofSize: 18,
                                                                                weight: .bold),
                                                              color: VoAColor.Style.white)
        static let appleLoginTitle: NSAttributedString = .init(string: "Apple 계정으로 로그인",
                                                               font: .systemFont(ofSize: 18,
                                                                                 weight: .bold),
                                                               color: VoAColor.Style.white)
        
        static let iconSize: CGSize = .init(width: 24, height: 24)
        static let kakaoImgLeftOffset: CGFloat = 86
        
        static let kakaoBtnSideOffset: CGFloat = 18
        static let kakaoBottomOffset: CGFloat = -24
        static let leftOffset: CGFloat = VoAUtil.isiPhoneSE ? 30 : 86
        static let appleLeftOffset: CGFloat = VoAUtil.isiPhoneSE ? 30 : 69
        static let appleBtnBottomOffset: CGFloat = VoAUtil.isiPhoneSE ? -100 : -168
    }
    
    override func setup() {
        super.setup()
        
        addSubviews(kakaoBackShadowBtn,
                    kakaoBtn,
                    kakaoLogoImg,
                    appleBakcShadowBtn,
                    appleBtn)
        
        kakaoBtn.addSubviews(kakaoLogoImg)
        
        appleBtn.addSubviews(appleImg)
    }
    
    override func setupUI() {
        super.setupUI()
        
        appleBakcShadowBtn.snp.remakeConstraints { make in
            make.left.equalToSuperview().offset(Const.kakaoBtnSideOffset)
            make.right.equalToSuperview().offset(-Const.kakaoBtnSideOffset)
            make.height.equalTo(Const.loginBtnHeigth)
            make.bottom.equalToSuperview().offset(Const.appleBtnBottomOffset)
        }
        
        appleBtn.snp.remakeConstraints { make in
            make.left.equalToSuperview().offset(Const.kakaoBtnSideOffset)
            make.right.equalToSuperview().offset(-Const.kakaoBtnSideOffset)
            make.height.equalTo(Const.loginBtnHeigth)
            make.bottom.equalToSuperview().offset(Const.appleBtnBottomOffset)
        }
        
        appleImg.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(Const.appleLeftOffset)
            make.size.equalTo(Const.iconSize)
        }
        
        kakaoBackShadowBtn.snp.remakeConstraints { make in
            make.bottom.equalTo(appleBtn.snp.top).offset(Const.kakaoBottomOffset)
            make.left.equalToSuperview().offset(Const.kakaoBtnSideOffset)
            make.right.equalToSuperview().offset(-Const.kakaoBtnSideOffset)
            make.height.equalTo(Const.loginBtnHeigth)
        }
        
        kakaoBtn.snp.remakeConstraints { make in
            make.bottom.equalTo(appleBtn.snp.top).offset(Const.kakaoBottomOffset)
            make.left.equalToSuperview().offset(Const.kakaoBtnSideOffset)
            make.right.equalToSuperview().offset(-Const.kakaoBtnSideOffset)
            make.height.equalTo(Const.loginBtnHeigth)
        }
        
        kakaoLogoImg.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(Const.leftOffset)
            make.size.equalTo(Const.iconSize)
        }
    }
}
