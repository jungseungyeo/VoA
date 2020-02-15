//
//  NoneHome.swift
//  VoA
//
//  Created by saeng lin on 2020/02/05.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import Foundation

protocol NoneRoomViewable: class {
    func createBtnTapped()
}

class NoneRoomView: BaseView {
    
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    @IBOutlet weak var createRoomBtn: UIButton!
    
    weak var delegate: NoneRoomViewable?
    
    static func instanceFromNib() -> NoneRoomView? {
        let noneRoomView = NoneRoomView.initFromNibWithoutOtherOptions()
        return noneRoomView
    }
    
    private struct Const {
        static let createRoomString: NSAttributedString = .init(string: "새로운 귀가방 만들기",
                                                                font: .systemFont(ofSize: 18,
                                                                                  weight: .bold),
                                                                color: VoAColor.Style.white)
        
        static let leftGradient: UIColor = VoAColor.AppleLoginAlert.leftGradient
        static let rightGradient: UIColor = VoAColor.AppleLoginAlert.rightGradient
        
        static let titleString: NSAttributedString = .init(string: "참여중인 귀가방이 없습니다",
                                                           font: .systemFont(ofSize: 18,
                                                                             weight: .bold),
                                                           color: VoAColor.Style.white)
        static let subTitleString: NSAttributedString = .init(string: "귀가방을 만들어서 친구들을 초대해보세요.\n친구들의 귀갓길 이젠 걱정하지 마세요",
                                                           font: .systemFont(ofSize: 14,
                                                                             weight: .regular),
                                                           color: .init(r: 155, g: 159, b: 188))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCreateRoomBtn()
        
        title.attributedText = Const.titleString
        subTitle.attributedText = Const.subTitleString
    }
    
    private func setupCreateRoomBtn() {
        createRoomBtn.setWidthGradient(colorLeft: Const.leftGradient, colorRight: Const.rightGradient)
        createRoomBtn.layer.cornerRadius = 60 / 2
        createRoomBtn.clipsToBounds = true
        createRoomBtn.setAttributedTitle(Const.createRoomString, for: .normal)
        createRoomBtn.addTarget(self, action: #selector(createBtnTapped), for: .touchUpInside)
    }
}

private extension NoneRoomView {
    @objc
    private func createBtnTapped() {
        delegate?.createBtnTapped()
    }
}
