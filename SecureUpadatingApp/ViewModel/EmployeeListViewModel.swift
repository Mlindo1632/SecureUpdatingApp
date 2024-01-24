//
//  ListOfEmployeesViewModel.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/17.
//

import Foundation

protocol EmployeeListViewModelDelegate: AnyObject {
    func didReceiveList(employeeList: EmployeeListModel)
    func didNotReceiveList(error: Error)
}

class EmployeeListViewModel: EmployeeListAPIServiceDelegate {
    
    weak var delegate: EmployeeListViewModelDelegate?
    
    private let employeeListRepository: EmployeeListRepository
    
    init(employeeListRepository: EmployeeListRepository) {
        self.employeeListRepository = employeeListRepository
        self.employeeListRepository.employeeListAPIService.delegate = self
    }
    
    func getEmployees() {
        employeeListRepository.getEmployees()
    }
    
    func didReceiveList(result: Result<EmployeeListModel, Error>) {
        switch result {
        case .success(let employees):
            delegate?.didReceiveList(employeeList: employees)
        case .failure(let error):
            delegate?.didNotReceiveList(error: error)
        }
    }
}
