//
//  LeftMenuRoomCell.swift
//  VoA
//
//  Created by saeng lin on 2020/02/09.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

extension Reactive where Base: LeftMenuRoomCell {
    var leftRoomTapped: Observable<Void> {
        return base.roomCellTapped.rx.tap.asObservable()
    }
}

class LeftMenuRoomCell: BaseCollectionViewCell {
    
    static let registerID: String = "\(LeftMenuRoomCell.self)"
    
    public var bag = DisposeBag()
    
    private lazy var thumbnailImg: UIImageView = {
        let iv = UIImageView(image: UIImage(named: ""))
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .black
        iv.clipsToBounds = true
        iv.layer.cornerRadius = Const.thumbnailSize.height / 2
        iv.backgroundColor = .red
        return iv
    }()
    
    private lazy var roomTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = Const.roomTitle
        return label
    }()
    
    private lazy var rightImg: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "icArrow"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var roomCellTapped: UIButton = {
        let btn = UIButton(type: .system)
        return btn
    }()
    
    private struct Const {
        static let thumbnailSize: CGSize = .init(width: 55, height: 55)
        static let roomTitle: NSAttributedString = .init(string: "",
                                                         font: .systemFont(ofSize: 16,
                                                                           weight: .bold),
                                                         color: .white)
        static let rightSize: CGSize = .init(width: 30, height: 30)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    
    override func setup() {
        super.setup()
        
        addSubviews(thumbnailImg,
                    roomTitle,
                    rightImg,
                    roomCellTapped)
    }
    
    override func setupUI() {
        super.setupUI()
        
        thumbnailImg.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.size.equalTo(Const.thumbnailSize)
        }
        
        roomTitle.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(thumbnailImg.snp.right).offset(8)
            make.right.equalToSuperview()
        }
        
        rightImg.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.size.equalTo(Const.rightSize)
        }
        
        roomCellTapped.snp.remakeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    public func bind(titleString: String?) {
        roomTitle.text = titleString
    }
}
