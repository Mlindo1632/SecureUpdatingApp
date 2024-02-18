//
//  LogInServiceLayer.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/11.
//

import Foundation

protocol LoginAPIServiceDelegate: AnyObject {
    func loginUser(email: String, password: String, completion: @escaping (Result<LoginModel, Error>) -> Void)
}

class LoginAPIService: LoginAPIServiceDelegate {
    
    func loginUser(email: String, password: String, completion: @escaping (Result<LoginModel, Error>) -> Void) {
        guard let plistPath = Bundle.main.path(forResource: "Reqres-Info", ofType: "plist"),
              let plistData = FileManager.default.contents(atPath: plistPath),
              let plist = try? PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [String: Any],
              let baseURL = plist["reqres_login"] as? String,
              let url = URL(string: baseURL + "login") else {
            completion(.failure(NSError(domain: "LoginServiceError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid API configuration"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let credentials: [String: Any] = ["email": email, "password": password]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: credentials, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard response.statusCode == 200 else {
                completion(.failure(NSError(domain: "Invaild status code", code: response.statusCode, userInfo: nil)))
                return
            }
            do {
                let token = try JSONDecoder().decode(LoginModel.self, from: data)
                completion(.success(token))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
