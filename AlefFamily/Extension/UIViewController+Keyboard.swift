//
//  UIViewController+Keyboard.swift
//  AlefFamily
//
//  Created by n3deep on 17.09.2020.
//  Copyright © 2020 n3deep. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    @objc func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
