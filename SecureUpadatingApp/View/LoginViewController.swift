//
//  ViewController.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/11.
//

import UIKit

class LoginViewController: UIViewController, LoginViewModelDelegate {
    
    @IBOutlet var loginActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private var emailTextfield: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet var emailErrorLabel: UILabel!
    @IBOutlet var passwordErrorLabel: UILabel!
    @IBOutlet var loginButton: UIButton!
    
    
   private var loginViewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewModel()
        loginActivityIndicator.isHidden = true
        checkValidTextFields()
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
    }
    
   
    @IBAction func emailTextFieldDidChange(_ sender: Any) {
               if let textField = emailTextfield.text
            {
              if let errorMessage = invalidEmailAddress(textField)
               {
                  emailErrorLabel.text = errorMessage
                  emailErrorLabel.isHidden = false
              } else {
                  emailErrorLabel.isHidden = true
              }
           }
            checkValidTextFields()
    }
    
    func invalidEmailAddress(_ value: String) -> String?
    {
        if !value.hasSuffix("@reqres.in")
        {
            return "Please enter a vaild email"
        }
        return nil
    }
        
    @IBAction func passwordTextFieldEditingChanged(_ sender: Any) {
        if let textField = passwordTextField.text
        {
            if let errorMessage = invalidPassword(textField)
            {
                passwordErrorLabel.text = errorMessage
                passwordErrorLabel.isHidden = false
            } else {
                passwordErrorLabel.isHidden = true
                
            }
        }
    }
        
    func invalidPassword(_ value: String) -> String?
    {
        if value.count < 6
        {
            return "Minimum 6 characters"
        }
        return nil
    }
    
    func checkValidTextFields() {
        if emailErrorLabel.isHidden && passwordErrorLabel.isHidden
        {
            loginButton.isEnabled = true
        }
        else
        {
            loginButton.isEnabled = false
        }
    }
    
    func setupViewModel() {
        let loginAPIService = LoginAPIService()
        let loginRepository = LoginRepository(loginAPIService: loginAPIService)
        loginViewModel = LoginViewModel(loginRepository: loginRepository)
        loginViewModel.delegate = self
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
    
    func didSuccessfullyLogin(loginModel: LogInModel) {
        print("Login successful. User token is: \(loginModel.token)")
        navigateToSelectEmployee()
        loginActivityIndicator.isHidden = true
        
        
    }

    func didFailLogin(error: Error) {
        print("Login failed. Error: \(error.localizedDescription)")
        invalidCredentialsAlert()
        loginActivityIndicator.isHidden = true
    }
    
}

