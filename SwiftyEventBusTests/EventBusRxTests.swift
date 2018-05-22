//
//  EventBusRxTests.swift
//  SwiftyEventBus_Tests
//
//  Created by Maru on 2018/5/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift
import Quick
import Nimble
@testable import SwiftyEventBus

class EventBusRxSpec: QuickSpec {

    override func spec() {
        describe("RxSwift extension") {
            it("subscribe string type", closure: {
                var bag: DisposeBag? = DisposeBag()
                waitUntil(action: { (done) in
                    EventBus.default.rx.register(String.self)
                        .subscribe(onNext: { (x) in
                            expect(x).to(equal("foo"))
                            done()
                        })
                        .disposed(by: bag!)
                    EventBus.default.post("foo")
                })
                bag = nil
            })
        }
    }
}
