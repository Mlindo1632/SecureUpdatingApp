//
//  LoginViewModel.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/13.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    
    func didSuccessfullyLogin(token: String)
    func didFailLogin(error: Error)
    //func validateTextfields(withError error: String)
}

class LoginViewModel {
    
    weak var delegate: LoginViewModelDelegate?
    
    let loginRepository: LoginRepository
    
    init(loginRepository: LoginRepository = LoginRepository()) {
        self.loginRepository = loginRepository
    }
    
    //    func validate(email: String, password: String) -> Bool {
    //        guard email.isEmpty, password.isEmpty else {
    //            delegate?.validateTextfields(withError: "Please enter both email and password.")
    //            return false
    //        }
    //        return true
    //    }
    
    func loginUser(email: String, password: String) {
        loginRepository.loginUser(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let loginModel):
                    self?.delegate?.didSuccessfullyLogin(token: loginModel.token)
                case .failure(let error):
                    self?.delegate?.didFailLogin(error: error)
                }
            }
        }
    }
}
