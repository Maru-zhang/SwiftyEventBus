//
//  EventSubscription.swift
//  SwiftyEventBus
//
//  Created by Maru on 2018/5/1.
//

import Foundation

public class EventSubscription<T> {

    /// The subscriber who is working
    public let entity: EventSubscriber<T>
    /// The EventBus that subscription holding
    public let eventBus: EventBus

    init(entity: EventSubscriber<T>, eventBus: EventBus) {
        self.entity = entity
        self.eventBus = eventBus
    }

    deinit {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        eventBus.observerHub.remove(entity)
    }
}
