//
//  LoginViewModelTests.swift
//  SecureUpdatingApp.Tests
//
//  Created by Lindokuhle Khumalo on 2025/03/27.
//

import XCTest
@testable import SecureUpdatingApp_

final class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!
    var serviceCallMock: LoginServiceCallMock!
    var delegateMock: LoginViewModelDelegateMock!
    
    override func setUp() {
        serviceCallMock = LoginServiceCallMock()
        delegateMock = LoginViewModelDelegateMock()
        viewModel = LoginViewModel(loginServiceCallProtocol: serviceCallMock)
        viewModel.delegate = delegateMock
    }
    
    override func tearDown() {
        viewModel = nil
        serviceCallMock = nil
        delegateMock = nil
        super.tearDown()
    }
    
    func testEmptyEmailShouldFailValidation() {
            viewModel.email = ""
            XCTAssertEqual(delegateMock.emailValidation?.isValid, false)
            XCTAssertEqual(delegateMock.emailValidation?.errorMessage, "Email cannot be empty.")
        }
    func testEmailShouldFailValidation() {
        viewModel.email = "James.Fredricks@gmail.com"
        XCTAssertEqual(delegateMock.emailValidation?.isValid, false)
        XCTAssertEqual(delegateMock.emailValidation?.errorMessage, "Please enter a valid email address")
    }
    
    func testEmailShouldPassValidation() {
        viewModel.email = "JamesFredricks@reqres.in"
        XCTAssertEqual(delegateMock.emailValidation?.isValid, true)
        XCTAssertNil(delegateMock.emailValidation?.errorMessage)
    }
    
    func testEmptyPasswordShouldFailVallidation() {
        viewModel.password = ""
        XCTAssertEqual(delegateMock.passwordValidation?.isValid, false)
        XCTAssertEqual(delegateMock.passwordValidation?.errorMessage, "Password cannot be empty")
    }
    
    func testPasswordShouldFailValidation() {
        viewModel.password = "1234"
        XCTAssertEqual(delegateMock.passwordValidation?.isValid, false)
        XCTAssertEqual(delegateMock.passwordValidation?.errorMessage, "Password needs to be atleast 6 characters.")
    }
    
    func testPasswordShouldPassValidation() {
        viewModel.password = "123456"
        XCTAssertEqual(delegateMock.passwordValidation?.isValid, true)
        XCTAssertNil(delegateMock.passwordValidation?.errorMessage)
    }
    
    func testInvalidFormWhenEmailIsInvalid() {
        viewModel.email = "JamesFredricks"
        viewModel.password = "123456"
        XCTAssertEqual(delegateMock.formValidation, false)
    }
    
    func testInvalidFormWhenPasswordIsTooShort() {
        viewModel.email = "JamesFredricks@reqres.in"
        viewModel.password = "12345"
        XCTAssertEqual(delegateMock.formValidation, false)
    }
    
    func testFormWhenEmailAndPasswordAreValid() {
        viewModel.email = "JamesFredricks@reqres.in"
        viewModel.password = "123456"
        XCTAssertEqual(delegateMock.formValidation, true)
    }
}
