//
//  EventSubscription+Rx.swift
//  SwiftyEventBus
//
//  Created by Maru on 2018/5/5.
//

import Foundation
import RxSwift

extension EventSubscription: Disposable {

    public func dispose() {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        let identifier = EventID(T.self)
        if var set = eventBus.observers[identifier] as? Set<EventSubscriber<T>> {
            set.remove(entity)
            eventBus.observers[identifier] = set
        }
    }
}
