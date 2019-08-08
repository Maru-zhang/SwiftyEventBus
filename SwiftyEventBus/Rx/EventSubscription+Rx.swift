//
//  EventSubscription+Rx.swift
//  SwiftyEventBus
//
//  Created by Maru on 2018/5/5.
//

import Foundation
import RxSwift
import SwiftyEventBus

extension EventSubscription: Disposable {

    public func dispose() {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        eventBus.observerHub.remove(entity)
    }
}
