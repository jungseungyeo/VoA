//
//  LeftMenuView.swift
//  VoA
//
//  Created by saeng lin on 2020/01/27.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

class LeftMenuView: BaseView {
    
    lazy var dismissBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "closeWhiteNormal44"), for: .normal)
        btn.tintColor = VoAColor.Style.white
        return btn
    }()
    
    lazy var profileImg: UIImageView = {
        let iv = UIImageView(image: UIImage())
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = Const.profileSize.height / 2
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = Const.userNameString
        label.numberOfLines = 0
        label.textColor = VoAColor.Style.white
        return label
    }()
    
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
    
    private struct Const {
        static let dismissSize: CGSize = .init(width: 44, height: 44)
        static let profileSize: CGSize = .init(width: 40, height: 40)
        static let profileTopOffset: CGFloat = 15
        static let profileLeftOffset: CGFloat = 16
        
        static let userNameString: NSAttributedString = .init(string: "",
                                                              font: .systemFont(ofSize: 16,
                                                                                weight: .bold),
                                                              color: VoAColor.Style.white)
        static let userNameLeftOffset: CGFloat = 8
        static let userNameRightOffset: CGFloat = -96
    }
    
    override func setup() {
        super.setup()
        
        addSubviews(dismissBtn,
                    profileImg,
                    userName,
                    collectionView)
    }
    
    override func setupUI() {
        super.setupUI()
        
        dismissBtn.snp.remakeConstraints { make in
            make.size.equalTo(Const.dismissSize)
            make.top.equalTo(safeAreaLayoutGuide)
            make.left.equalToSuperview()
        }
        
        profileImg.snp.remakeConstraints { make in
            make.top.equalTo(dismissBtn.snp.bottom).offset(Const.profileTopOffset)
            make.left.equalToSuperview().offset(Const.profileLeftOffset)
            make.size.equalTo(Const.profileSize)
        }
        
        userName.snp.remakeConstraints { make in
            make.centerY.equalTo(profileImg.snp.centerY)
            make.left.equalTo(profileImg.snp.right).offset(Const.userNameLeftOffset)
            make.right.equalToSuperview().offset(Const.userNameRightOffset)
        }
        
        collectionView.snp.remakeConstraints { make in
            make.top.equalTo(profileImg.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
