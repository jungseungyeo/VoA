//
//  LEftMenuHeaderView.swift
//  VoA
//
//  Created by saeng lin on 2020/02/09.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

class LeftMenuHeaderView: BaseCollectionReusableView {
    
    static let registerID: String = "\(LeftMenuHeaderView.self)"
    
    lazy var headerTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = Const.headerTitle
        return label
    }()
    
    private struct Const {
        static let headerTitle: NSAttributedString = .init(string: "나의 귀가방",
                                                           font: .systemFont(ofSize: 14,
                                                                             weight: .bold),
                                                           color: VoAColor.LeftMenu.headerTitelColor)
        static let headerTitleLeftOffset: CGFloat = 16
    }
    
    override func setup() {
        super.setup()
        
        addSubviews(headerTitle)
    }
    
    override func setupUI() {
        super.setupUI()
        
        headerTitle.snp.remakeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(Const.headerTitleLeftOffset)
        }
    }
}
