//
//  ViewController.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/11.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var loginActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private var emailTextfield: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet var emailErrorLabel: UILabel!
    @IBOutlet var passwordErrorLabel: UILabel!
    @IBOutlet var loginButton: UIButton!
    
    var loginViewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        
        loginActivityIndicator.isHidden = true
        
        emailTextfield.delegate = self
        passwordTextField.delegate = self
    }
    
    func setupViewModel(){
        let loginAPIService = LoginAPIService()
        let loginRepository = LoginRepository(loginAPIService: loginAPIService)
        loginViewModel = LoginViewModel(loginRepository: loginRepository)
        loginViewModel.delegate = self
    }
    
    func stopAndHideActivityIndicator() {
        loginActivityIndicator.stopAnimating()
        loginActivityIndicator.isHidden = true
    }
    
    func invalidCredentialsAlert() {
        let alertController = UIAlertController(title: "Warning", message: "Failed to validate", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func navigateToSelectEmployee() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectEmployeeViewController") as! SelectEmployeeViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        loginActivityIndicator.isHidden = false
        loginActivityIndicator.startAnimating()
        
        guard let email = emailTextfield.text, let password = passwordTextField.text else { return }
        loginViewModel.loginUser(email: email, password: password)
    }
}

extension LoginViewController: LoginViewModelDelegate {
    
    func didSuccessfullyLogin(loginModel: LoginModel) {
        print("Login successful. User token is \(loginModel.token)")
        navigateToSelectEmployee()
        stopAndHideActivityIndicator()
    }
    
    func didFailLogin(error: Error) {
        print("Login failed. Error: \(error.localizedDescription)")
        invalidCredentialsAlert()
        stopAndHideActivityIndicator()
    }
    
    func validateTextfields(withError error: String) {
        emailErrorLabel.text = error
        emailErrorLabel.isHidden = false
        invalidCredentialsAlert()
        stopAndHideActivityIndicator()
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
    emailErrorLabel.isHidden = true
    }
}

