//
//  ColourListServiceCall.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/05/05.
//

import Foundation

protocol ColourListServiceCallProtocol {
    func getColourList() async throws -> [ColourDetails]
}

struct ColourListServiceCall: ColourListServiceCallProtocol {
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func getColourList() async throws -> [ColourDetails] {
        
        guard let endpoint = SecurePlistReader.readValue(key: "ReqresColourDetails") else {
            throw URLError(.badURL)
        }
        
        let headers = ["x-api-key": "reqres-free-v1"]
        
        let colours: ColourListModel = try await networkManager.request(
            endpoint: endpoint,
            method: HTTPMethod.get,
            parameters: nil,
            headers: headers
        )
        return colours.data
    }
}

