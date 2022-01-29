//
//  CreateProfileController+keyboardHandlers.swift
//  Pigeon-project
//
//  Created by Jake Brown based on Falcon Messenger
//  Copyright © 2022 Jake Brown Media Productions. All rights reserved.
//

import UIKit

extension UIViewController {
 final func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                             action: #selector(UIViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }

  @objc final func dismissKeyboard() {
    view.endEditing(true)
  }
}
