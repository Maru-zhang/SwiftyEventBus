//
//  Bucket.swift
//  SwiftyEventBus
//
//  Created by Maru on 2019/8/8.
//  Copyright © 2019 Alloc. All rights reserved.
//

import Foundation

/// The open address width of hash-table
public let ObserverHubOpenWidth = 12

public class ObserverHub {

    /// The holder of all buckets
    private let buckets = [BucketEntry](repeating: BucketEntry(), count: ObserverHubOpenWidth)

    /// Find all observers that observe The type `T`
    ///
    /// - Parameter type: The Event type
    /// - Returns: The set of all observers
    public func findAll<T>(_ type: T.Type) -> Set<EventSubscriber<T>>? {
        let id = EventID(type)
        let index = abs(id.hashValue % ObserverHubOpenWidth)
        let entry = buckets[index]
        objc_sync_enter(entry)
        defer {
            objc_sync_exit(entry)
        }
        let bucket: Bucket
        if let oldBucket = entry.find(with: id) {
            bucket = oldBucket
        } else {
            bucket = Bucket(eventID: id, entry: entry)
        }
        return bucket.subscribers as? Set<EventSubscriber<T>>
    }

    /// Append observer to opaque `ObserverHub`
    ///
    /// - Parameter observer: Any type of subscriber
    public func add<T>(_ observer: EventSubscriber<T>) {
        let id = EventID(T.self)
        let index = abs(id.hashValue % ObserverHubOpenWidth)
        let entry = buckets[index]
        objc_sync_enter(entry)
        defer {
            objc_sync_exit(entry)
        }
        let bucket: Bucket
        let isOld: Bool
        if let oldBucket = entry.find(with: id) {
            bucket = oldBucket
            isOld = true
        } else {
            bucket = Bucket(eventID: id, entry: entry)
            isOld = false
        }
        /// note: don't use append method, it will waste mem-space.
        if var subscribers = bucket.subscribers as? Set<EventSubscriber<T>> {
            subscribers.insert(observer)
            bucket.subscribers = subscribers
        } else {
            bucket.subscribers = Set<EventSubscriber<T>>(arrayLiteral: observer)
        }
        if entry.head == nil {
            entry.head = bucket
        }
        if (!isOld) {
            bucket.parent = entry.trail
            entry.trail?.next = bucket
            entry.trail = bucket
        }
    }

    /// Remove observer from opaque `ObserverHub`
    ///
    /// - Parameter observer: Any type of subscriber
    public func remove<T>(_ observer: EventSubscriber<T>) {
        let id = EventID(T.self)
        let index = abs(id.hashValue % ObserverHubOpenWidth)
        let entry = buckets[index]
        objc_sync_enter(entry)
        defer {
            objc_sync_exit(entry)
        }
        guard let bucket = entry.find(with: id) else {
            return
        }
        guard var subscribers = bucket.subscribers as? Set<EventSubscriber<T>> else {
            return
        }
        subscribers.remove(observer)
        if subscribers.isEmpty {
            // remove bucket node
            let nextBucket = bucket.next
            if (nextBucket == nil) {
                entry.trail = bucket.parent
            }
            if (bucket.parent == nil) {
                entry.head = nil
            }
            bucket.parent?.next = nextBucket
            bucket.parent = nil
            bucket.next = nil
        } else {
            bucket.subscribers = subscribers
        }
    }
}

class BucketEntry {

    var head: Bucket?

    var trail: Bucket?

    /// find the bucket with specify EventID
    ///
    /// - Parameter id: EventID of type `T`
    /// - Returns: bucket match the EventID or nil
    func find(with id: String) -> Bucket? {
        var bucket = head
        while let cur = bucket {
            if cur.id == id {
                return cur
            }
            bucket = bucket?.next
        }
        return bucket
    }
}

class Bucket {

    /// The EventID of type `T`
    let id: String
    /// The refrence to root bucket
    let entry: BucketEntry
    /// All subscribers of this bucket, the real type is `Set<EventSubscriber<T>>`
    var subscribers: Any?
    /// The refrence to next bucket
    var next: Bucket?
    /// The refrence to previous bucket
    var parent: Bucket?

    init(eventID: String, entry: BucketEntry) {
        self.id = eventID
        self.entry = entry
    }
}
