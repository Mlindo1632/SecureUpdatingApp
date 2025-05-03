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
    
       init(viewModel: EmployeeHomeViewModel) {
           self.viewModel = viewModel
           super.init(nibName: String(describing: EmployeeHomeViewController.self), bundle: nil)
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "EMPLOYEE HOME"
        SecureToast.showToast(message: "Successfully Logged In", backgroundColour: .green, in: self.view)
        
        setUpTextFieldsAndSelectedEmployeeButton()
        setupNextBarButton()
        
        employeeHomeView.dateOfBirthTextfield.delegate = self
        viewModel?.delegate = self
        
        SecureDatePicker.attachDatePicker(to: employeeHomeView.dateOfBirthTextfield)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissDatePicker))
            tapGesture.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    private func setUpTextFieldsAndSelectedEmployeeButton() {
        employeeHomeView.placeOfBirthTextfield.addTarget(self, action: #selector(textFieldChanged(_:)), for: .allEvents)
        employeeHomeView.dateOfBirthTextfield.addTarget(self, action: #selector(textFieldChanged(_:)), for: .allEvents)
        employeeHomeView.selectEmployeeButton.addTarget(self, action: #selector(selectEmployeeButtonPressed), for: .touchUpInside)
    }
    
     private func setupNextBarButton() {
        nextBarButton = UIBarButtonItem(title: "NEXT", style: .plain, target: self, action: #selector(goToAdditionalInfo))
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
    
    @objc private func textFieldChanged(_ sender: UITextField) {
        viewModel?.placeOfBirthTextField = employeeHomeView.placeOfBirthTextfield.text ?? ""
        viewModel?.dateOfBirthTextField = employeeHomeView.dateOfBirthTextfield.text ?? ""
    }
    
    @objc func dismissDatePicker() {
        view.endEditing(true)
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.viewModel?.selectedImage = self?.employeeHomeView.selectedEmployeeImage.image
        }
        
        employeeHomeView.employeeDetailsView.isHidden = false
    }
}
