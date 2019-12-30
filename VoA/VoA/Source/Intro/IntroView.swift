//
//  IntroView.swift
//  VoA
//
//  Created by saenglin on 2019/12/30.
//  Copyright © 2019 linsaeng. All rights reserved.
//

import UIKit
import SnapKit

class IntroView: BaseView {
    
    lazy var title0: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "정승야..."
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = VoAColor.Style.label
        label.alpha = 0.0
        label.textAlignment = .left
        return label
    }()
    
    lazy var title1: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "제발... 좀..."
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = VoAColor.Style.label
        label.alpha = 0.0
        label.textAlignment = .left
        return label
    }()
    
    lazy var title2: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "술 좀 그만 먹고..."
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = VoAColor.Style.label
        label.alpha = 0.0
        label.textAlignment = .left
        return label
    }()
    
    lazy var title3: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "집에 좀 가라...🤪"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = VoAColor.Style.label
        label.alpha = 0.0
        label.textAlignment = .left
        return label
    }()
    
    override func setup() {
        super.setup()
        
        addSubViews(title1,
                    title0,
                    title2,
                    title3)
    }
    
    override func setupUI() {
        super.setupUI()
        
        title1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
        }
        
        title0.snp.makeConstraints { make in
            make.bottom.equalTo(title1.snp.top).offset(-20)
            make.centerX.equalTo(title1.snp.centerX).offset(0)
        }
        
        title2.snp.makeConstraints { make in
            make.top.equalTo(title1.snp.bottom).offset(20)
            make.centerX.equalTo(title1.snp.centerX).offset(0)
        }
        
        title3.snp.makeConstraints { make in
            make.top.equalTo(title2.snp.bottom).offset(20)
            make.centerX.equalTo(title1.snp.centerX).offset(0)
        }
    }
}
