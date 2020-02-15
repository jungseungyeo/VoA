//
//  LeftNewRoomCell.swift
//  VoA
//
//  Created by saeng lin on 2020/02/09.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

extension Reactive where Base: LeftMenuNewRoomCell {
    var newRoomCellTapped: Observable<Void> {
        return  base.newRoomCellTapped.rx.tap.asObservable()
    }
}
class LeftMenuNewRoomCell: BaseCollectionViewCell {
    
    static let registerID: String = "\(LeftMenuNewRoomCell.self)"
    
    public var bag = DisposeBag()
    
    lazy var thumbnailImg: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "icNewgroup"))
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
    
    lazy var newRoomCellTapped: UIButton = {
        let btn = UIButton(type: .system)
        return btn
    }()
    
    private struct Const {
        static let thumbnailSize: CGSize = .init(width: 55, height: 55)
        static let roomTitle: NSAttributedString = .init(string: "새로운 귀가방 만들기",
                                                         font: .systemFont(ofSize: 16,
                                                                           weight: .bold),
                                                         color: .white)
        static let rightSize: CGSize = .init(width: 5, height: 11)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    
    override func setup() {
        super.setup()
        
        addSubviews(thumbnailImg,
                    roomTitle,
                    newRoomCellTapped)
        
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
        
        newRoomCellTapped.snp.remakeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}
