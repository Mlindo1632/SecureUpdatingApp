//
//  LoginViewModel.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/03/26.
//

import Foundation

class LoginViewModel {
    
    private let loginServiceCall: LoginServiceCallProtocol
    
    var email: String = ""
    var password: String = ""
    
    init(loginServiceCall: LoginServiceCallProtocol) {
        self.loginServiceCall = loginServiceCall
    }
    
     func validateEmail() -> String? {
        if email.isEmpty {
            return "Email cannot be empty."
        } else if !email.hasSuffix("@reqres.in") {
            return "Please enter a valid email address"
        }
        return nil
    }
    
     func validatePassword() -> String? {
        if password.isEmpty {
            return "Password cannot be empty"
        } else if password.count < 6 {
            return "Password needs to be atleast 6 characters."
        }
        return nil
    }
        
        var isFormValid: Bool {
            return validateEmail() == nil && validatePassword() == nil
        }
        
        @MainActor
        func getToken() async throws -> String {
            let response = try await loginServiceCall.loginUser(email: email, password: password)
            
            if let token = response.token {
                return token
            } else {
                throw NSError(
                    domain: "LoginError",
                    code: 0,
                    userInfo: [NSLocalizedDescriptionKey: response.error ?? "Unknown Error"]
            )}
        }
    }
