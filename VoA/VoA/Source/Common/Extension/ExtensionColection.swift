//
//  ExtensionColection.swift
//  VoA
//
//  Created by saeng lin on 2020/02/06.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

public extension Collection {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
