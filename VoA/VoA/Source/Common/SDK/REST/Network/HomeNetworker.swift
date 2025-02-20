//
//  HomeNetworker.swift
//  VoA
//
//  Created by saeng lin on 2020/02/04.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import Alamofire
import RxSwift
import SwiftyJSON

class HomeNetworker: NSObject {
    static func getRoomID(userID: Int?) -> Single<APIResult> {
        let api = RoomInfoAPI.getIDs(userID)
        return Networker.request(api: api)
    }
    
    static func makeRoom(roomTitle: String?) -> Single<APIResult> {
        let api = RoomInfoAPI.makeRoom(UserViewModel.shared.userModel?.userID, roomTitle)
        return Networker.request(api: api)
    }
    
    static func getRommInfo(roomID: Int) -> Single<APIResult> {
        let api = RoomInfoAPI.getRoomInfo(roomID)
        return Networker.request(api: api)
    }
    
    static func startGoHomeTime(userID: Int, roomID: Int, limitTime: Int) -> Single<APIResult> {
        let api = RoomInfoAPI.goHomeTime(userID, roomID, limitTime)
        return Networker.request(api: api)
    }
    
    static func completeGoHome(userID: Int, roomID: Int) -> Single<APIResult> {
        let api = RoomInfoAPI.completeHome(userID, roomID)
        return Networker.request(api: api)
    }
}
