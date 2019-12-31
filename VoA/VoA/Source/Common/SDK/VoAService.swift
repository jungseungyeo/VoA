//
//  VoAService.swift
//  VoA
//
//  Created by saenglin on 2019/12/31.
//  Copyright © 2019 linsaeng. All rights reserved.
//

import Foundation

import Alamofire

final public class VoAService: NSObject {

    public var commonHeader: HTTPHeaders {
        let headers = HTTPHeaders()
        return headers
    }

    private var apiHost: String {
        return ""
    }

    public var apiURL: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = apiHost
        return components.url!
    }

    public static let shared = VoAService()

    private override init() {
        super.init()
    }
}
