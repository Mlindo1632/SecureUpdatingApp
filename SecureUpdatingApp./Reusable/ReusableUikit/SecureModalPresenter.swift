//
//  SecurePresentation.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/04/09.
//

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
