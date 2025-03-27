//
//  LoginServiceCallMock.swift
//  SecureUpdatingApp.Tests
//
//  Created by Lindokuhle Khumalo on 2025/03/26.
//

import Foundation
@testable import SecureUpdatingApp_

class LoginServiceCallMock: LoginServiceCallProtocol {
    var loginCalled = false
    var captureEmail: String?
    var capturedPassword: String?
    
    func loginUser(email: String, password: String) {
        loginCalled = true
        captureEmail = email
        capturedPassword = password
    }
}
