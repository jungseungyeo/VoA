//
//  MemeberInviteView.swift
//  VoA
//
//  Created by saeng lin on 2020/01/31.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

class MemberInviteView: BaseView {
    
    lazy var memberCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = VoAColor.Style.background
        return collectionView
    }()
    
    override func setup() {
        super.setup()
        
        addSubviews(memberCollectionView)
    }
    
    override func setupUI() {
        super.setupUI()
        
        memberCollectionView.snp.remakeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
