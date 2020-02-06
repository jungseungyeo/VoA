//
//  StartingHeaderView.swift
//  VoA
//
//  Created by saeng lin on 2020/02/05.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import Foundation

class StartingRoomHeaderView: BaseCollectionReusableView {
    
    static let registerID: String = "\(StartingRoomHeaderView.self)"
    
    lazy var myStatusDescriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = Const.myStatusDescriptionTitle
        return label
    }()
    
    lazy var myStatusLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = Const.myStatusTitle
        return label
    }()
    
    lazy var updateGoHomeTimeBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setBackgroundImage(UIImage(named: "icTime"), for: .normal)
        return btn
    }()
    
    lazy var startBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.contentMode = .scaleAspectFill
        
        return btn
    }()
    
    private struct Const {
        static let myStatusDescriptionForamt: String = "%@님의 귀가 상태"
        static let myStatusDescriptionTitle: NSAttributedString = .init(string: Const.myStatusDescriptionForamt,
                                                                        font: .systemFont(ofSize: 14,
                                                                                          weight: .regular),
                                                                        color: VoAColor.StartingRoom.headerMyStatusDescriptionColor)
        static let myStatusTitle: NSAttributedString = .init(string: "귀가전",
                                                             font: .systemFont(ofSize: 22,
                                                                               weight: .bold),
                                                             color: VoAColor.StartingRoom.headerMyStatusnColor)
        
        static let noneStartBtnImg: UIImage? = UIImage(named: "buttonHomecomingStart")
        static let startingBtnImg: UIImage? = UIImage(named: "buttonHomecomingEnd1")
        static let pastBtnImg: UIImage? = UIImage(named: "buttonHomecomingEnd2")
        
        static let startBntSize: CGSize = .init(width: 110, height: 51)
        
        static let topShadowSize: CGSize = .init(width: -3.0, height: -3.0)
        static let bottomShadowSize: CGSize = .init(width: 3.0, height: 3.0)
        static let shadowOpacity: Float = 1.0
        static let shadowRadius: CGFloat = 4.0
        
        static let myStatusDescriptionTopOffset: CGFloat = 33
        static let myStatusDescriptionLeftOffset: CGFloat = 16
        static let myStatusTopOffset: CGFloat = 5
        static let updateGoHomeTimeBtnLeftOffset: CGFloat = 8
        static let updateGoHomeTimeBtnSize: CGSize = .init(width: 18, height: 18)
        static let startBtnTopOffset: CGFloat = 35
        static let startBtnRightOffset: CGFloat = -15
        
        static let pastLeftGradient: UIColor = VoAColor.StartingRoom.pastStartBtnLeftColor
        static let pastRightGradient: UIColor = VoAColor.StartingRoom.pastStartBtnRigthColor
    }
    
    override func setup() {
        super.setup()
        backgroundColor = VoAColor.StartingRoom.navigationBackgroundColor
        
        addSubviews(myStatusDescriptionLabel,
                    myStatusLabel,
                    updateGoHomeTimeBtn,
                    startBtn)
        
        
    }
    
    override func setupUI() {
        super.setupUI()
        
        myStatusDescriptionLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(Const.myStatusDescriptionTopOffset)
            make.left.equalToSuperview().offset(Const.myStatusDescriptionLeftOffset)
        }
        
        myStatusLabel.snp.remakeConstraints { make in
            make.top.equalTo(myStatusDescriptionLabel.snp.bottom).offset(Const.myStatusTopOffset)
            make.left.equalTo(myStatusDescriptionLabel.snp.left)
        }
        
        updateGoHomeTimeBtn.snp.remakeConstraints { make in
            make.centerY.equalTo(myStatusLabel.snp.centerY)
            make.left.equalTo(myStatusLabel.snp.right).offset(Const.updateGoHomeTimeBtnLeftOffset)
            make.size.equalTo(Const.updateGoHomeTimeBtnSize)
        }
        
        startBtn.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(Const.startBtnTopOffset)
            make.right.equalToSuperview().offset(Const.startBtnRightOffset)
            make.size.equalTo(Const.startBntSize)
        }
    }
    
    func bind(myName: String?, myStatus: UserStatus?, remainingTime: Int?) {
        guard let status = myStatus else { return }
        myStatusDescriptionLabel.text = String.init(format: Const.myStatusDescriptionForamt, myName ?? "")
        switch status {
        case .noneStart:
            myStatusLabel.text = "귀가전"
            myStatusLabel.textColor = VoAColor.StartingRoom.headerMyStatusDescriptionColor
            startBtn.isHidden = false
            startBtn.setBackgroundImage(Const.noneStartBtnImg, for: .normal)
            updateGoHomeTimeBtn.isHidden = true
        case .starting:
            myStatusLabel.text = "\(remainingTime ?? 0)분 후 도착"
            myStatusLabel.textColor = VoAColor.StartingRoom.headerMyStatusDescriptionColor
            startBtn.isHidden = false
            startBtn.setBackgroundImage(Const.startingBtnImg, for: .normal)
            updateGoHomeTimeBtn.isHidden = false
        case .end:
            myStatusLabel.text = "귀가완료"
            myStatusLabel.textColor = VoAColor.Style.white
            startBtn.isHidden = true
            updateGoHomeTimeBtn.isHidden = true
        case .past:
            myStatusLabel.text = "귀가 예정시간 지남"
            myStatusLabel.textColor = VoAColor.StartingRoom.headerMyStatusDescriptionColor
            startBtn.isHidden = false
            startBtn.setBackgroundImage(Const.pastBtnImg, for: .normal)
            updateGoHomeTimeBtn.isHidden = false
        }
    }
}
