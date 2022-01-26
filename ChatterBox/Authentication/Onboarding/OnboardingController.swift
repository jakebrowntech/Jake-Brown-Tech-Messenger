//
//  OnboardingController.swift
//  Pigeon-project
//
//  Created by Jake Brown based on Falcon Messenger
//  Copyright © 2022 Jake Brown Media Productions. All rights reserved.
//

import UIKit

final class OnboardingController: UIViewController {

  let onboardingContainerView = OnboardingContainerView()

  override func viewDidLoad() {
    super.viewDidLoad()

    if #available(iOS 11.0, *) {
      navigationItem.largeTitleDisplayMode = .automatic
      navigationController?.navigationBar.prefersLargeTitles = true
			navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }

    view.addSubview(onboardingContainerView)
    extendedLayoutIncludesOpaqueBars = true
    definesPresentationContext = true
    onboardingContainerView.translatesAutoresizingMaskIntoConstraints = false
    onboardingContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    onboardingContainerView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    onboardingContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    onboardingContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    setColorsAccordingToTheme()
  }

  fileprivate func setColorsAccordingToTheme() {
    let theme = ThemeManager.currentTheme()
    ThemeManager.applyTheme(theme: theme)
    view.backgroundColor = ThemeManager.currentTheme().generalBackgroundColor
    onboardingContainerView.backgroundColor = view.backgroundColor
  }

  @objc func startMessagingDidTap () {
    let destination = AuthPhoneNumberController()
    navigationController?.pushViewController(destination, animated: true)
  }
}
