//
//  SplashNode.swift
//  VoA
//
//  Created by Jung seoung Yeo on 2020/01/11.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

import SnapKit

class SplashView: BaseView {
    
    lazy var logoText: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "굳 밤!"
        return label
    }()
    
    lazy var kakaoBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = const.kakaobgColor
        button.setAttributedTitle(NSAttributedString(string: const.kakaoTitle,
                                                     font: .systemFont(ofSize: 16, weight: .bold),
                                                     color: const.kakaoBtnColor),
                                  for: .normal)
        button.contentEdgeInsets = const.kakaoTitleInset
        button.layer.cornerRadius = const.kakaoBtnHeight / 2
        return button
    }()
    
    lazy var kakaoIcon: UIImageView = {
        let imageView = UIImageView(image: const.kakaoIconImage)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let const = Const()
    
    private struct Const {

        let ratio = UIScreen.main.bounds.height / 667

        let bgImage = UIImage(named: "splashBg")

        let widthOffset: CGFloat = 24
        let kakaoBtnHeight: CGFloat = 48
        let kakaobgColor = UIColor(r: 255, g: 235, b: 0)
        let kakaoTitle: String = "카카오계정으로 로그인"
        let kakaoBtnColor: UIColor = UIColor(r: 60, g: 30, b: 30)
        let kakaoTitleInset: UIEdgeInsets = .init(top: 16, left: 40, bottom: 16, right: 0)

        let kakaoBottomOffset: CGFloat = 18

        let bottomOffset: CGFloat = 64

        let kakaoIconImage = UIImage(named: "imgKakaologin")
        let kakaoIconLeftOffset: CGFloat = 26
        let kakaoHeightOffset: CGFloat = 3
        let kakaIconWidht: CGFloat = 53
    }
    
    override func setup() {
        super.setup()
        
        addSubviews(logoText,
                    kakaoBtn)
        
        kakaoBtn.addSubviews(kakaoIcon)
    }
    
    override func setupUI() {
        super.setupUI()
        
        kakaoBtn.snp.remakeConstraints { make in
            make.left.equalToSuperview().offset(const.widthOffset)
            make.right.equalToSuperview().offset(-const.widthOffset)
            make.height.equalTo(const.kakaoBtnHeight)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-123)
        }

        kakaoIcon.snp.remakeConstraints { make in
            make.left.equalToSuperview().offset(const.kakaoIconLeftOffset)
            make.top.equalToSuperview().offset(const.kakaoHeightOffset)
            make.bottom.equalToSuperview().offset(-const.kakaoHeightOffset)
            make.width.equalTo(const.kakaIconWidht)
        }
    }
}
