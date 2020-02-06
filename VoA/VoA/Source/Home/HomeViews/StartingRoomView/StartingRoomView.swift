//
//  StartingRoomView.swift
//  VoA
//
//  Created by saeng lin on 2020/02/05.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import Foundation

class StartingRoomView: BaseView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = VoAColor.Style.background
        return collectionView
    }()
    
    lazy var navigationBarBackgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = VoAColor.StartingRoom.navigationBackgroundColor
        return view
    }()
    
    override func setup() {
        super.setup()
        
        addSubviews(collectionView,
                    navigationBarBackgroundView)
    }
    
    override func setupUI() {
        super.setupUI()
        
        collectionView.snp.remakeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        }
        
        navigationBarBackgroundView.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalTo(collectionView.snp.top)
        }
    }
}
