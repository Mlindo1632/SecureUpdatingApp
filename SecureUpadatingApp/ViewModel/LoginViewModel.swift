//
//  LoginViewModel.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/13.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    
    func didSuccessfullyLogin(loginModel: LogInModel)
    func didFailLogin(error: Error)
   
}

class LoginViewModel: LoginAPIServiceDelegate {
    
    weak var delegate: LoginViewModelDelegate?
    
    private let loginRepository: LoginRepository
    
    init(loginRepository: LoginRepository) {
        self.loginRepository = loginRepository
        self.loginRepository.loginAPIService.delegate = self
    }
    
    func loginUser(email: String, password: String) {
        loginRepository.loginUser(email: email, password: password)
    }
    
    func didReceiveLoginResponse(result: Result<LogInModel, Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let user):
                self.delegate?.didSuccessfullyLogin(loginModel: user)
                
            case .failure(let error):
                self.delegate?.didFailLogin(error: error)
            }
        }
    }
}
