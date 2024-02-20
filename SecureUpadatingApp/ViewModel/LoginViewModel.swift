//
//  LoginViewModel.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/13.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    
    func didSuccessfullyLogin(loginModel: LoginModel)
    func didFailLogin(error: Error)
    func validateTextfields(withError error: String)
}

class LoginViewModel: LoginAPIServiceDelegate {
    
    weak var delegate: LoginViewModelDelegate?
    
    private let loginRepository: LoginRepository
    
    init(loginRepository: LoginRepository) {
        self.loginRepository = loginRepository
        self.loginRepository.loginAPIService.delegate = self
    }
    
        func validate(email: String, password: String) -> Bool {
            guard !email.isEmpty, !password.isEmpty else {
                delegate?.validateTextfields(withError: "Please enter both email and password.")
                return false
            }
            return true
        }
    
    func loginUser(email: String, password: String) {
        guard validate(email: email, password: password) else {
            return
        }
        loginRepository.loginUser(email: email, password: password)
    }
    
    func didReceiveResponse(result: Result<LoginModel, Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let user):
                self.delegate?.didSuccessfullyLogin(loginModel: user )
            case .failure(let error):
                self.delegate?.didFailLogin(error: error)
                
            }
        }
    }
}
