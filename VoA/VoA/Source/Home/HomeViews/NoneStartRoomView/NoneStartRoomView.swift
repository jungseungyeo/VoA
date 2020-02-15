//
//  NoneStartRoomView.swift
//  VoA
//
//  Created by linsaeng on 2020/02/15.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import Foundation

class NoneStartRoomView: BaseView {
    
    lazy var logoImg: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "bitmap2"))
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = Const.titleString
        return label
    }()
    
    lazy var subTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.attributedText = Const.subTitleString
        return label
    }()
    
    lazy var linkBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setAttributedTitle(Const.bntTitle, for: .normal)
        btn.layer.cornerRadius = 55 / 2
        btn.backgroundColor = .init(r: 255, g: 177, b: 94)
        return btn
    }()
    
    struct Const {
        static let titleString: NSAttributedString = .init(string: "친구에게 초대장을 보내세요",
                                                           font: .systemFont(ofSize: 22,
                                                                             weight: .bold),
                                                           color: VoAColor.Style.white)
        static let subTitleString: NSAttributedString = .init(string: "귀가 사오항을 공유할 친구를 초대해주세요",
                                                              font: .systemFont(ofSize: 14,
                                                                                weight: .regular),
                                                              color: .init(r: 155, g: 159, b: 188))
        static let bntTitle: NSAttributedString = .init(string: "카카오톡으로 초대 링크 보내기",
                                                        font: .systemFont(ofSize: 18,
                                                                          weight: .bold),
                                                        color: VoAColor.Style.white)
    }
    
    override func setup() {
        super.setup()
        
        addSubviews(logoImg,
                    title,
                    subTitle,
                    linkBtn)

    }

    override func setupUI() {
        super.setupUI()
        
        logoImg.snp.remakeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(50)
            make.centerX.equalToSuperview()
            make.size.equalTo(220)
        }
        
        title.snp.remakeConstraints { make in
            make.top.equalTo(logoImg.snp.bottom).offset(35)
            make.centerX.equalToSuperview()
        }
        
        subTitle.snp.remakeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(9)
            make.centerX.equalToSuperview()
        }
        
        linkBtn.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-147)
            make.height.equalTo(55)
        }
    }
    
}
