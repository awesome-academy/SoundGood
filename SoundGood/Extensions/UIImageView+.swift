//
//  UIImageView+.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 8/30/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit

typealias SimpleClosure = (() -> Void)
private var actionKey = 1

extension UIImageView {

    @objc var tapAction: SimpleClosure? {
        get {
            return objc_getAssociatedObject(self, &actionKey) as? SimpleClosure
        }
        set {
            objc_setAssociatedObject(self, &actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.addTapGesture()
        }
    }

    var gesture: UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(tapped))
    }

    fileprivate func addTapGesture() {
        if self.isUserInteractionEnabled {
            self.gesture.numberOfTapsRequired = 1
            self.addGestureRecognizer(gesture)
        }
    }

    @objc private func tapped() {
        tapAction?()
        self.isHighlighted = false
    }

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isHighlighted = true
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isHighlighted = false
    }
}
