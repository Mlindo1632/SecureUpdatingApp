//
//  EmployeeHomeViewController.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/03/26.
//

import UIKit

class EmployeeHomeViewController: UIViewController {
    
    @IBOutlet weak var employeeHomeView: EmployeeHomeView!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeHomeView.selectEmployeeButton.addTarget(self, action: #selector(selectEmployeeButtonPressed), for: .touchUpInside)
        pickDateOfBirth()
        SecureToast.showToast(message: "Successfully Logged In", backgroundColour: .green, in: self.view)
        title = "EMPLOYEE HOME"
        employeeHomeView.dateOfBirthTextfield.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        setupNextBarButton()
    }
    
    private func setupNextBarButton() {
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
    
    private func pickDateOfBirth () {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        toolBar.items = [doneButton]
        employeeHomeView.dateOfBirthTextfield.inputAccessoryView = toolBar
        employeeHomeView.dateOfBirthTextfield.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        
        employeeHomeView.dateOfBirthTextfield.tintColor = .clear
        
    }
    
    @objc func doneButtonPressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        employeeHomeView.dateOfBirthTextfield.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
}

extension EmployeeHomeViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
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
