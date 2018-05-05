//
//  EventSubscription.swift
//  SwiftyEventBus
//
//  Created by Maru on 2018/5/1.
//

import Foundation

public class EventSubscription<T: EventPresentable>{

    let entity: EventSubscriber<T>
    let eventBus: EventBus

    init(entity: EventSubscriber<T>, eventBus: EventBus) {
        self.entity = entity
        self.eventBus = eventBus
    }

    deinit {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        let identifier = T.processIdentifier
        if var set = eventBus.observers[identifier] as? Set<EventSubscriber<T>> {
            set.remove(entity)
            eventBus.observers[identifier] = set
        }
    }
}
