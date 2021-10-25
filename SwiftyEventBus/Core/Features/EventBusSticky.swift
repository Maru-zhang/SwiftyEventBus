//
//  EventBusSticky.swift
//  SwiftyEventBus
//
//  Created by Maru on 2018/7/31.
//

import Foundation

public typealias EventBusMiddle = EventBusPostable & EventBusObservable

public protocol EventBusSticky {
    var stick: EventBusMiddle { get }
}

extension EventBus: EventBusSticky {

    public var stick: EventBusMiddle {
        return EventBusPureMiddleWare(host: self, feautre: .sticky)
    }
}

extension EventBusMiddleWare: EventBusSticky {

    public var stick: EventBusMiddle {
        return EventBusPureMiddleWare(host: host, feautre: .sticky)
    }
}
