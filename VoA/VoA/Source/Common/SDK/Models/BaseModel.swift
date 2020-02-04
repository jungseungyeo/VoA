//
//  UserModel.swift
//  VoA
//
//  Created by saeng lin on 2020/02/04.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import Foundation
import ObjectMapper

public class BaseResponseModel: NSObject, Mappable {
    
    public var status: Int?
    public var message: String?
    
    public required init?(map: Map) {}
    
    override init() {
        super.init()
    }
    
    public func mapping(map: Map) {
        self.status <- map["status"]
        self.message <- map["message"]
    }
}

public class BaseModel: NSObject, Mappable {
    
    public required init?(map: Map) { }
    
    public func mapping(map: Map) { }
}
