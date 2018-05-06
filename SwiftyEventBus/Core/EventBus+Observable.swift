//
//  EventBus+Observable.swift
//  SwiftyEventBus
//
//  Created by Maru on 2018/4/30.
//

import Foundation

public protocol EventBusObservable {

    /// Register a message event for specify DataStruct
    ///
    /// - Parameter messageEvent: a closure that use `T` as only param
    /// - Returns: A instance of `EventSubscription`, that hold the subscriber
    mutating func register<T: EventPresentable>(on messageEvent: @escaping (T) -> Void) -> EventSubscription<T>
}
