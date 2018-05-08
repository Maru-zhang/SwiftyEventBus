//
//  EventBus.swift
//  SwiftyEventBus
//
//  Created by Maru on 2018/4/30.
//

import Foundation

public typealias EventBinder<T: EventPresentable> = (Any, ((T) -> Void))

/// Default domain string for `EventBus`
private let defaultDomain = "com.eventbus.swifty.domain.default"

public class EventBus {

    /// The default common `EventBus` instance
    public static let `default` = EventBus(domain: defaultDomain)

    /// The domain string that identify different `EventBus` instance
    public let domain: String

    /// The Dictionary that contain all `EventSubscriber`
    /// Discuss: we use string of type as key, and a set of `EventSubscriber`
    /// as value. when register or unregister, we just need to modify corresponding
    /// set.
    var observers: [String: Any]

    /// The construction of `EventBus`
    ///
    /// - Parameter domain: The domain string
    public init(domain: String) {
        self.domain = domain
        self.observers = [String: Any]()
    }
}

extension EventBus: EventBusPostable {

    public func post<T: EventPresentable>(_ cargo: T) {
        let identifier = T.processIdentifier
        if let queue = observers[identifier] as? Set<EventSubscriber<T>> {
            for action in queue {
                let excuter = action.mode.excuter
                excuter.run(with: cargo, eventHandler: action.eventHandler)
            }
        }
    }
}

extension EventBus: EventBusObservable {

    public func register<T>(on mode: DispatchMode = .sync, messageEvent: @escaping (T) -> Void) -> EventSubscription<T> where T : EventPresentable {
        let identifier = T.processIdentifier
        let subscriber = EventSubscriber(mode: mode, eventHandler: messageEvent)
        let subscription = EventSubscription(entity: subscriber, eventBus: self)
        if var queue4T = observers[identifier] as? Set<EventSubscriber<T>> {
            queue4T.insert(subscriber)
            observers[identifier] = queue4T
        } else {
            observers[identifier] = Set<EventSubscriber<T>>(arrayLiteral: subscriber)
        }
        return subscription
    }
}
