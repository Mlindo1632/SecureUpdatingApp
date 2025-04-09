//
//  SecurePresentation.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/04/09.
//

import Foundation
import UIKit

struct SecureModalPresenter {
    static func present(
        _ viewController: UIViewController,
        from presentingVC: UIViewController,
        presentationStyle: UIModalPresentationStyle = .fullScreen,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        viewController.modalPresentationStyle = presentationStyle
        presentingVC.present(viewController, animated: animated, completion: completion)
        
    }
}

/*
 let employeeListViewController = EmployeeListViewController(nibName: "EmployeeListViewController", bundle: nil)
 employeeListViewController.modalPresentationStyle = .fullScreen
 present(employeeListViewController, animated: true, completion: nil)
 */
