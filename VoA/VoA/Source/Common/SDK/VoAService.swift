//
//  VoAService.swift
//  VoA
//
//  Created by Jung seoung Yeo on 2020/01/13.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import Alamofire

class VoAService: NSObject {
    
    private let appBuildVersion: String? = Bundle.main.object(forInfoDictionaryKey: (kCFBundleVersionKey as String)) as? String
    private let appShortVersion: String? = Bundle.main.object(forInfoDictionaryKey: ("CFBundleShortVersionString")) as? String

    public var commonHeader: [AnyHashable : Any] {
        var headers = [AnyHashable : Any]()
        headers[""] = ""
        return headers
    }
    
    public var restHeader: HTTPHeaders = {
        var headers = HTTPHeaders()
        headers["Content-Type"] = "application/json"
        headers["Authorization"] = "Bearer "
        headers["Platform"] = "iOS"
        return headers
    }()
    
    func addAccessToken(token: String?) {
        var headers = HTTPHeaders()
        headers["Content-Type"] = "application/json"
        headers["Authorization"] = "\(token ?? "")"
        headers["Platform"] = "iOS"
        headers["Version"] = "\(appShortVersion ?? "")"
        restHeader = headers
    }
    
    //http://localhost:4000
    ///api/user/login
    public var apiURL: URL {
        return URL(string: "http://15.165.171.251")!
    }

    public static let shared = VoAService()

    private override init() {
        super.init()
    }
}
