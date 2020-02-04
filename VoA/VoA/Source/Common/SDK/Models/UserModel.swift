//
//  UserModel.swift
//  VoA
//
//  Created by saeng lin on 2020/02/04.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import ObjectMapper

final class UserResponseModel: BaseResponseModel {
    
    public var data: UserModel?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        data <- map["data"]
    }
}

final class UserModel: BaseModel {
    
    public var userName: String?
    public var userID: Int?
    public var profileURL: String?
    public var authToken: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        userName <- map["userName"]
        userID <- map["userID"]
        profileURL <- map["profileURL"]
        authToken <- map["authoToken"]
    }
}
