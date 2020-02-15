//
//  LeftMenuRoomCell.swift
//  VoA
//
//  Created by saeng lin on 2020/02/09.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

class LeftMenuRoomCell: BaseCollectionViewCell {
    
    static let registerID: String = "\(LeftMenuRoomCell.self)"
    
    lazy var thumbnailImg: UIImageView = {
        let iv = UIImageView(image: UIImage(named: ""))
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .black
        iv.clipsToBounds = true
        iv.layer.cornerRadius = Const.thumbnailSize.height / 2
        return iv
    }()
    
    lazy var roomTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = Const.roomTitle
        return label
    }()
    
    private struct Const {
        static let thumbnailSize: CGSize = .init(width: 55, height: 55)
        static let roomTitle: NSAttributedString = .init(string: "",
                                                         font: .systemFont(ofSize: 16,
                                                                           weight: .bold),
                                                         color: VoAColor.Style.white)
    }
    
    override func setup() {
        super.setup()
        
        addSubviews(thumbnailImg,
                    roomTitle)
    }
    
    override func setupUI() {
        super.setupUI()
        
        thumbnailImg.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        roomTitle.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(thumbnailImg.snp.right).offset(8)
            make.right.equalToSuperview()
        }
    }
    
    public func bind(titleString: String?) {
        roomTitle.text = titleString
    }
}
