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
        
        employeeHomeView.selectEmployeeButton.addTarget(self, action: #selector(selectEmployeeButtonPressed), for: .touchUpInside)
        SecureToast.showToast(message: "Successfully Logged In", backgroundColour: .green, in: self.view)
        title = "EMPLOYEE HOME"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        setupNextButton()
    }
    
    private func setupNextButton() {
        let button = UIBarButtonItem(title: "NEXT", style: .plain, target: self, action: #selector(goToAdditionalInfo))
        button.isEnabled = false
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func selectEmployeeButtonPressed() {
        let employeeListViewController = EmployeeListViewController(nibName: "EmployeeListViewController", bundle: nil)
        let serviceCall = EmployeeListServiceCall()
        let viewModel = EmployeeListViewModel(employeeListServiceCall: serviceCall)
        employeeListViewController.employeeListViewModel = viewModel
        employeeListViewController.selectionDelegate = self
        
        SecureModalPresenter.present(employeeListViewController, from: self)
    }
    
    @objc func goToAdditionalInfo() {
        
    }
}

extension EmployeeHomeViewController: EmployeeSelectionDelegate {
    func didSelectEmployee(_ employee: EmployeeDetails) {
        title = " Employee ID: \(employee.id)"
        employeeHomeView.selectedEmployeeName.text = "\(employee.firstName) \(employee.lastName)"
        employeeHomeView.selectedEmployeeEmail.text = employee.email
        SecureImageHelper.loadCachedImage(from: employee.avatar, into: employeeHomeView.selectedEmployeeImage)
        
        employeeHomeView.employeeDetailsView.isHidden = false
    }
}
