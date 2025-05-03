//
//  SecureAlertController.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/03/26.
//

import UIKit

struct SecureAlertController {
    
    static func showAlert(on viewcontroller: UIViewController, message: String?, title: String?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: title, style: .default, handler: nil)
            alertController.addAction(okAction)
            viewcontroller.present(alertController, animated: true)
        }
    }
}
