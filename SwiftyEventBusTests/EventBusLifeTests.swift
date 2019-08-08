//
//  EventBusLifeTests.swift
//  SwiftyEventBusTests
//
//  Created by Maru on 2019/8/8.
//  Copyright © 2019 Alloc. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import SwiftyEventBus

class EventBusLifeTests: QuickSpec {

    override func spec() {
        describe("EventBus Life Spec") {
            it("will dispose after EventSubscription deinit", closure: {
                let bag: EventSubscription<String>? = EventBus.default.register(messageEvent: { (x: String) in
                    expect(x).to(equal("life"))
                })
                bag?.dispose()
                let observers = EventBus.default.observerHub.findAll(String.self)
                expect(observers).to(beNil())
            })
        }
    }
}
