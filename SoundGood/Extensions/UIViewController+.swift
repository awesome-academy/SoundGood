//
//  UIViewController+.swift
//  SoundGood
//
//  Created by Dang Thanh Dat on 9/6/19.
//  Copyright © 2019 Sun Asterisk. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func showErrorAlert(message: String?) {
        showAlertView(title: "Error", message: message, cancelButton: "OK")
    }

    private func showAlertView(title: String?, message: String?,
                               cancelButton: String?, otherButtons: [String]? = nil,
                               type: UIAlertController.Style = .alert,
                               cancelAction: (() -> Void)? = nil,
                               otherAction: ((Int) -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
        if let cancelButton = cancelButton {
            let cancelAction = UIAlertAction(title: cancelButton, style: .cancel) { (_) in
                cancelAction?()
            }
            alertViewController.addAction(cancelAction)
        }
        if let otherButtons = otherButtons {
            for (index, otherButton) in otherButtons.enumerated() {
                let otherAction = UIAlertAction(title: otherButton, style: .default) { (_) in
                    otherAction?(index)
                }
                alertViewController.addAction(otherAction)
            }
        }
        self.present(alertViewController, animated: true, completion: nil)
    }

    func navigate(controller: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = .push
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        guard let view = navigationController?.view else { return }
        view.window?.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(controller, animated: false)
    }
}
