//
//  Postable.swift
//  SwiftyEventBus
//
//  Created by Maru on 2018/4/30.
//

import Foundation

/// The error for posting event
///
/// - useless: post a message that no subscriber observing
public enum EventBusPostError: Error {
    case useless
}

public protocol EventBusPostable {
    
    /// Post a value to all subsctiber
    ///
    /// - Parameter cargo: The playload of any type
    func post<T>(_ cargo: T) where T: EventPresentable


    /// Safe post a value to all subscriber,
    /// make sure there is one subscriber at least
    ///
    /// - Parameter cargo: The playload of any type
    func safePost<T>(_ cargo: T) throws where T: EventPresentable
}
