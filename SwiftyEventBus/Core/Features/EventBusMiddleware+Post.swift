//
//  EventBusMiddleware+EventBusPostable.swift
//  SwiftyEventBus
//
//  Created by Maru on 2018/8/1.
//

import Foundation

extension EventBusPureMiddleWare: EventBusPostable {

    public func post<T>(_ cargo: T) {
        if (support(.sticky)) {
            host.replayBuff.enqueue(cargo)
        }
        guard let queue = host.observerHub.findAll(T.self) else {
            return
        }
        performPost(with: queue, cargo: cargo)
    }
}

extension EventBusDangerMiddleWare: EventBusSafePostable {

    public func post<T>(_ cargo: T) throws {
        if (support(.sticky)) {
            host.replayBuff.enqueue(cargo)
        }
        guard let queue = host.observerHub.findAll(T.self) else {
            return
        }
        if (support(.safety) && queue.isEmpty) {
            throw EventBusPostError.useless
        }
    }
}
