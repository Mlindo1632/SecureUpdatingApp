//
//  EmployeeHomeViewController.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/03/26.
//

import UIKit

class EmployeeHomeViewController: UIViewController {
    
    @IBOutlet weak var employeeHomeView: EmployeeHomeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        employeeHomeView.selectEmployeeButton.addTarget(self, action: #selector(selectEmployeeButtonPressed), for: .touchUpInside)
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
    
    @objc private func selectEmployeeButtonPressed() {
        let employeeListViewController = EmployeeListViewController(nibName: "EmployeeListViewController", bundle: nil)
        
        SecureModalPresenter.present(employeeListViewController, from: self)
    }
    
    @objc func goToAdditionalInfo() {
        
    }
}
