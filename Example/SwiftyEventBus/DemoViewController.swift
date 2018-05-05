//
//  DemoViewController.swift
//  SwiftyEventBus_Example
//
//  Created by Maru on 2018/5/5.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import RxCocoa
import SwiftyEventBus
import RxSwift

struct Person: EventPresentable {
    let name: String
}

class DemoViewController: UIViewController {

    var ob: EventSubscription<String>!

    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

//        ob = EventBus.`default`.register { (x: String) in
//            print(x)
//        }

        EventBus.default.rx.register(Person.self)
            .subscribe(onNext: { (x) in
                print(x)
            })
            .disposed(by: bag)
    }


    @IBAction func postAction(_ sender: Any) {
        let p = Person(name: "xiaom")
        EventBus.`default`.post(p)
    }
}
