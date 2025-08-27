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
}

class LoginViewModel {
    
    private let loginServiceCall: LoginServiceCallProtocol
    
    weak var delegate: LoginViewModelDelegate?
    private var token: String?
    
    var onSuccess: ((LoginTokenModel) -> Void)?
    var onFailure: ((Error) -> Void)?
    
    var email: String = "" {
        didSet { validateEmail()}
    }
    var password: String = "" {
        didSet { validatePassword()}
    }
    
    init(loginServiceCall: LoginServiceCallProtocol) {
        self.loginServiceCall = loginServiceCall
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
    
    @MainActor
    func getToken() {
        Task {
            do {
                let response = try await loginServiceCall.loginUser(email: email, password: password)
                
                if let token = response.token {
                    onSuccess?(response)
                } else if let errorMessage = response.error {
                    let apiError = NSError(domain: "", code: 0,
                                           userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    onFailure?(apiError)
                }
            } catch {
                onFailure?(error)
            }
        }
    }
}
