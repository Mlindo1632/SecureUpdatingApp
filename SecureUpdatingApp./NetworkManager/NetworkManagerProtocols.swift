//
//  NetworkManagerProtocols.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/03/26.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case unknownError
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol NetworkManagerProtocol {
    func request<T: Codable>(
        endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: [String: String]?,
        completion: @escaping (Result<T, APIError>) -> Void
    )
}

protocol NetworkManagerDelegate: AnyObject {
    func didDecodeData<T: Decodable>(_ data: T)
    func didFail(_ error: APIError)
}

