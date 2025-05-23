//
//  LoginServiceCall.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/03/26.
//

import Foundation

protocol LoginServiceCallProtocol {
    func loginUser(email: String, password: String, completion: @escaping (Result<LoginTokenModel, Error>) -> Void)
}

struct LoginServiceCall: LoginServiceCallProtocol {
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
           self.networkManager = networkManager
       }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<LoginTokenModel, Error>) -> Void) {
        let endpoint = SecurePlistReader.readValue(key: "ReqresLoginDetails")!
        
        let parameters: [String: Any] = ["email": email, "password": password]
        
        let headers = [ "x-api-key": "reqres-free-v1"]
        
                networkManager.request(endpoint: endpoint,
                                      method: .post,
                                      parameters: parameters,
                                      headers: headers
        ) {(result: Result<LoginTokenModel, APIError>) in
            switch result {
            case .success(let token):
                print("Decoding token success")
                completion(.success(token))
            case .failure(let error):
                print("Failed to decode token. Error: \(error)")
                completion(.failure(error))
            }
        }
    }
}
