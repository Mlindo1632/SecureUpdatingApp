//
//  LogInRepositoryLayer.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/11.
//

import Foundation

class LoginRepository {
   let loginAPIService: LoginAPIServiceDelegate
    
    init(loginAPIService: LoginAPIServiceDelegate = LoginAPIService()) {
        self.loginAPIService = loginAPIService
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<LoginModel, Error>) -> Void) {
        loginAPIService.loginUser(email: email, password: password, completion: completion)
    }
}
