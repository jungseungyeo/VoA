//
//  RoomInfoModel.swift
//  VoA
//
//  Created by saeng lin on 2020/02/05.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import ObjectMapper

public enum UserStatus: String {
    case noneStart
    case starting
    case end
    case past
}

final public class RoomInfoRespnseModel: BaseResponseModel {
    
    public private(set) var data: RoomInfoModel?
    
    override public func mapping(map: Map) {
        super.mapping(map: map)
        
        data <- map["data"]
    }
}

final public class RoomInfoModel: BaseModel {
    
    public private(set) var roomID: Int?
    public private(set) var roomTItle: String?
    public private(set) var participants: [Participant]?
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        
        roomID <- map["roomID"]
        roomTItle <- map["roomTItle"]
        participants <- map["participants"]
    }
    
}

final public class Participant: BaseModel {
    
    public private(set) var userID: Int?
    public private(set) var userName: String?
    public private(set) var userStatus: UserStatus?
    public private(set) var userProfileURL: String?
    
    public private(set) var elapsedTime: Int?
    public private(set) var totalTime: Int?
    public private(set) var responseTime: Int?
    public private(set) var isMessage: Bool = false
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        
        userID <- map["userID"]
        userName <- map["userName"]
        userStatus <- (map["userStatus"], EnumTransform())
        userProfileURL <- map["userProfileURL"]
        elapsedTime <- map["elapsedTime"]
        totalTime <- map["totalTime"]
        responseTime <- map["responseTime"]
        isMessage <- map["isMessage"]
    }
}
