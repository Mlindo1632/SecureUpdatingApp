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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        SecureToast.showToast(message: "Successfully Logged In", backgroundColour: .green, in: self.view)
        title = "EMPLOYEE HOME"
        setupNextButton()
    }
    
    private func setupNextButton() {
        let button = UIBarButtonItem(title: "NEXT", style: .plain, target: self, action: #selector(goToAdditionalInfo))
        button.isEnabled = false
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func goToAdditionalInfo() {
        
    }
}
