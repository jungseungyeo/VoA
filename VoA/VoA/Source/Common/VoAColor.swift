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
            return .init(r: 34,
                         g: 34,
                         b: 34,
                         a: 1.0)
        }
        
        static var white: UIColor {
            return .white
        }
        
    }
    
    struct Splash {
        static let logoTextColor: UIColor = .init(r: 229,
                                                  g: 145,
                                                  b: 76,
                                                  a: 1.0)
        
        static let logoDescriptionTextColor: UIColor = .init(r: 255,
                                                             g: 255,
                                                             b: 255,
                                                             a: 0.5)
    }
    
    struct Login {
        static let kakaoColor: UIColor = .init(r: 255,
                                               g: 222,
                                               b: 2,
                                               a: 1.0)
        
        static let kakaoTextColor: UIColor = .init(r: 34,
                                                   g: 34,
                                                   b: 34,
                                                   a: 1.0)
    }
    
    struct LoinInfo {
        static let profileColor: UIColor = .init(r: 242, g: 218, b: 188)
        static let confirmColor: UIColor = .init(r: 255, g: 148, b: 59)
        static let notValidConfirmColor: UIColor = .init(r: 136, g: 136, b: 136)
    }
}

extension UIColor {

    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }

}
