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
    
    lazy var logoImg: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "TestLogo"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var logoText: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = Const.logoText
        label.numberOfLines = 0
        return label
    }()
    
    lazy var logoDescription: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = Const.logoDescriptionText
        label.numberOfLines = 0
        return label
    }()
    
    
    private struct Const {
        static let imgSize: CGSize = .init(width: 47,
                                           height: 50)
        static let logoText: NSAttributedString = .init(string: "굿밤",
                                                        font: .systemFont(ofSize: 28,
                                                                          weight: .bold),
                                                        color: VoAColor.Splash.logoTextColor)
        static let logoDescriptionText: NSAttributedString = .init(string: "안심귀가앱",
                                                                   font: .systemFont(ofSize: 20,
                                                                                     weight: .bold),
                                                                   color: VoAColor.Splash.logoDescriptionTextColor)
    }
    
    private let cosnt = Const()
    
    override func setup() {
        super.setup()
        
        addSubviews(logoImg,
                    logoText,
                    logoDescription)
        
    }
    
    override func setupUI() {
        super.setupUI()
        
        logoImg.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(165)
            make.height.equalTo(Const.imgSize.height)
            make.width.equalTo(Const.imgSize.width)
        }
        
        logoText.snp.remakeConstraints { make in
            make.top.equalTo(logoImg.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        logoDescription.snp.makeConstraints { make in
            make.top.equalTo(logoText.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
}
