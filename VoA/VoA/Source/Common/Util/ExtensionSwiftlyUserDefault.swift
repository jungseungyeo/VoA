//
//  ExtensionSwiftlyUserDefault.swift
//  VoA
//
//  Created by saeng lin on 2020/01/30.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import SwiftlyUserDefault

enum UserDefeaultkey: SwiftlyUserDefaultable {
    case kakaoToken

    var key: String {
        switch self {
        case .kakaoToken: return "kakaoToken"
        }
    }
}

extension SwiftlyUserDefault {
    static var kakaoToken: String? {
        set { self.setValue(UserDefeaultkey.kakaoToken, value: newValue) }
        get { self.getValue(UserDefeaultkey.kakaoToken) }
    }
}
