//
//  EventBusFeatureTests.swift
//  SwiftyEventBus
//
//  Created by Maru on 2018/8/1.
//  Copyright © 2018 Alloc. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import SwiftyEventBus

class EventBusFeatureTests: QuickSpec {

    var box = EventBusBox()

    override func spec() {
        describe("Eventbus advance feature") {
            describe("sticky event message", {
                it("receive foo message", closure: {
                    let stickyFlag = "sticky"
                    let bus = EventBus(domain: stickyFlag)
                    bus.stick.post("foo")
                    waitUntil(action: { (done) in
                        bus.stick.register(on: .main, priority: .default, messageEvent: { (x: String) in
                            expect(x).to(equal("foo"))
                            done()
                        }).release(by: self.box)
                    })
                })
            })
        }
    }
}
