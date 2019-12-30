//
//  BaseView.swift
//  VoA
//
//  Created by saenglin on 2019/12/30.
//  Copyright © 2019 linsaeng. All rights reserved.
//

import UIKit

protocol BaseViewable {
    func setup()
    func setupUI()
}

class BaseView: UIView, BaseViewable {
    
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
    
    func setup() {
        backgroundColor = VoAColor.Style.background
    }
    func setupUI() { }
    
    
}
