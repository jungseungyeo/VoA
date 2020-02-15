//
//  LeftNewRoomCell.swift
//  VoA
//
//  Created by saeng lin on 2020/02/09.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

class LeftMenuNewRoomCell: BaseCollectionViewCell {
    
    static let registerID: String = "\(LeftMenuNewRoomCell.self)"
    
    lazy var thumbnailImg: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "icNewgroup"))
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .black
        iv.clipsToBounds = true
        iv.layer.cornerRadius = Const.thumbnailSize.height / 2
        iv.backgroundColor = .red
        return iv
    }()
    
    lazy var roomTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = Const.roomTitle
        return label
    }()
    
    private struct Const {
        static let thumbnailSize: CGSize = .init(width: 55, height: 55)
        static let roomTitle: NSAttributedString = .init(string: "새로운 귀가방 만들기",
                                                         font: .systemFont(ofSize: 16,
                                                                           weight: .bold),
                                                         color: .white)
        static let rightSize: CGSize = .init(width: 5, height: 11)
    }
    
    override func setup() {
        super.setup()
        
    }
    
    override func setupUI() {
        super.setupUI()
    }
}
