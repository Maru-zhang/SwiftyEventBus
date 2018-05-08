//
//  EventBus+Rx.swift
//  SwiftyEventBus
//
//  Created by Maru on 2018/5/5.
//

import Foundation
import RxSwift

extension EventBus: ReactiveCompatible {}

public extension Reactive where Base: EventBus {

    /// Reactive wrapper for `register(on:)`
    public func register<T: EventPresentable>(_ type: T.Type) -> Observable<T> {
        return Observable<T>.create({ (observer) -> Disposable in
            return self.base.register(messageEvent: { (cargo) in
                observer.onNext(cargo)
            })
        })
    }
}
