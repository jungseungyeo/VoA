//
//  VoAError.swift
//  VoA
//
//  Created by saenglin on 2019/12/31.
//  Copyright © 2019 linsaeng. All rights reserved.
//

import Foundation

enum VoAError: Int, Error, CustomStringConvertible {
    
    //Bad Request
    case common400 = 400
    //Unauthorized
    case coomon401 = 401
    // Not Found
    case common404 = 404
    
    // Internal Server Error
    case common500 = 500
    // Service Unavailable
    case common503 = 503
    
    // 마이너스 에러 - 네이티브 에러 - 내가 만든 Error Code
    // 데이타 set 실패
    case dataParsing996 = -996
    // JSON 파싱 실패
    case jsonParsing997 = -997
    // url 파싱 실패
    case urlParsing998 = -998
    
    case unknown = -999
    
    var description: String {
        switch self {
        case .unknown:
            return "알 수 없는 에러"
        case .common400,
             .coomon401,
             .common404:
            return "인터넷을 연결 할 수 없습니다."
        case .common500,
             .common503:
            return "서버가 불안정 합니다."
        case .dataParsing996:
            return "테이타 파싱 샐패"
        case .jsonParsing997:
            return "JSON 파싱 실패"
        case .urlParsing998:
            return "url 파싱 실패"
        }
    }
    
    var code: Int {
        return self.rawValue
    }
}
