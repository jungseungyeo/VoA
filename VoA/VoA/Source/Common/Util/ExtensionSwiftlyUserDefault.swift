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
    case nickName
    case profile
    
    case fcmToken

    var key: String {
        switch self {
        case .kakaoToken: return "kakaoToken"
        case .nickName: return "nickName"
        case .profile: return "profile"
        case .fcmToken: return "fcmToken"
        }
    }
}

extension SwiftlyUserDefault {
    static var kakaoToken: String? {
        set { self.setValue(UserDefeaultkey.kakaoToken, value: newValue) }
        get { self.getValue(UserDefeaultkey.kakaoToken) }
    }
    
    static var nickName: String? {
        set { self.setValue(UserDefeaultkey.nickName, value: newValue) }
        get { self.getValue(UserDefeaultkey.nickName) }
    }
    
    static var profile: String? {
        set { self.setValue(UserDefeaultkey.profile, value: newValue) }
        get { self.getValue(UserDefeaultkey.profile) }
    }
    
    static var fcmToken: String? {
        set { self.setValue(UserDefeaultkey.fcmToken, value: newValue) }
        get { self.getValue(UserDefeaultkey.fcmToken) }
    }
}
