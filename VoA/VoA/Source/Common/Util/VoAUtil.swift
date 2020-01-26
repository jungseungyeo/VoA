//
//  VoAUtil.swift
//  VoA
//
//  Created by saeng lin on 2020/01/27.
//  Copyright © 2020 Linsaeng. All rights reserved.
//



class VoAUtil: NSObject {
    
    private struct Const {
        static let SESize: CGSize = .init(width: 320, height: 568)
    }
    
    public static var isiPhoneSE: Bool = UIScreen.main.bounds.size == Const.SESize
}
