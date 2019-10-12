//
//  EventBusPureMiddleWare+Observer.swift
//  SwiftyEventBus
//
//  Created by Maru on 2018/8/1.
//  Copyright © 2018 Alloc. All rights reserved.
//

import Foundation

extension EventBusMiddleWare: EventBusObservable {

    public func register<T>(on mode: DispatchMode = .same, priority: EventBusPriority = .`default`, messageEvent: @escaping (T) -> Void) -> EventSubscription<T> {
        let subscriber = EventSubscriber(mode: mode, priority: priority, eventHandler: messageEvent)
        let subscription = EventSubscription(entity: subscriber, eventBus: host)
        if (support(.sticky)) {
            if let previousCargo: T = host.replayBuff.dequeue() {
                messageEvent(previousCargo)
            }
        }
        host.observerHub.add(subscriber)
        return subscription
    }
}
