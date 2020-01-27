//
//  HomeViewModel.swift
//  VoA
//
//  Created by saeng lin on 2020/01/27.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import RxSwift
import RxCocoa

class HomeViewModel: NSObject, ReactiveViewModelable {
    
    typealias InputType = Input
    typealias OutputType = Output
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    public lazy var input: InputType = Input()
    public lazy var output: OutputType = Output()
}
