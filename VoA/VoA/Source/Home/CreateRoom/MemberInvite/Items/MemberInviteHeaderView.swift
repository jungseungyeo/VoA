//
//  MemberHeaderView.swift
//  VoA
//
//  Created by saeng lin on 2020/01/31.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

extension Reactive where Base: MemberInviteHeaderView {
    var kakaoInviteBtnTapped: Observable<Void> {
        return base.touchBtn.rx.tap.asObservable()
    }
}

class MemberInviteHeaderView: BaseCollectionReusableView {
    
    static let registerID: String = "\(MemberInviteHeaderView.self)"
    
    lazy var topLine: UIView = {
        let lineView = UIView(frame: .zero)
        lineView.backgroundColor = VoAColor.Style.white.withAlphaComponent(0.1)
        return lineView
    }()
    
    lazy var bottomLine: UIView = {
        let lineView = UIView(frame: .zero)
        lineView.backgroundColor = VoAColor.Style.white.withAlphaComponent(0.1)
        return lineView
    }()
    
    lazy var kakaoImg: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "icKakao"))
        iv.contentMode = .scaleAspectFill
        iv.tintColor = VoAColor.Style.white
        return iv
    }()
    
    lazy var kakaoInviteTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = Const.kakaoInviteTitle
        return label
    }()
    
    lazy var rightImg: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "rightG2"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var touchBtn: UIButton = {
        let btn = UIButton(frame: .zero)
        return btn
    }()
    
    private struct Const {
        static let kakaoInviteTitle: NSAttributedString = .init(string: "카카오톡으로 초대하기",
                                                                font: .systemFont(ofSize: 16, weight: .bold), color: VoAColor.Style.white)
    }
    
    public var bag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    
    override func setup() {
        super.setup()
        
        addSubviews(topLine,
                    kakaoImg,
                    kakaoInviteTitle,
                    rightImg,
                    bottomLine,
                    touchBtn)
    }
    
    override func setupUI() {
        super.setupUI()
        
        topLine.snp.remakeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        kakaoImg.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.size.equalTo(24)
        }
        
        kakaoInviteTitle.snp.remakeConstraints { make in
            make.left.equalTo(kakaoImg.snp.right).offset(8)
            make.centerY.equalToSuperview()
        }
        
        rightImg.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.size.equalTo(24)
        }
        
        bottomLine.snp.remakeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        touchBtn.snp.remakeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
}
