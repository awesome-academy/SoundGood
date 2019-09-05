//
//  Mutex.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/5/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import Foundation

internal protocol Lock {
    func lock()
    func unlock()
}

internal final class Mutex: Lock {
    
    private var mutex: pthread_mutex_t = {
        var mutex = pthread_mutex_t()
        pthread_mutex_init(&mutex, nil)
        return mutex
    }()
    
    func lock() {
        pthread_mutex_lock(&mutex)
    }
    
    func unlock() {
        pthread_mutex_unlock(&mutex)
    }
}
