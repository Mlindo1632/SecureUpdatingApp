//
//  SecureNavigation.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/03/26.
//

import UIKit

struct SecureNavigation {
    static func navigate(from currentVC: UIViewController, to nextVC: UIViewController) {
        if let navigationController = currentVC.navigationController {
            navigationController.pushViewController(nextVC, animated: true)
            
            let viewControllers = navigationController.viewControllers
            navigationController.viewControllers = viewControllers
        }
    }
}

