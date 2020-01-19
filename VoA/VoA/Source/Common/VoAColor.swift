//
//  VoAColor.swift
//  VoA
//
//  Created by Jung seoung Yeo on 2020/01/11.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

class VoAColor: NSObject {
    
    struct Style {
        
        static var background: UIColor {
            if #available(iOS 13, *) {
                return .systemBackground
            }
            return .white
        }
        
    }
}

extension UIColor {

    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }

    struct Home {
        static let black = UIColor(r: 51, g: 51, b: 51)
        static let blue = UIColor(r: 95, g: 108, b: 204)
        static let pink = UIColor(r: 179, g: 118, b: 135)

        static let bgBlue = UIColor(r: 242, g: 243, b: 251)
        static let bgPink = UIColor(r: 241, g: 237, b: 238)

        static let bgGray = UIColor(r: 247, g: 247, b: 247)
        static let textGray = UIColor(r: 170, g: 170, b: 170)
    }

    struct Steps {
        static let placeHolder = UIColor(r: 170, g: 170, b: 170)
    }

}
