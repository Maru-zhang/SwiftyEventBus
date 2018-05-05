//
//  EventBus+Observable.swift
//  SwiftyEventBus
//
//  Created by Maru on 2018/4/30.
//

import Foundation

public protocol EventBusObservable {
    mutating func register<T: EventPresentable>(on messageEvent: @escaping (T) -> Void) -> EventSubscription<T>
}
