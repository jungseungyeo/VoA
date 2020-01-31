//
//  CreateRoomView.swift
//  VoA
//
//  Created by saeng lin on 2020/01/30.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

class CreateRoomView: BaseView {
    
    lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = Const.titleString
        return label
    }()
    
    lazy var countRoomTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = Const.countRoomTitleString
        return label
    }()
    
    lazy var roomTitleBorderView: UIView = {
        let borderView = UIView(frame: .zero)
        borderView.layer.borderColor = VoAColor.Style.white.withAlphaComponent(0.2).cgColor
        borderView.layer.borderWidth = 1
        borderView.layer.cornerRadius = 5
        return borderView
    }()
    
    lazy var roomTitleTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.textColor = VoAColor.Style.white
        textField.attributedPlaceholder = Const.roomtTitlePlaceHolderString
        textField.enablesReturnKeyAutomatically = true
        textField.placeholder = "\(currentDateString) 귀가방"
        return textField
    }()
    
    lazy var clearRoomTitleBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "icDelete"), for: .normal)
        btn.tintColor = VoAColor.Style.white.withAlphaComponent(0.2)
        btn.isHidden = true
        return btn
    }()
    
    private lazy var currentDateString: String = {
        let nowDate = Date()
        let dateForamtString = DateFormatter()
        dateForamtString.dateFormat = "YYYY.MM.dd"
        return dateForamtString.string(from: nowDate)
    }()
    
    private struct Const {
        static let titleString: NSAttributedString = .init(string: "귀가방 이름을 입력해주세요.",
                                                           font: .systemFont(ofSize: 18,
                                                                             weight: .bold),
                                                           color: VoAColor.Style.white)
        static let countRoomTitleString: NSAttributedString = .init(string: "0 / 20",
                                                                    font: .systemFont(ofSize: 18),
                                                                    color: VoAColor.Style.white.withAlphaComponent(0.3))
        static let roomtTitlePlaceHolderString: NSAttributedString = .init(string: "2020.02.08 귀가방",
                                                                           font: .systemFont(ofSize: 16,
                                                                                             weight: .regular),
                                                                           color: VoAColor.Style.white.withAlphaComponent(0.4))
        
        static let titleTopOffset: CGFloat = 50
        static let titleLeftOffset: CGFloat = 16
        static let boarderTopOffset: CGFloat = 16
        static let boarderHeight: CGFloat = 50
        static let roomTitleBorderSideOffset: CGFloat = 16
        static let clearRoomtBtnSize: CGSize = .init(width: 24, height: 24)
    }
    
    private let const = Const()
    
    override func setup() {
        super.setup()
        
        addSubviews(title,
                    countRoomTitle,
                    roomTitleBorderView)
        
        roomTitleBorderView.addSubviews(roomTitleTextField,
                                        clearRoomTitleBtn)
    }
    
    override func setupUI() {
        super.setupUI()
        
        title.snp.remakeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(Const.titleTopOffset)
            make.left.equalToSuperview().offset(Const.titleLeftOffset)
        }
        
        countRoomTitle.snp.remakeConstraints { make in
            make.centerY.equalTo(title.snp.centerY)
            make.right.equalToSuperview().offset(-Const.titleLeftOffset)
        }
        
        roomTitleBorderView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(Const.boarderTopOffset)
            make.left.equalTo(title.snp.left)
            make.right.equalTo(countRoomTitle.snp.right)
            make.height.equalTo(Const.boarderHeight)
        }
        
        roomTitleTextField.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(Const.roomTitleBorderSideOffset)
        }
        
        clearRoomTitleBtn.snp.remakeConstraints { make in
            make.size.equalTo(Const.clearRoomtBtnSize)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(Const.roomTitleBorderSideOffset)
        }
    }
}
