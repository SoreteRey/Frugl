//
//  UIViewControllersExtension.swift
//  Frugl
//
//  Created by Matthew Hill on 5/15/23.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenDone() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
