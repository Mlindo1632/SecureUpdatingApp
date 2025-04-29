//
//  EmployeeHomeViewController.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/03/26.
//

import UIKit

class EmployeeHomeViewController: UIViewController {
    
    @IBOutlet weak var employeeHomeView: EmployeeHomeView!
    
    private var nextBarButton: UIBarButtonItem!
    private var viewModel: EmployeeHomeViewModel?
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "EMPLOYEE HOME"
        SecureToast.showToast(message: "Successfully Logged In", backgroundColour: .green, in: self.view)
        setUpTextFieldsAndSelectedEmployeeButton()
        pickDateOfBirth()
        setupNextBarButton()
    
        employeeHomeView.dateOfBirthTextfield.delegate = self
        viewModel?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    private func setUpTextFieldsAndSelectedEmployeeButton() {
        employeeHomeView.placeOfBirthTextfield.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        employeeHomeView.dateOfBirthTextfield.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        employeeHomeView.selectEmployeeButton.addTarget(self, action: #selector(selectEmployeeButtonPressed), for: .touchUpInside)
    }
    
     private func setupNextBarButton() {
        let nextBarButton = UIBarButtonItem(title: "NEXT", style: .plain, target: self, action: #selector(goToAdditionalInfo))
        nextBarButton.isEnabled = false
        navigationItem.rightBarButtonItem = nextBarButton
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
    
    @objc private func textFieldChanged(_ sender: UITextField) {
        viewModel?.placeOfBirthTextField = employeeHomeView.placeOfBirthTextfield.text ?? ""
        viewModel?.dateOfBirthTextField = employeeHomeView.dateOfBirthTextfield.text ?? ""
    }
    
    func pickedImage(_ image: UIImage) {
        employeeHomeView.selectedEmployeeImage.image = image
        viewModel?.selectedImage = image
    }
}

extension EmployeeHomeViewController: EmployeeHomeViewModelDelegate {
    func didUpdateForm(isValid: Bool) {
        nextBarButton.isEnabled = isValid
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
