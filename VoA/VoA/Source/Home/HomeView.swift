//
//  HomeView.swift
//  VoA
//
//  Created by Jung seoung Yeo on 2020/01/20.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

class HomeView: BaseView {
    
    lazy var text: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = .init(string: "개발중",
                                     font: .systemFont(ofSize: 50,
                                                       weight: .bold),
                                     color: .black)
        return label
    }()
    
    override func setup() {
        super.setup()
        
        backgroundColor = .darkGray
        
        addSubviews(text)
    }
    
    override func setupUI() {
        super.setupUI()
        
        text.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
