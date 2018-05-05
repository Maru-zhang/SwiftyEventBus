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

    public static let `default` = EventBus(domain: defaultDomain)

    public let domain: String

    var observers: [String: Any]

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
                action.eventHandler(cargo)
            }
        }
    }
}

extension EventBus: EventBusObservable {

    public func register<T>(on messageEvent: @escaping (T) -> Void) -> EventSubscription<T> where T : EventPresentable {
        let identifier = T.processIdentifier
        let subscriber = EventSubscriber(eventHandler: messageEvent)
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
