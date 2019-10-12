//
//  EventBusPriorityTests.swift
//  SwiftyEventBusTests
//
//  Created by Maru on 2018/5/28.
//  Copyright © 2018 souche. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import SwiftyEventBus

class EventBusBox {
    var box: [Any] = []
    func clear() {
        box.removeAll()
    }
}

extension EventSubscription {

    func release(by box: EventBusBox) {
        box.box.append(self)
    }
}

class EventBusPriorityTests: QuickSpec {

    var box = EventBusBox()

    let bus = EventBus(domain: "com.souche.maru.priority")

    override func spec() {
        describe("EventBus Priority Tests Spec") {
            describe("build-in enum usage", {
                it("high receive message first then default, low reveive message finally", closure: {
                    waitUntil(action: { (done) in
                        var lowFlag = false
                        var defaultFlag = false
                        var highFlag = false
                        let group = DispatchGroup()
                        let queue = DispatchQueue.global(qos: .utility)
                        group.enter()
                        queue.sync(execute: {
                            self.bus.register(priority: .low, messageEvent: { (x: String) in
                                expect(x).to(equal("foo"))
                                expect(lowFlag).to(equal(false))
                                expect(defaultFlag).to(equal(false))
                                expect(highFlag).to(equal(false))
                                lowFlag = true
                                group.leave()
                            }).release(by: self.box)
                        })
                        group.enter()
                        queue.sync {
                            self.bus.register(priority: .`default`, messageEvent: { (x: String) in
                                expect(x).to(equal("foo"))
                                expect(lowFlag).to(equal(true))
                                expect(defaultFlag).to(equal(false))
                                expect(highFlag).to(equal(false))
                                defaultFlag = true
                                group.leave()
                            }).release(by: self.box)
                        }
                        group.enter()
                        queue.sync {
                            self.bus.register(priority: .high, messageEvent: { (x: String) in
                                expect(x).to(equal("foo"))
                                expect(lowFlag).to(equal(true))
                                expect(defaultFlag).to(equal(true))
                                expect(highFlag).to(equal(false))
                                highFlag = true
                                group.leave()
                            }).release(by: self.box)
                        }
                        self.bus.post("foo")
                        group.notify(qos: .default, flags: .inheritQoS, queue: DispatchQueue.main, execute: {
                            expect(lowFlag).to(equal(true))
                            expect(defaultFlag).to(equal(true))
                            expect(highFlag).to(equal(true))
                            done()
                            self.box.clear()
                        })
                    })
                })
            })
        }
    }
}
