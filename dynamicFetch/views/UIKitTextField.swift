//
//  UIKitTextField.swift
//  dynamicFetch
//
//  Created by Alexander Emery on 16/11/19.
//  Copyright © 2019 Alexander Emery. All rights reserved.
//

import UIKit

class UIKitTextField: UITextField, UITextFieldDelegate {

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    delegate = self
  }

  required override init(frame: CGRect) {
    super.init(frame: frame)
    delegate = self
    self.setContentHuggingPriority(.defaultHigh, for: .vertical)
  }
}
