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
        // Do any additional setup after loading the view.
        
        loginViewModel?.delegate = self
        NetworkManager.shared.delegate = self
        
        loginView.emailTextField.addTarget(self, action: #selector(emailDidChange), for: .allEditingEvents)
        loginView.passwordTextField.addTarget(self, action: #selector(passwordDidChange), for: .allEditingEvents)
        loginView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }
    
    @objc private func emailDidChange(_ textfield: UITextField) {
        loginViewModel?.email = textfield.text ?? ""
    }
    
    @objc private func passwordDidChange(_ textfield: UITextField) {
        loginViewModel?.password = textfield.text ?? ""
    }
    
    @objc private func loginButtonPressed() {
        loginView.activityIndicator.isHidden = false
        loginView.activityIndicator.startAnimating()
        
        guard let email = loginView.emailTextField.text?.lowercased(), let password = loginView.passwordTextField.text else { return }
        loginViewModel?.loginUser(email: email, password: password)
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func didUpdateEmailValidation(isValid: Bool, errorMessage: String?) {
        if let errorMessage = errorMessage {
            loginView.emailErrorLabel.text = errorMessage
            loginView.emailErrorLabel.isHidden = false
        } else {
            loginView.emailErrorLabel.isHidden = true
        }
    }
    
    func didUpdatePasswordValidation(isValid: Bool, errorMessage: String?) {
        if let errorMessage = errorMessage {
            loginView.passwordErrorLabel.text = errorMessage
            loginView.passwordErrorLabel.isHidden = false
        } else {
            loginView.passwordErrorLabel.isHidden = true
        }
    }
    
    func didUpdateFormValidation(isValid: Bool) {
        loginView.loginButton.isEnabled = isValid
    }
}

extension LoginViewController: NetworkManagerDelegate {
    func didDecodeData<T>(_ data: T) where T : Decodable {
        SecureAcivityIndicator.stopAndHideActivityIndicator(loginView.activityIndicator)
        print("Successfully Logged in. Token is \(data)")
        SecureNavigation.navigate(from: self, to: EmployeeHomeViewController.self)
        SecureTextFieldAndButtonManager.clearAndDisable(textFieldOne: loginView.emailTextField, textFieldTwo: loginView.passwordTextField, button: loginView.loginButton)
    }
    
    func didFail(_ error: APIError) {
        SecureAcivityIndicator.stopAndHideActivityIndicator(loginView.activityIndicator)
        print("Password or Email may be incorrect. Please try again")
        SecureAlertController.showAlert(on: self, message: "password or email may be incorrect. Please try again", title: "OK")
        SecureTextFieldAndButtonManager.clearAndDisable(textFieldOne: loginView.emailTextField, textFieldTwo: loginView.passwordTextField, button: loginView.loginButton)
    }
}

