//
//  ColourListServiceCall.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/05/05.
//

import Foundation

protocol ColourListServiceCallProtocol {
    func getColourList(completion: @escaping (Result<[ColourDetails], APIError>) -> Void)
}

struct ColourListServiceCall: ColourListServiceCallProtocol {
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func getColourList(completion: @escaping (Result<[ColourDetails], APIError>) -> Void) {
        
        let endpoint = SecurePlistReader.readValue(key: "ReqresColourDetails")!
        
        let headers = ["x-api-key": "reqres-free-v1"]
        
        networkManager.request(endpoint: endpoint,
                               method: .get,
                               parameters: nil,
                               headers: headers
        ) {(result: Result<ColourListModel, APIError>) in
            switch result {
            case .success(let response):
                print("Decoding colours success")
                completion(.success(response.data))
            case .failure(let error):
                print("Failed to decode colours. Error: \(error)")
                completion(.failure(error))
            }
        }
                               
    }
    
}

