//
//  LoginViewModel.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/03/26.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func didUpdateEmailValidation(isValid: Bool, errorMessage: String?)
    func didUpdatePasswordValidation(isValid: Bool, errorMessage: String?)
    func didUpdateFormValidation(isValid: Bool)
    func didGetToken(token: LoginTokenModel)
    func didFailToGetToken(error: Error)
}

class LoginViewModel {
    
    private let loginServiceCallProtocol: LoginServiceCallProtocol
    
    weak var delegate: LoginViewModelDelegate?
    private var token: String?
    
    var email: String = "" {
        didSet { validateEmail()}
    }
    var password: String = "" {
        didSet { validatePassword()}
    }
    
    init(loginServiceCallProtocol: LoginServiceCallProtocol) {
        self.loginServiceCallProtocol = loginServiceCallProtocol
    }
    
    private func validateEmail() {
        if email.isEmpty {
            delegate?.didUpdateEmailValidation(isValid: false, errorMessage: "Email cannot be empty.")
        } else if !email.hasSuffix("@reqres.in") {
            delegate?.didUpdateEmailValidation(isValid: false, errorMessage: "Please enter a valid email address")
        } else {
            delegate?.didUpdateEmailValidation(isValid: true, errorMessage: nil)
        }
        validateForm()
    }
    
    private func validatePassword() {
        if password.isEmpty {
            delegate?.didUpdatePasswordValidation(isValid: false, errorMessage: "Password cannot be empty")
        } else if password.count < 6 {
            delegate?.didUpdatePasswordValidation(isValid: false, errorMessage: "Password needs to be atleast 6 characters.")
        } else {
            delegate?.didUpdatePasswordValidation(isValid: true, errorMessage: nil)
        }
        validateForm()
    }
    
    private func validateForm() {
        let isEmailValid = email.range(of: "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$", options: .regularExpression) != nil
        let isPasswordValid = password.count >= 6
        
        delegate?.didUpdateFormValidation(isValid: isEmailValid && isPasswordValid)
    }
    
    func getToken() {
        loginServiceCallProtocol.loginUser(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let token):
                    self.token = token.token
                    self.delegate?.didGetToken(token: token)
                case .failure(let error):
                    self.delegate?.didFailToGetToken(error: error)
                }
            }
        }
    }
}
