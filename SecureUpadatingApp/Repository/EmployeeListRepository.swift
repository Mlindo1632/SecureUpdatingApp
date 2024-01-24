//
//  ListOfEmployeesRepository.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/17.
//

import Foundation

class EmployeeListRepository {
    
    let employeeListAPIService: EmployeeListAPIService
    
    init(employeeListAPIService: EmployeeListAPIService) {
        self.employeeListAPIService = employeeListAPIService
    }
    
    func getEmployees() {
        employeeListAPIService.getEmployees()
    }
}
