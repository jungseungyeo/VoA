//
//  StartingMemeberCollectionCell.swift
//  VoA
//
//  Created by saeng lin on 2020/02/06.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

enum GaugebarState: Int {
    case none = 0
    case one = 25
    case two = 50
    case three = 70
    case four = 100
    case warning = 101
    
    var image: UIImage? {
        switch self {
        case .none:
            return nil
        case .one:
            return UIImage(named: "invalidName")
        case .two:
            return UIImage(named: "two")
        case .three:
            return UIImage(named: "three")
        case .four:
            return UIImage(named: "four")
        case .warning:
            return UIImage(named: "warning")
        }
    }
}

extension Reactive where Base: StartingMemeberCollectionCell {
    var sendMessageBtnTapped: Observable<Void> {
        return base.sendMessageBtn.rx.tap.asObservable()
    }
}

class StartingMemeberCollectionCell: BaseCollectionViewCell {
    
    static let registerID: String = "\(StartingMemeberCollectionCell.self)"
    
    public var bag = DisposeBag()
    
    lazy var containerView: UIView = {
        let containerView = UIView(frame: .zero)
        containerView.backgroundColor = VoAColor.StartingRoom.startingMemeberContainerViewColor
        containerView.layer.cornerRadius = 8
        return containerView
    }()
    
    lazy var profileImg: UIImageView = {
        let iv = UIImageView(image: nil)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = Const.profiletSize.height / 2
        iv.clipsToBounds = true
        iv.backgroundColor = .black
        return iv
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = Const.nameTitle
        return label
    }()
    
    lazy var remindTimeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = Const.remindTimeTitle
        return label
    }()
    
    lazy var memberStatusLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = Const.memberStatusTitle
        return label
    }()
    
    lazy var sendMessageBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setBackgroundImage(Const.requestMessageBtnImg, for: .normal)
        return btn
    }()
    
    lazy var fromtBackgaugebar: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "copy3"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var endBackgaugebar: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "copy1"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var middleBackgaugebar: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "copy2"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var gaugebar: UIImageView = {
        let iv = UIImageView(image: UIImage(named: ""))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    
    private struct Const {
        static let profiletSize: CGSize = .init(width: 40, height: 40)
        static let nameTitle: NSAttributedString = .init(string: "123",
                                                         font: .systemFont(ofSize: 14,
                                                                           weight: .regular),
                                                         color: VoAColor.Style.white)
        static let remindTimeTitle: NSAttributedString = .init(string: "123",
                                                               font: .systemFont(ofSize: 14,
                                                                                 weight: .regular),
                                                               color: VoAColor.StartingRoom.memberRemindTimeColor)
        static let memberStatusTitle: NSAttributedString = .init(string: "123",
                                                             font: .systemFont(ofSize: 16,
                                                                               weight: .bold),
                                                             color: VoAColor.Style.white)
        static let requestMessageBtnImg: UIImage? = UIImage(named: "buttonNudgeNormal")
        static let responseMessageBtnImg: UIImage? = UIImage(named: "buttonNudgeReturn")
        static let sendMessageSize: CGSize = .init(width: 93, height: 46)
    }
    
    override func setup() {
        super.setup()
        
        addSubviews(containerView)
        
        containerView.addSubviews(profileImg,
                                  nameLabel,
                                  remindTimeLabel,
                                  memberStatusLabel,
                                  sendMessageBtn,
                                  fromtBackgaugebar,
                                  endBackgaugebar,
                                  middleBackgaugebar,
                                  gaugebar)
    }
    
    override func setupUI() {
        super.setupUI()
        
        containerView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        profileImg.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.size.equalTo(Const.profiletSize)
        }
        
        nameLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(profileImg.snp.right).offset(8)
        }
        
        remindTimeLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(nameLabel.snp.right).offset(8)
        }
        
        memberStatusLabel.snp.remakeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.equalTo(nameLabel.snp.left)
        }
        
        sendMessageBtn.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-16)
            make.size.equalTo(Const.sendMessageSize)
        }
        
        fromtBackgaugebar.snp.remakeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.size.equalTo(CGSize.init(width: 16, height: 16))
            make.bottom.equalToSuperview().offset(-16)
        }
        
        endBackgaugebar.snp.remakeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.size.equalTo(CGSize.init(width: 16, height: 16))
            make.bottom.equalToSuperview().offset(-16)
        }
        
        middleBackgaugebar.snp.remakeConstraints { make in
            make.height.equalTo(16)
            make.left.equalTo(fromtBackgaugebar.snp.right)
            make.right.equalTo(endBackgaugebar.snp.left)
            make.centerY.equalTo(fromtBackgaugebar.snp.centerY)
        }
        
        gaugebar.snp.remakeConstraints { make in
            make.left.equalTo(fromtBackgaugebar.snp.left)
            make.right.equalTo(endBackgaugebar.snp.right)
            make.height.equalTo(16)
            make.centerY.equalTo(fromtBackgaugebar.snp.centerY)
        }
    }
    
    func bind(name: String?, profileURLstring: String?, remindTime: Int, goHomeTime: Int, isMessage: Bool, userStatus: UserStatus, state: GaugebarState = .none) {
        nameLabel.text = name
        gaugebar.image = state.image
        
        if let profileUrl = URL(string: profileURLstring ?? "") {
            profileImg.kf.setImage(with: profileUrl)
        }
        
        if remindTime > 0 {
            remindTimeLabel.text = "\(remindTime)분전 응답"
        } else {
            remindTimeLabel.text = ""
        }
        
        if isMessage {
            sendMessageBtn.setBackgroundImage(Const.requestMessageBtnImg, for: .normal)
        } else {
            sendMessageBtn.setBackgroundImage(Const.responseMessageBtnImg, for: .normal)
        }
        
        switch userStatus {
        case .noneStart:
            memberStatusLabel.text = "귀가전"
            memberStatusLabel.textColor = VoAColor.Style.white
        case .starting:
            memberStatusLabel.text = "\(goHomeTime)분 후 도착"
            memberStatusLabel.textColor = VoAColor.Style.white
        case .end:
            print()
        case .past:
            memberStatusLabel.text = "귀가 예정 시간 지남"
            memberStatusLabel.textColor = VoAColor.StartingRoom.memberWarningStatusColor
        }
    }

}
