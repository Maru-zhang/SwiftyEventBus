//
//  EventPresentable.swift
//  SwiftyEventBus
//
//  Created by Maru on 2018/5/1.
//

import Foundation

public protocol EventPresentable {
    static var processIdentifier: String { get }
}

extension EventPresentable {

    public static var processIdentifier: String {
        return String(describing: self)
    }
}

extension String: EventPresentable {}
extension Int: EventPresentable {}
extension Int8: EventPresentable {}
extension Int16: EventPresentable {}
extension Int32: EventPresentable {}
extension Int64: EventPresentable {}
extension Array: EventPresentable {}
extension Set: EventPresentable {}
