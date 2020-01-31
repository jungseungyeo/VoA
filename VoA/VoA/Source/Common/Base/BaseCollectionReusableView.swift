//
//  BaseCollectionReusableView.swift
//  VoA
//
//  Created by saeng lin on 2020/01/31.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

class BaseCollectionReusableView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        setupUI()
    }
    
    func setup() { }
    func setupUI() { }
}
