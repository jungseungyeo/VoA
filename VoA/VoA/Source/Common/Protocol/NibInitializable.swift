//
//  NibInitializable.swift
//  VoA
//
//  Created by saeng lin on 2020/02/05.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

protocol NibInitializable {
}

extension NibInitializable where Self: UIView {
    static func initFromNib(owner: Any?, options: [UINib.OptionsKey: Any]?) -> Self? {
        return Bundle.main.loadNibNamed(String(describing: self), owner: owner, options: options)?.first as? Self
    }
    static func initFromNibWithoutOtherOptions() -> Self? {
        return initFromNib(owner: nil, options: nil)
    }
}

extension BaseView: NibInitializable {}

