//
//  APIService.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/02/09.
//

import Foundation

protocol APIServiceProtocol: AnyObject {
    func fetchData<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

class APIService: APIServiceProtocol {
    
    func fetchData<T>(from url: URL, completion : @escaping (Result<T, Error>) -> Void) where T : Decodable {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
