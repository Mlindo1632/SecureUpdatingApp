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
    
    
   private var loginViewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewModel()
        //loginActivityIndicator.isHidden = true
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
        return
    }
    
    
    func navigateToSelectEmployee() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectEmployeeViewController") as! SelectEmployeeViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        loginActivityIndicator.startAnimating()
        loginActivityIndicator.isHidden = false
        
        guard let email = emailTextfield.text, let password = passwordTextField.text else { return }
        loginViewModel.loginUser(email: email, password: password)
        
        loginActivityIndicator.hidesWhenStopped = true
        loginActivityIndicator.stopAnimating()
    }
    
    func didSuccessfullyLogin(loginModel: LogInModel) {
        print("Login successful. User token is: \(loginModel.token)")
    }

    func didFailLogin(error: Error) {
        print("Login failed. Error: \(error.localizedDescription)")
    }
    
}

