//
//  Observable.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/5/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import Foundation

class Observable<T> {

    public typealias Observer = (T?) -> Void

    private var observers: [Int: (Observer, DispatchQueue?)] = [:]
    private var uniqueId = (0...).makeIterator()
    fileprivate let semaphore = DispatchSemaphore(value: 1)
    fileprivate var onDispose: () -> Void
    fileprivate var _value: T? {
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

    public var value: T? {
        get {
            return _value
        }
        set {
            semaphore.wait()
            _value = newValue
            semaphore.signal()
        }
    }

    init(_ value: T? = nil, onDispose: @escaping () -> Void = { }) {
        self._value = value
        self.onDispose = onDispose
    }

    func subscribe(on queue: DispatchQueue? = nil, _ observer: @escaping Observer) -> Disposable {
        semaphore.wait()
        let subscriberId = uniqueId.next()!
        observers[subscriberId] = (observer, queue)
        observer(value)
        semaphore.signal()

        let disposable = Disposable { [weak self] in
            self?.observers[subscriberId] = nil
            self?.onDispose()
        }
        return disposable
    }

    func dispose() {
        observers.removeAll()
    }
}
