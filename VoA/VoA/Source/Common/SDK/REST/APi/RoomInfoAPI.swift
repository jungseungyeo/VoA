//
//  RoomIDsAPI.swift
//  VoA
//
//  Created by saeng lin on 2020/02/04.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import Foundation
import Alamofire

enum RoomInfoAPI {
    case getIDs(Int?)
    case getRoomInfo(Int)
    case goHomeTime(Int, Int, Int)
    case completeHome(Int, Int)
}

extension RoomInfoAPI: Networkerable {
    var route: (method: HTTPMethod, url: URL) {
        switch self {
        case .getIDs:
            return (.get, VoAService.shared.apiURL
                .appendingPathComponent(""))
        case .getRoomInfo:
            return (.get, VoAService.shared.apiURL
                .appendingPathComponent(""))
        case .goHomeTime:
            return (.put, VoAService.shared.apiURL
                .appendingPathComponent(""))
        case .completeHome:
            return (.post, VoAService.shared.apiURL
                .appendingPathComponent(""))
        }
    }
    
    var params: Parameters? {
        var params = Parameters()
        switch self {
        case .getIDs(let userID):
            params["userID"] = userID
        case .getRoomInfo(let roomID):
            params["roomID"] = roomID
        case .goHomeTime(let userID, let roomID, let limitTime):
            params["userID"] = userID
            params["roomID"] = roomID
            params["limitTime"] = limitTime
        case .completeHome(let userID, let roomID):
            params["userID"] = userID
            params["roomID"] = roomID
        }
        
        return params
    }
    
    var header: HTTPHeaders? {
        return nil
    }
    
    
}
