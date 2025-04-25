//
//  SecureTextfieldAndButtonManager.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/03/26.
//

import UIKit

struct SecureTextFieldAndButtonManager {
    
    static func clearAndDisable(textFieldOne: UITextField, textFieldTwo: UITextField, button: UIButton) {
        DispatchQueue.main.async {
            textFieldOne.text?.removeAll()
            textFieldTwo.text?.removeAll()
            button.isEnabled = false
        }
    }
}
