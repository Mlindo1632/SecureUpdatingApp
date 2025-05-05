//
//  SecureTextFieldRounder.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/04/27.
//

import UIKit

struct SecureTextFieldModifier {
    
   static func modifyTextFields(textField: UITextField, radius: CGFloat) {
       textField.layer.cornerRadius = radius
       textField.layer.masksToBounds = true
       textField.layer.borderWidth = 1.75
       textField.layer.borderColor = UIColor.black.cgColor
    }
}
