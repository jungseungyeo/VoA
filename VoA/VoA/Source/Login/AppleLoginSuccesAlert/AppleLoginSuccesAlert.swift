//
//  AppleLoginSuccesAlert.swift
//  VoA
//
//  Created by saeng lin on 2020/01/27.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

protocol AppleLoginSuccesAlertable: class {
    func confirmTapped()
    func cancelTapped()
}

class AppleLoginSuccesAlert: BaseViewController {
    
    static func instance() -> AppleLoginSuccesAlert {
        return AppleLoginSuccesAlert(nibName: "AppleLoginSuccesAlert", bundle: nil)
    }
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var kakaoAccountBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    weak var delegate: AppleLoginSuccesAlertable?
    
    private struct Const {
        static let descrtionString: NSAttributedString = .init(string: "친구목록을 불러오기 위해서는\n카카오 계정이 필요합니다.\n계속하시겠어요?", font: .systemFont(ofSize: 14,
                                                                                                                                                                                                    weight: .bold), color: VoAColor.LoinInfo.notValidConfirmColor)
        static let kakaoAccountString: NSAttributedString = .init(string: "카카오 계정 연동하기",
                                                                  font: .systemFont(ofSize: 18,
                                                                                    weight: .bold), color: VoAColor.Style.white)
        static let leftGradient: UIColor = VoAColor.AppleLoginAlert.leftGradient
        static let rightGradient: UIColor = VoAColor.AppleLoginAlert.rightGradient
        static let cancelBackgroundColor: UIColor = VoAColor.AppleLoginAlert.cancelBackgroundColor
        static let cancelString: NSAttributedString = .init(string: "돌아가기",
                                                            font: .systemFont(ofSize: 18,
                                                                              weight: .bold),
                                                            color: VoAColor.Style.white)
    }
    
    private let const = Const()
    
    override func setup() {
        super.setup()
        containerView.layer.cornerRadius = 5
        descriptionLabel.attributedText = Const.descrtionString
        setupKakaoBtn()
        setupCancelBtn()
    }
    
    private func setupKakaoBtn() {
        kakaoAccountBtn.setAttributedTitle(Const.kakaoAccountString, for: .normal)
        kakaoAccountBtn.setWidthGradient(colorLeft: Const.leftGradient, colorRight: Const.rightGradient)
        kakaoAccountBtn.layer.cornerRadius = 55 / 2
        kakaoAccountBtn.clipsToBounds = true
        
        kakaoAccountBtn.addTarget(self, action: #selector(kakaoAccountBtnTapped), for: .touchUpInside)
    }
    
    private func setupCancelBtn() {
        cancelBtn.backgroundColor = Const.cancelBackgroundColor
        cancelBtn.setAttributedTitle(Const.cancelString, for: .normal)
        cancelBtn.layer.cornerRadius = 55 / 2
        cancelBtn.addTarget(self, action: #selector(cancelBtnTapped), for: .touchUpInside)
    }
    
    @objc
    private func kakaoAccountBtnTapped() {
        delegate?.confirmTapped()
    }
    
    @objc
    private func cancelBtnTapped() {
        delegate?.cancelTapped()
        self.dismiss(animated: false, completion: nil)
    }
}
