//
//  StringRoomMiddleHeaderView.swift
//  VoA
//
//  Created by saeng lin on 2020/02/05.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

class StartingMemeberHeaderView: BaseCollectionReusableView {
    
    static let registerID: String = "\(StartingMemeberHeaderView.self)"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = Const.titleString
        return label
    }()
    
    private struct Const {
        static let titleString: NSAttributedString = .init(string: "귀가전 맴버",
                                                           font: .systemFont(ofSize: 14,
                                                                             weight: .bold),
                                                           color: VoAColor.StartingRoom.noneStartTitleColor)
    }
    
    override func setup() {
        super.setup()
        
        addSubviews(titleLabel)
    }
    
    override func setupUI() {
        super.setupUI()
        
        titleLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(16)
        }
    }
    
    func bind(memberCount: Int?) {
        titleLabel.text = "귀가전 맴버 \(memberCount ?? 0)"
    }
}
