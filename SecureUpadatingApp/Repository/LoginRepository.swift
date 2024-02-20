//
//  LogInRepositoryLayer.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/11.
//

import Foundation

class LoginRepository {
   let loginAPIService: LoginAPIService
    
    init(loginAPIService: LoginAPIService) {
        self.loginAPIService = loginAPIService
    }
    
    func loginUser(email: String, password: String) {
        loginAPIService.loginUser(email: email, password: password)
    }
}
