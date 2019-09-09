//
//  Disposable.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/9/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

typealias CompositeDisposable = [Disposable]

final class Disposable {
    private let dispose: () -> Void

    init(_ dispose: @escaping () -> Void) {
        self.dispose = dispose
    }

    deinit {
        dispose()
    }

    func add(to compositeDisposable: inout CompositeDisposable) {
        compositeDisposable.append(self)
    }
}
