//
//  LoginServiceCallTests.swift
//  SecureUpdatingApp.Tests
//
//  Created by Lindokuhle Khumalo on 2025/03/26.
//

import XCTest
@testable import SecureUpdatingApp_

final class LoginServiceCallTests: XCTestCase {
    var networkManagerMock: NetworkManagerMock!
    var loginService: LoginServiceCall!
    
    override func setUp() {
        super.setUp()
        networkManagerMock = NetworkManagerMock()
        loginService = LoginServiceCall(networkManager: networkManagerMock)
    }
    
    func testDecodingLoginTokenModelSuccess() {
        networkManagerMock.shouldSuccesed = true
        
        loginService.loginUser(email: "JamesFredricks@reqres.in", password: "Pass190E")
        
        XCTAssertEqual(networkManagerMock.capturedEndpoint, SecurePlistReader.readValue(key: "ReqResLoginDetails"))
        XCTAssertEqual(networkManagerMock.capturedParameters?["email"] as? String, "JamesFredricks@reqres.in")
        XCTAssertEqual(networkManagerMock.capturedParameters?["password"] as? String, "Pass190E")
    }
    
    func testLoginTokenModelFailure() {
        networkManagerMock.shouldSuccesed = false
        
        loginService.loginUser(email: "JamesFredricks@reqres.in", password: "Fail190E")
        
        XCTAssertEqual(networkManagerMock.capturedEndpoint, SecurePlistReader.readValue(key: "ReqResLoginDetails"))
        XCTAssertEqual(networkManagerMock.capturedParameters?["email"] as? String, "JamesFredricks@reqres.in")
        XCTAssertEqual(networkManagerMock.capturedParameters?["password"] as? String, "Fail190E")
    }
    
    func testDecodingLoginModelFailureWhenEmailIsNotGiven() {
        networkManagerMock.shouldSuccesed = false
        
        loginService.loginUser(email: "", password: "Pass190E")
        
        XCTAssertEqual(networkManagerMock.capturedEndpoint, SecurePlistReader.readValue(key: "ReqResLoginDetails"))
        XCTAssertEqual(networkManagerMock.capturedParameters?["email"] as? String, "")
        XCTAssertEqual(networkManagerMock.capturedParameters?["password"] as? String, "Pass190E")
    }
    
    func testDecodingLoginModelFailureWhenPasswordIsNotGiven() {
        networkManagerMock.shouldSuccesed = false
        
        loginService.loginUser(email: "Fredricks@reqres.in", password: "")
        
        XCTAssertEqual(networkManagerMock.capturedEndpoint, SecurePlistReader.readValue(key: "ReqResLoginDetails"))
        XCTAssertEqual(networkManagerMock.capturedParameters?["email"] as? String, "Fredricks@reqres.in")
        XCTAssertEqual(networkManagerMock.capturedParameters?["password"] as? String, "")
    }
    
    func testDecodingLoginModelFailureWhenEmailAndPasswordAreNotGiven() {
        networkManagerMock.shouldSuccesed = false
        
        loginService.loginUser(email: "", password: "")
        
        XCTAssertEqual(networkManagerMock.capturedEndpoint, SecurePlistReader.readValue(key: "ReqResLoginDetails"))
        XCTAssertEqual(networkManagerMock.capturedParameters?["email"] as? String, "")
        XCTAssertEqual(networkManagerMock.capturedParameters?["password"] as? String, "")

    }
}
