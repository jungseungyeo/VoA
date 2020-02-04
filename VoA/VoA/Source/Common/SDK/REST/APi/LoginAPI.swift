//
//  LoginAPI.swift
//  VoA
//
//  Created by saeng lin on 2020/02/04.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import Alamofire

enum LoginAPI {
    case sigin(KakaoPresentModel)
    case fcm(Int?, String?)
}

extension LoginAPI: Networkerable {
    var route: (method: HTTPMethod, url: URL) {
        switch self {
        case .sigin:
            return (.post, VoAService.shared.apiURL
                .appendingPathComponent(""))
        case .fcm:
            return (.post, VoAService.shared.apiURL
                .appendingPathComponent(""))
        }
    }
    
    var params: Parameters? {
        var params = Parameters()
        switch self {
        case .sigin(let model):
            params["kakaoToken"] = model.kakaoAccountToken ?? ""
            params["userName"] = model.nickName ?? ""
            params["profileURL"] = model.profileURL?.absoluteString ?? ""
            params["isAppUser"] = true
        case .fcm(let userID, let fcmToken):
            if let userID = userID {
                params["userID"] = userID
            }
            if let fcmToken = fcmToken {
                params["fcmToken"] = fcmToken
            }
        }
        
        return params
    }
    
    var header: HTTPHeaders? { return nil }
}
