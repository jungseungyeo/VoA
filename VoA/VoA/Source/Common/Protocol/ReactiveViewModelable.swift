//
//  ReactiveViewModelable.swift
//  VoA
//
//  Created by saenglin on 2019/12/30.
//  Copyright © 2019 linsaeng. All rights reserved.
//

import Foundation

protocol ReactiveViewModelable {
    associatedtype InputType
    associatedtype OutputType
    
    var input: InputType { set get }
    var output: OutputType { get }
}
