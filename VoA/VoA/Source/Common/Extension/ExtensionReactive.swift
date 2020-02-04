//
//  ExtensionReactive.swift
//  VoA
//
//  Created by saeng lin on 2020/02/04.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import RxSwift
import RxCocoa

extension ObservableType {
    func observeOnMainScheduler() -> Observable<Element> {
        return self.observeOn(MainScheduler.instance)
    }
    
    func observeOnConcurrentQueue(qos: DispatchQoS = .background) -> Observable<Element> {
        return self.observeOn(ConcurrentDispatchQueueScheduler(qos: qos))
    }
    
    func threading(with qos: DispatchQoS) -> Observable<Element> {
        return self.subscribeOn(ConcurrentDispatchQueueScheduler(qos: qos))
            .observeOn(ConcurrentDispatchQueueScheduler(qos: qos))
    }
    
    func threadingForMain(with qos: DispatchQoS = .utility) -> Observable<Element> {
        return self.subscribeOn(ConcurrentDispatchQueueScheduler(qos: qos))
            .observeOn(MainScheduler.instance)
    }
    
//    func force<T>(type: T.Type, value: T) -> Observable<T> {
//        return self.map { _ -> T? in return nil } // for type annotation
//            .replaceNilWith(value)
//    }
    
    func flatMap<A: AnyObject, O: ObservableType>(weak obj: A, selector: @escaping (A, Self.Element) throws -> O) -> Observable<O.Element> {
        return flatMap { [weak obj] value -> Observable<O.Element> in
            try obj.map { try selector($0, value).asObservable() } ?? .empty()
        }
    }

    func flatMapLatest<A: AnyObject, O: ObservableType>(weak obj: A, selector: @escaping (A, Self.Element) throws -> O) -> Observable<O.Element> {
        return flatMapLatest { [weak obj] value -> Observable<O.Element> in
            try obj.map { try selector($0, value).asObservable() } ?? .empty()
        }
    }
}

extension PrimitiveSequenceType where Trait == SingleTrait {
    
    func observeOnMainScheduler() -> PrimitiveSequence<Trait, Element> {
        return self.primitiveSequence.observeOn(MainScheduler.instance)
    }
    
    func observeOnConcurrentQueue(qos: DispatchQoS = .background) -> PrimitiveSequence<Trait, Element> {
        return self.primitiveSequence.observeOn(ConcurrentDispatchQueueScheduler(qos: qos))
    }
    
    func threading(with qos: DispatchQoS) -> PrimitiveSequence<Trait, Element> {
        return self.primitiveSequence.subscribeOn(ConcurrentDispatchQueueScheduler(qos: qos))
            .observeOn(ConcurrentDispatchQueueScheduler(qos: qos))
    }
    
    func threadingForMain(with qos: DispatchQoS = .utility) -> PrimitiveSequence<Trait, Element> {
        return self.primitiveSequence.subscribeOn(ConcurrentDispatchQueueScheduler(qos: qos))
            .observeOn(MainScheduler.instance)
    }
}
