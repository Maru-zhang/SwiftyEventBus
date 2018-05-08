//
//  Postable.swift
//  SwiftyEventBus
//
//  Created by Maru on 2018/4/30.
//

import Foundation

public protocol EventBusPostable {
    
    /// Post a value to all subsctiber
    ///
    /// - Parameter cargo: The playload of any type
    func post<T>(_ cargo: T) where T: EventPresentable
}
