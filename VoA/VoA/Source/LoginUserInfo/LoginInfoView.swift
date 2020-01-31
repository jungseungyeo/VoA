//
//  LoginInfoView.swift
//  VoA
//
//  Created by saeng lin on 2020/01/26.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

class LoginInfoView: BaseView {
    
    lazy var proImg: UIImageView = {
        let iv = UIImageView(image: UIImage())
        iv.backgroundColor = VoAColor.LoinInfo.profileColor
        iv.layer.cornerRadius = Const.profileSize.height / 2
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var nameDesription: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = Const.nameDesriptionText
        return label
    }()
    
    lazy var nameBorderView: UIView = {
        let borderView = UIView(frame: .zero)
        borderView.layer.borderColor = VoAColor.Style.white.withAlphaComponent(0.2).cgColor
        borderView.layer.borderWidth = 1
        borderView.layer.cornerRadius = 5
        return borderView
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.attributedPlaceholder = Const.nickNamePlaceHolderString
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.enablesReturnKeyAutomatically = true
        textField.textColor = VoAColor.Style.white
        return textField
    }()
    
    lazy var nicknameCount: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = Const.nickNameCount
        return label
    }()
    
    lazy var clearNickNameBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "icDelete"), for: .normal)
        btn.tintColor = VoAColor.Style.white.withAlphaComponent(0.2)
        return btn
    }()
    
    private struct Const {
        static let profileSize: CGSize = .init(width: 100, height: 100)
        static let nameDesriptionText: NSAttributedString = .init(string: "이름",
                                                                  font: .systemFont(ofSize: 16,
                                                                                    weight: .bold),
                                                                  color: VoAColor.Style.white)
        
        static let nickNameCount: NSAttributedString = .init(string: "0 / 10",
                                                             font: .systemFont(ofSize: 16,
                                                                               weight: .regular),
                                                             color: VoAColor.Style.white.withAlphaComponent(0.3))
        static let nickNamePlaceHolderString: NSAttributedString = .init(string: "린생",
                                                                         font: .systemFont(ofSize: 16,
                                                                                           weight: .regular),
                                                                         color: VoAColor.Style.white.withAlphaComponent(0.4))
        static let profileTopOffset: CGFloat = 52
        static let sideOffset: CGFloat = 30
        static let nameTopOffset: CGFloat = 28
        static let nameBorderTopOffset: CGFloat = 8
        static let nameBorderHeight: CGFloat = 50
        static let nameTextFieldSideOffset: CGFloat = 20
        static let clearBtnSize: CGFloat = 24
        static let clearBtnSideOffset: CGFloat = 10
    }
    
    private let const = Const()
    
    override func setup() {
        super.setup()
        
        addSubviews(proImg,
                    nameDesription,
                    nameBorderView,
                    nicknameCount)
        
        nameBorderView.addSubviews(nameTextField,
                                   clearNickNameBtn)
    }
    
    override func setupUI() {
        super.setupUI()
        
        proImg.snp.remakeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(Const.profileTopOffset)
            make.centerX.equalToSuperview()
            make.size.equalTo(Const.profileSize)
        }
        
        nameDesription.snp.remakeConstraints { make in
            make.left.equalToSuperview().inset(Const.sideOffset)
            make.top.equalTo(proImg.snp.bottom).offset(Const.nameTopOffset)
        }
        
        nameBorderView.snp.remakeConstraints { make in
            make.top.equalTo(nameDesription.snp.bottom).offset(Const.nameBorderTopOffset)
            make.left.equalTo(nameDesription.snp.left)
            make.right.equalToSuperview().inset(Const.sideOffset)
            make.height.equalTo(Const.nameBorderHeight)
        }
        
        nameTextField.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(Const.nameTextFieldSideOffset)
        }
        
        nicknameCount.snp.remakeConstraints { make in
            make.centerY.equalTo(nameDesription.snp.centerY)
            make.right.equalToSuperview().inset(Const.sideOffset)
        }
        
        clearNickNameBtn.snp.remakeConstraints { make in
            make.size.equalTo(Const.clearBtnSize)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(Const.clearBtnSideOffset)
        }
    }
}
