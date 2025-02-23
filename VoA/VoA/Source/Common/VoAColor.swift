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
        static var background: UIColor = .init(r: 29, g: 30, b: 43, a: 1.0)
        static var white: UIColor = .white
    }
    
    struct Splash {
        static let logoTextColor: UIColor = .init(r: 229, g: 145, b: 76, a: 1.0)
        static let logoDescriptionTextColor: UIColor = .init(r: 255, g: 255, b: 255, a: 0.5)
    }
    
    struct Login {
        static let kakaoColor: UIColor = .init(r: 29, g: 30, b: 43, a: 1.0)
        static let topShadowColor: UIColor = .init(r: 48, g: 49, b: 68)
        static let bottomShadowColor: UIColor = .init(r: 15, g: 16, b: 21)
        static let kakaoTextColor: UIColor = .init(r: 34, g: 34, b: 34, a: 1.0)
    }
    
    struct LoinInfo {
        static let profileColor: UIColor = .init(r: 242, g: 218, b: 188)
        static let confirmColor: UIColor = .init(r: 255, g: 148, b: 59)
        static let notValidConfirmColor: UIColor = .init(r: 136, g: 136, b: 136)
    }
    
    struct AppleLoginAlert {
        static let leftGradient: UIColor = .init(r: 255, g: 198, b: 109)
        static let rightGradient: UIColor = .init(r: 255, g: 148, b: 59)
        static let cancelBackgroundColor: UIColor = .init(r: 136, g: 136, b: 136)
    }
    
    struct LeftMenu {
        static let headerTitelColor: UIColor = .init(r: 155, g: 159, b: 188)
    }
    
    struct Home {
        static let logoColor: UIColor = .init(r: 255, g: 161, b: 72)
    }
    
    struct ArriveHomeAlert {
        static let titleColor: UIColor = VoAColor.Style.white
        static let subTitleColor: UIColor = .init(r: 136, g: 136, b: 136)
    }
    
    struct CreateRoom {
        static let validNextBtnColor: UIColor = .init(r: 255, g: 148, b: 59)
        static let confirmColor: UIColor = VoAColor.LoinInfo.confirmColor
        static let inValidConfirmColor: UIColor = VoAColor.LoinInfo.notValidConfirmColor
    }
    
    struct StartingRoom {
        static let navigationBackgroundColor: UIColor = .init(r: 29, g: 30, b: 43)
        static let headerMyStatusDescriptionColor: UIColor = .init(r: 155, g: 159, b: 188)
        static let headerMyStatusnColor: UIColor = .init(r: 255, g: 177, b: 94)
        static let noneStartTitleColor: UIColor = .init(r: 155, g: 159, b: 188)
        static let startBtnTitleColor: UIColor = .init(r: 255, g: 177, b: 92)
        static let startBlurTopColor: UIColor = .init(r: 38, g: 40, b: 54)
        static let startBlurBottomColor: UIColor = .init(r: 15, g: 16, b: 21)
        static let pastStartBtnLeftColor: UIColor = .init(r: 255, g: 129, b: 109)
        static let pastStartBtnRigthColor: UIColor = .init(r: 255, g: 88, b: 59)
        static let startingMemeberContainerViewColor: UIColor = .init(r: 47, g: 49, b: 68)
        static let memberRemindTimeColor: UIColor = .init(r: 155, g: 159, b: 188)
        static let memberWarningStatusColor: UIColor = .init(r: 255, g: 90, b: 59)
    }
    
    struct ShowStartAlert {
        static let cancelBtnColor: UIColor = .init(r: 29, g: 30, b: 45)
        static let canclerBtnShadowColor: UIColor = .init(r: 15, g: 16, b: 21)
    }
}

extension UIColor {

    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }

}
