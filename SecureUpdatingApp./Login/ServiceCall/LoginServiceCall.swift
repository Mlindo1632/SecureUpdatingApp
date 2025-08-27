//
//  LoginServiceCall.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/03/26.
//

import Foundation

protocol LoginServiceCallProtocol {
    func loginUser(email: String, password: String) async throws -> LoginTokenModel
}

struct LoginServiceCall: LoginServiceCallProtocol {
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
           self.networkManager = networkManager
       }
    
    func loginUser(email: String, password: String) async throws -> LoginTokenModel{
        let endpoint = SecurePlistReader.readValue(key: "ReqresLoginDetails")!
        
        let parameters: [String: Any] = ["email": email, "password": password]
        
        let headers = ["x-api-key": "reqres-free-v1"]
        
        let response: LoginTokenModel = try await networkManager.request(endpoint: endpoint,
                                                                         method: HTTPMethod.post,
                                                                         parameters: parameters,
                                                                         headers: headers
        )
        return response
    }
}
