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
        label.attributedText = .init(string: "굳밤",
                                     font: .systemFont(ofSize: 30,
                                                       weight: .bold),
                                     color: .orange)
        return label
    }()
    
    lazy var descriptionText: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = .init(string: "안전귀가앱",
                                     font: .systemFont(ofSize: 15,
                                                       weight: .bold),
                                     color: .gray)
        return label
    }()
    
    
    override func setup() {
        super.setup()
        
        backgroundColor = .darkGray
        
        addSubviews(logoText,
                    descriptionText)
    }
    
    override func setupUI() {
        super.setupUI()
        
        logoText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(150)
        }
        
        descriptionText.snp.makeConstraints { make in
            make.top.equalTo(logoText.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
}
