//
//  UserViewModel.swift
//  VoA
//
//  Created by saeng lin on 2020/01/27.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import Foundation

class UserViewModel: NSObject {
    
    static let shared = UserViewModel()
    
    private override init() {
        super.init()
    }
    
    public var kakaoPresentModel: KakaoPresentModel? = nil
}
