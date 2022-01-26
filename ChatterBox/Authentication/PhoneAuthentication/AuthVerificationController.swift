//
//  AuthVerificationController.swift
//  Pigeon-project
//
//  Created by Jake Brown based on Falcon Messenger
//  Copyright © 2022 Jake Brown Media Productions. All rights reserved.
//

import UIKit


final class AuthVerificationController: VerificationCodeController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setRightBarButton(with: "Next")
  }

  override func rightBarButtonDidTap() {
    super.rightBarButtonDidTap()
    authenticate()
  }
}
