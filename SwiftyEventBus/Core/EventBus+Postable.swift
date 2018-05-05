//
//  Postable.swift
//  SwiftyEventBus
//
//  Created by Maru on 2018/4/30.
//

import Foundation

public protocol EventBusPostable {
    func post<T>(_ cargo: T) where T: EventPresentable
}
