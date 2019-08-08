//
//  EventBusTests.swift
//  SwiftyEventBus_Example
//
//  Created by Maru on 2018/5/5.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftyEventBus

let concurrentQueue = DispatchQueue(label: "com.eventbus.test.concurrent", attributes: .concurrent)

class EventBusTests: QuickSpec {

    var stringBag: EventSubscription<String>?
    var stringBGBag: EventSubscription<String>?
    var intBag: EventSubscription<Int>?

    let bag = EventBusBox()

    override func spec() {
        describe("A default eventbus") {
            describe("post string value", {
                it("get string message event", closure: {
                    waitUntil(action: { (done) in
                        self.stringBag = EventBus.default.register(messageEvent: { (x: String) in
                            expect(x).to(equal("foo"))
                            done()
                        })
                        EventBus.default.post("foo")
                    })
                })
                it("get two string message event", closure: {
                    var count = 0
                    waitUntil(action: { (done) in
                        self.stringBag = EventBus.default.register(messageEvent: { (_) in
                            count += 1
                            if (count == 2) {
                                done()
                            }
                        })
                        EventBus.default.post("foo")
                        EventBus.default.post("foo")
                    })
                })
                describe("register via concurrent queue", {
                    it("get two string message event", closure: {
                        waitUntil(action: { (done) in
                            let semaphore = DispatchSemaphore(value: 1)
                            concurrentQueue.async {
                                semaphore.wait()
                                self.stringBag = EventBus.default.register(messageEvent: { (x: String) in
                                    expect(x).to(equal("foo"))
                                    semaphore.signal()
                                })
                                EventBus.default.post("foo")
                            }
                            concurrentQueue.async {
                                semaphore.wait()
                                self.stringBGBag = EventBus.default.register(messageEvent: { (x: String) in
                                    expect(x).to(equal("foo"))
                                    semaphore.signal()
                                })
                                EventBus.default.post("foo")
                            }
                            done()
                        })
                    })
                })
            })
            describe("post int value", {
                it("get int message event", closure: {
                    waitUntil(action: { (done) in
                        self.intBag = EventBus.default.register(messageEvent: { (x: Int) in
                            expect(x).to(equal(20))
                            done()
                        })
                        EventBus.default.post(20)
                        self.intBag = nil
                    })
                })
            })
            describe("safe post int value", {
                it("throw a error for post", closure: {
                    expect { try EventBus.default.safe.post(100) }.to(throwError(EventBusPostError.useless))
                })
            })
        }
    }
}
