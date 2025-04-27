//
//  SecureTextFieldRounder.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/04/27.
//

import UIKit

struct SecureTextFieldModifier {
    
   static func roundCorners(textField: UITextField, radius: CGFloat) {
        textField.layer.cornerRadius = radius
        textField.layer.masksToBounds = true
    }
}
