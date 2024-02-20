//
//  LogInServiceLayer.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/11.
//

import Foundation

protocol LoginAPIServiceDelegate: AnyObject {
    func didReceiveResponse(result: Result<LoginModel, Error>)
}

class LoginAPIService {
    
    weak var delegate: LoginAPIServiceDelegate?
    
    func loginUser(email: String, password: String) {
        guard let plistPath = Bundle.main.path(forResource: "Reqres-Info", ofType: "plist"),
              let plistData = FileManager.default.contents(atPath: plistPath),
              let plist = try? PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [String: Any],
              let baseURL = plist["reqres_login"] as? String,
              let url = URL(string: baseURL + "login") else {
            return
        }
        let credentials = ["email": email, "password": password]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: credentials)
        } catch {
            print("There was an error send information to the server \(error.localizedDescription)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                return
            }
            
            guard response.statusCode == 200 else {
                print(NSError(domain: "Invaild status code", code: response.statusCode, userInfo: nil))
                return
            }
            
            do {
                let token = try JSONDecoder().decode(LoginModel.self, from: data)
                self.delegate?.didReceiveResponse(result: .success(token))
            } catch {
                self.delegate?.didReceiveResponse(result: .failure(error))
            }
        }
        task.resume()
    }
}
