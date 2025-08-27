//
//  EmployeeListServiceCall.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/04/09.
//

import Foundation

protocol EmployeeListServiceCallProtocol {
    func getEmployeeList() async throws -> [EmployeeDetails]
}

struct EmployeeListServiceCall: EmployeeListServiceCallProtocol {
    
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func getEmployeeList() async throws -> [EmployeeDetails] {
        
        guard let endpoint = SecurePlistReader.readValue(key: "ReqresUsersDetails") else {
            throw URLError(.badURL)
        }
        
        let headers = ["x-api-key": "reqres-free-v1"]
        
        let response: EmployeeListModel = try await networkManager.request(
            endpoint: endpoint,
            method: .get,
            parameters: nil,
            headers: headers
        )
        
        return response.data
    }
}
