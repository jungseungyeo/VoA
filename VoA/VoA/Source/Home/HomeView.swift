//
//  HomeView.swift
//  VoA
//
//  Created by saenglin on 2019/12/30.
//  Copyright © 2019 linsaeng. All rights reserved.
//

import UIKit

class HomeView: BaseView {
    
    lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "to be continued..."
        label.textColor = VoAColor.Style.label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40, weight: .bold)
        return label
    }()
    
    override func setup() {
        super.setup()
        
        addSubViews(title)
    }
    
    override func setupUI() {
        super.setupUI()
        
        title.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
