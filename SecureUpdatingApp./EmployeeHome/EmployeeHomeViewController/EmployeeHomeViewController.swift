//
//  EmployeeHomeViewController.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/03/26.
//

import UIKit

class EmployeeHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.hidesBackButton = true
        SecureToast.showToast(message: "Successfully Logged in", backgroundColour: .green, viewController: self)
    }
}
