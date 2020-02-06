//
//  StartingMemeberCollectionCell.swift
//  VoA
//
//  Created by saeng lin on 2020/02/06.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

class StartingMemeberCollectionCell: BaseCollectionViewCell {
    
    static let registerID: String = "\(StartingMemeberCollectionCell.self)"
    
    lazy var containerView: UIView = {
        let containerView = UIView(frame: .zero)
        containerView.backgroundColor = VoAColor.StartingRoom.startingMemeberContainerViewColor
        containerView.layer.cornerRadius = 8
        return containerView
    }()
    
    override func setup() {
        super.setup()
        
        addSubviews(containerView)
    }
    
    override func setupUI() {
        super.setupUI()
        
        containerView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
}
