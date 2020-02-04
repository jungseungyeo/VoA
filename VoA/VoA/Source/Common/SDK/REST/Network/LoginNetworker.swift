//
//  LoginNetworker.swift
//  VoA
//
//  Created by saeng lin on 2020/02/04.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import Alamofire
import RxSwift
import SwiftyJSON

class LoginNetworker: NSObject {
    static func sigin(model: KakaoPresentModel) -> Single<JSON> {
        let api = LoginAPI.sigin(model)
        return Networker.request(api: api)
    }
    
    static func sendFcm(userID: Int?, fcmToken: String?) -> Single<JSON> {
        let api = LoginAPI.fcm(userID, fcmToken)
        return Networker.request(api: api)
    }
}
