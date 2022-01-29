//
//  Country.swift
//  ChatterBox
//
//  Created by Jake Brown based on Falcon Messenger
//  Copyright © 2022 Jake Brown Media Productions. All rights reserved.
//

import UIKit

final class Country: NSObject {

  @objc var name: String?
  var code: String?
  var dialCode: String?
  var isSelected = false

  init(dictionary: [String: String]) {
    super.init()

    name = dictionary["name"]
    code = dictionary["code"]
    dialCode = dictionary["dial_code"]
  }
}
