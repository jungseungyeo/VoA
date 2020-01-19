//
//  ExtensionNSAttributedString.swift
//  VoA
//
//  Created by Jung seoung Yeo on 2020/01/18.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import Foundation

extension NSAttributedString {
    convenience init(string: String, font: UIFont, color: UIColor) {
        self.init(string: string, attributes: [ NSAttributedString.Key.font: font,
                                                NSAttributedString.Key.foregroundColor: color])
    }
}
