//
//  PreferredColourAPIService.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/21.
//

import Foundation

protocol PreferredColourAPIServiceDelegate: AnyObject {
    func didReceiveList(result: Result<PreferredColourModel, Error>)
}

class PreferredColourAPIService {
    
    weak var delegate: PreferredColourAPIServiceDelegate?
    
    func getPreferredColourList() {
        guard let url = URL(string: "https://reqres.in/api/unknown?per_page=12") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let preferredColourList = try JSONDecoder().decode(PreferredColourModel.self, from: data)
                    self.delegate?.didReceiveList(result: .success(preferredColourList))
                } catch {
                    self.delegate?.didReceiveList(result: .failure(error))
                }
            }
        }.resume()
    }
}
