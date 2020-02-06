//
//  StartingRoomEndMemeberCollectionViewCell.swift
//  VoA
//
//  Created by saeng lin on 2020/02/06.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

import Kingfisher

class StartingRoomEndMemeberCollectionViewCell: BaseCollectionViewCell {
    
    static let registerID: String = "\(StartingRoomEndMemeberCollectionViewCell.self)"
    
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
        let btn = UIButton(frame: .zero)
        btn.isEnabled = false
        btn.setBackgroundImage(Const.requestMessageBtnImg, for: .normal)
        return btn
    }()
    
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
        static let requestMessageBtnImg: UIImage? = UIImage(named: "buttonNudgeDepress")
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
                                  sendMessageBtn)
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
    }
    
    func bind(name: String?, profileURLstring: String?, remindTime: Int, goHomeTime: Int, isMessage: Bool, userStatus: UserStatus) {
        nameLabel.text = name
        
        if let profileUrl = URL(string: profileURLstring ?? "") {
            profileImg.kf.setImage(with: profileUrl)
        }
        
        if remindTime > 0 {
            remindTimeLabel.text = "\(remindTime)분전 응답"
        } else {
            remindTimeLabel.text = ""
        }
        
        sendMessageBtn.isEnabled = isMessage
        
        if isMessage {
            sendMessageBtn.setBackgroundImage(Const.responseMessageBtnImg, for: .normal)
        } else {
            sendMessageBtn.setBackgroundImage(Const.requestMessageBtnImg, for: .normal)
        }
        
        switch userStatus {
        case .noneStart:
            memberStatusLabel.text = "귀가전"
            memberStatusLabel.textColor = VoAColor.Style.white
        case .starting:
            memberStatusLabel.text = "\(goHomeTime)분 후 도착"
            memberStatusLabel.textColor = VoAColor.Style.white
        case .end:
            memberStatusLabel.text = "귀가 완료"
            memberStatusLabel.textColor = VoAColor.Style.white
        case .past:
            memberStatusLabel.text = "귀가 예정 시간 지남"
            memberStatusLabel.textColor = VoAColor.StartingRoom.memberWarningStatusColor
        }
    }
}
