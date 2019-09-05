//
//  Observable.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/5/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import Foundation

class Observable<T> {

    public typealias Observer = (T) -> Void

    private var observers: [Int: (Observer, DispatchQueue?)] = [:]
    private var uniqueId = (0...).makeIterator()
    fileprivate let lock: Lock = Mutex()
    fileprivate var _value: T {
        didSet {
            let newValue = _value
            observers.values.forEach { subscriber, dispatchQueue in
                if let dispatchQueue = dispatchQueue {
                    dispatchQueue.async {
                        subscriber(newValue)
                    }
                } else {
                    subscriber(newValue)
                }
            }
        }
    }

    public var value: T {
        get {
            return _value
        }
        set {
            lock.lock()
            defer { lock.unlock() }
            _value = newValue
        }
    }

    init(_ value: T) {
        self._value = value
    }

    func subscribe(_ queue: DispatchQueue? = nil, _ observer: @escaping Observer) {
        lock.lock()
        defer { lock.unlock() }
        let subscriberId = uniqueId.next()!
        observers[subscriberId] = (observer, queue)
        observer(value)
    }

    func dispose() {
        observers.removeAll()
    }
}
