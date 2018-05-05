//
//  DemoViewController.swift
//  SwiftyEventBus_Example
//
//  Created by Maru on 2018/5/5.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import SwiftyEventBus

class DemoViewController: UIViewController {

    var ob: EventSubscription<String>!

    override func viewDidLoad() {
        super.viewDidLoad()

        ob = EventBus.`default`.register { (x: String) in
            print(x)
        }
    }


    @IBAction func postAction(_ sender: Any) {
        EventBus.`default`.post(12121)
    }
}
