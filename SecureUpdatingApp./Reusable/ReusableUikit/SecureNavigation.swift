//
//  SecureNavigation.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/03/26.
//

import UIKit

struct SecureNavigation {
    
    static func navigate(from currentVC: UIViewController, to viewcontrollerType: UIViewController.Type) {
        DispatchQueue.main.async {
            let viewcontroller = String(describing: viewcontrollerType)
            let nextViewcontroller = viewcontrollerType.init(nibName: viewcontroller, bundle: nil)
            
            if let navigationController = currentVC.navigationController {
                navigationController.pushViewController(nextViewcontroller, animated: true)
                
                            var viewControllers = navigationController.viewControllers
                            viewControllers.removeAll { $0 === currentVC }
                            navigationController.viewControllers = viewControllers
                        }
                    }
                }
            }
