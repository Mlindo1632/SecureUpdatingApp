//
//  EmployeeListServiceCall.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/04/09.
//

import Foundation

protocol EmployeeListServiceCallProtocol {
    func getEmployeeList(completion: @escaping (Result<[EmployeeDetails], APIError>) -> Void)
}

struct EmployeeListServiceCall: EmployeeListServiceCallProtocol {
    
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func getEmployeeList(completion: @escaping (Result<[EmployeeDetails], APIError>) -> Void) {
        
        let endpoint = SecurePlistReader.readValue(key: "ReqresUsersDetails")!

        networkManager.request(endpoint: endpoint,
                               method: .get,
                               parameters: nil,
                               headers: nil
        ) {(result: Result<EmployeeListModel, APIError>) in
            switch result {
            case .success(let response):
                print("Decoding employees success")
                completion(.success(response.data))
            case .failure(let error):
                print("Error: \(error)")
                completion(.failure(error))
            }
        }
    }
}
