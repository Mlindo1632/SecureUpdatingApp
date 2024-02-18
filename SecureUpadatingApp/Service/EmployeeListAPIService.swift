//
//  ListOfEmployeesAPIService.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/16.
//

import Foundation

protocol EmployeeListAPIServiceDelegate: AnyObject {
    func didReceiveList(result: Result<EmployeeListModel, Error>)
}

class EmployeeListAPIService {
    
    weak var delegate: EmployeeListAPIServiceDelegate?
    
    func getEmployees() {
        guard let url = URL(string: "https://reqres.in/api/users?page=1&per_page=12") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
          
            if let data = data {
                do {
                    let empList = try JSONDecoder().decode(EmployeeListModel.self, from: data)
                    self.delegate?.didReceiveList(result: .success(empList))
                } catch {
                    self.delegate?.didReceiveList(result: .failure(error))
                }
            }
        }.resume()
    }
}

// trying to implement below

//protocol EmployeeListAPIServiceDelegate: AnyObject {
//    func didReceiveList(result: Result<EmployeeListModel, Error>)
//}
//
//class EmployeeListAPIService: APIService {
//    
//    let apiService = APIService()
//    
//    apiService.fetchData(from: URL(string: "https://reqres.in/api/login"), completion: <#T##(Result<T, Error>) -> Void#>
//}
//    

