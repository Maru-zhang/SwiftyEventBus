//
//  EventBusDispatchTests.swift
//  SwiftyEventBus_Tests
//
//  Created by Maru on 2018/5/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import SwiftyEventBus

class EventBusDispatchTests: QuickSpec {

    override func spec() {
        describe("Dispatch queue tests") {
            var bag: EventSubscription<String>!
            context("post on global queue", {
                context("dispatch on same queue", {
                    waitUntil(action: { (done) in
                        let token = DispatchSpecificKey<String>()
                        DispatchQueue.global().setSpecific(key: token, value: "global")
                        DispatchQueue.global().sync {
                            bag = EventBus.default.register(on: .same, messageEvent: { (x: String) in
                                expect(DispatchQueue.getSpecific(key: token)).to(equal("global"))
                                expect(x).to(equal("foo"))
                                done()
                            })
                            EventBus.default.post("foo")
                        }
                    })
                })
                context("dispatch on main queue", {
                    waitUntil(action: { (done) in
                        DispatchQueue.global().async(execute: {
                            bag = EventBus.default.register(on: .main, messageEvent: { (x: String) in
                                expect(DispatchQueue.isMain).to(equal(true))
                                expect(x).to(equal("foo"))
                                done()
                            })
                            EventBus.default.post("foo")
                        })
                    })
                })
            })
        }
    }
}
