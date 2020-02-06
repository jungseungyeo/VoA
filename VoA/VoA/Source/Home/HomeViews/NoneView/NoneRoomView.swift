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
    
    @IBOutlet weak var createRoomBtn: UIButton!
    
    weak var delegate: NoneRoomViewable?
    
    static func instanceFromNib() -> NoneRoomView? {
        let noneRoomView = NoneRoomView.initFromNibWithoutOtherOptions()
        return noneRoomView
    }
    
    private struct Const {
        static let createRoomString: NSAttributedString = .init(string: "귀가방 만들기",
                                                                font: .systemFont(ofSize: 18,
                                                                                  weight: .bold),
                                                                color: VoAColor.Style.white)
        
        static let leftGradient: UIColor = VoAColor.AppleLoginAlert.leftGradient
        static let rightGradient: UIColor = VoAColor.AppleLoginAlert.rightGradient
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCreateRoomBtn()
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
