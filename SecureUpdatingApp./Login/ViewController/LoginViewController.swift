//
//  ViewController.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/03/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginView: LoginView!
    private var loginViewModel: LoginViewModel?
    
    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextFieldsAndButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginView.loginDetailsView.layer.cornerRadius = 20
        loginView.loginDetailsView.clipsToBounds = true
    }
    
    func setUpTextFieldsAndButton() {
        loginView.emailTextField.addTarget(self, action: #selector(emailDidChange), for: .allEditingEvents)
        loginView.passwordTextField.addTarget(self, action: #selector(passwordDidChange), for: .allEditingEvents)
        loginView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }
    
    @objc private func emailDidChange(_ textfield: UITextField) {
        loginViewModel?.email = textfield.text ?? ""
        updateValidationUI()
    }
    
    @objc private func passwordDidChange(_ textfield: UITextField) {
        loginViewModel?.password = textfield.text ?? ""
        updateValidationUI()
    }
    
    private func updateValidationUI() {
        let emailError = loginViewModel?.validateEmail()
        let passwordError = loginViewModel?.validatePassword()
        
        loginView.emailErrorLabel.text = emailError
        loginView.emailErrorLabel.isHidden = (emailError == nil)
        
        loginView.passwordErrorLabel.text = passwordError
        loginView.passwordErrorLabel.isHidden = (passwordError == nil)
        
        let hasErrors = (emailError != nil) || (passwordError != nil)
        loginView.loginButton.isEnabled = !hasErrors
    }
    
    @objc private func loginButtonPressed() {
        loginViewModel?.email = loginView.emailTextField.text?.lowercased() ?? ""
        loginViewModel?.password = loginView.passwordTextField.text ?? ""
        
        guard ((loginViewModel?.isFormValid) != nil) else {
            updateValidationUI()
            return
        }
        
        loginView.activityIndicator.isHidden = false
        loginView.activityIndicator.startAnimating()
        
        Task { @MainActor in
            do {
                let token = try await loginViewModel?.getToken()
                
                SecureAcivityIndicator.stopAndHideActivityIndicator(loginView.activityIndicator)
                
                print("Successfully Logged in. Token:", token ?? "")
                SecureTextFieldAndButtonManager.clearAndDisable(textFieldOne: loginView.emailTextField,
                                                                textFieldTwo: loginView.passwordTextField,
                                                                button: loginView.loginButton
                )
                
                let employeeHomeViewModel = EmployeeHomeViewModel()
                let employeeHomeViewController = EmployeeHomeViewController(viewModel: employeeHomeViewModel)
                SecureNavigation.navigate(from: self, to: employeeHomeViewController)
                
            } catch {
                
                SecureAcivityIndicator.stopAndHideActivityIndicator(loginView.activityIndicator)
                
                SecureTextFieldAndButtonManager.clearAndDisable(textFieldOne: loginView.emailTextField,
                                                                textFieldTwo: loginView.passwordTextField,
                                                                button: loginView.loginButton
                )
                
                SecureAlertController.showAlert(on: self,
                                                message: error.localizedDescription,
                                                title: "Login failed"
                )
            }
        }
    }
    
    deinit {
        print("\(self) has been removed from Memory")
    }
}

