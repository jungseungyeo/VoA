//
//  RoomIDsModel.swift
//  VoA
//
//  Created by saeng lin on 2020/02/04.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import Foundation

import ObjectMapper

final class RoomIDsResponseModel: BaseResponseModel {
    
    public var data: RoomDataModel?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        data <- map["data"]
    }
}


final class RoomDataModel: BaseModel {
    
    public var roomDatas: [RoomIDModel]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        roomDatas <- map["roomDatas"]
    }
}

final class RoomIDModel: BaseModel {
    
    public var roomID: Int?
    public var roomTitle: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        roomID <- map["roomId"]
        roomTitle <- map["roomTitle"]
    }
}

