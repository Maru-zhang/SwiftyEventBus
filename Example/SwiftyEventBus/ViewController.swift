//
//  ViewController.swift
//  SwiftyEventBus
//
//  Created by Maru-zhang on 04/30/2018.
//  Copyright (c) 2018 Maru-zhang. All rights reserved.
//

import UIKit
import SwiftyEventBus
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

//        EventBus.`default`.register { (x: String) in
//            print(x)
//        }
//
//        EventBus.`default`.post("sssss")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

