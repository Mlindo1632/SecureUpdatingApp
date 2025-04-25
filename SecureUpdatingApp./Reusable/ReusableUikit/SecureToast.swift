//
//  SecureToast.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/03/26.
//

import UIKit

struct SecureToast {
    static func showToast(message: String, backgroundColour: UIColor, in parentView: UIView) {
        DispatchQueue.main.async {
            
            let labelHeight: CGFloat = 50
            let bottomPadding = parentView.safeAreaInsets.bottom
            let finalY = parentView.bounds.height - labelHeight - bottomPadding - 10
            let startY = parentView.bounds.height
            
            let toastLabel = UILabel(frame: CGRect(x: 40, y: startY, width: 300, height: 40))
            toastLabel.text = message
            toastLabel.font = UIFont.boldSystemFont(ofSize: 24)
            toastLabel.textAlignment = .center
            toastLabel.backgroundColor = backgroundColour
            toastLabel.textColor = UIColor.white
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 15
            toastLabel.clipsToBounds = true
            
            parentView.addSubview(toastLabel)
            
            UIView.animate(withDuration: 0.3, animations: {
                toastLabel.frame.origin.y = finalY
                toastLabel.alpha = 1
            }) { _ in
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    UIView.animate(withDuration: 0.3, animations: {
                        toastLabel.frame.origin.y = startY
                        toastLabel.alpha = 0
                    }) { _ in
                        toastLabel.removeFromSuperview()
                    }
                }
            }
        }
    }
}
