//
//  SecureToast.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/03/26.
//

import Foundation
import UIKit

struct SecureToast {
    static func showToast(message: String, backgroundColour: UIColor, viewController: UIViewController) {
        DispatchQueue.main.async {
            let toastLabel = UILabel(frame: CGRect(x: 40, y: 50, width: 300, height: 40))
            toastLabel.text = message
            toastLabel.font = UIFont.boldSystemFont(ofSize: 24)
            toastLabel.textAlignment = .center
            toastLabel.backgroundColor = backgroundColour
            toastLabel.textColor = UIColor.white
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 15
            toastLabel.clipsToBounds = true
            viewController.view.addSubview(toastLabel)
            
            UIView.animate(withDuration: 4.0, delay: 1.0, options: .curveEaseOut, animations: { toastLabel.alpha = 0.0 }) {(isCompleted) in
                toastLabel.removeFromSuperview()
            }
        }
    }
}
