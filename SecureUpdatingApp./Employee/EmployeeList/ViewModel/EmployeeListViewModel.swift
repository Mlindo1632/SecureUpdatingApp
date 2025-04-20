//
//  EmployeeListViewModel.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/04/09.
//

import Foundation

protocol EmployeeListViewModelDelegate: AnyObject {
    func didFetchEmployees()
    func didFailWithError(_ error: Error)
}

class EmployeeListViewModel {
    
    private let employeeListServiceCall: EmployeeListServiceCallProtocol!
    private (set) var employees: [EmployeeDetails] = []
    weak var delegate: EmployeeListViewModelDelegate?
    
    init(employeeListServiceCall: EmployeeListServiceCallProtocol!) {
        self.employeeListServiceCall = employeeListServiceCall
    }
    
    func getEmployees() {
        employeeListServiceCall.getEmployeeList { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let employees):
                    self.employees = employees
                    self.delegate?.didFetchEmployees()
                case .failure(let error):
                    self.delegate?.didFailWithError(error)
                }
            }
        }
    }
    
    func numberOfEmployees() -> Int {
            return employees.count
        }

    func employee(at index: Int) -> EmployeeDetails {
            return employees[index]
        }
    }
