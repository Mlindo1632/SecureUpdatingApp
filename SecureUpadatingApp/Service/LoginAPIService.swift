//
//  LogInServiceLayer.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/11.
//

import Foundation

protocol LoginAPIServiceDelegate: AnyObject {
    func didReceiveLoginResponse(result: Result<LogInModel, Error>)
}

class LoginAPIService {
    
    weak var delegate: LoginAPIServiceDelegate?
    
    func loginUser(email: String, password: String) {
        guard let url = URL(string: "https://reqres.in/api/login") else { return }
        
        let credentials = ["email": email, "password": password]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: credentials)
        } catch {
            print("There was an error sending information into server: \(error.localizedDescription)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                self.delegate?.didReceiveLoginResponse(result: .failure(error))
                return
            }
            
            if let data = data {
                do {
                    let user = try JSONDecoder().decode(LogInModel.self, from: data)
                    self.delegate?.didReceiveLoginResponse(result: .success(user))
                } catch {
                    self.delegate?.didReceiveLoginResponse(result: .failure(error))
                }
            }
        }.resume()
    }
}
