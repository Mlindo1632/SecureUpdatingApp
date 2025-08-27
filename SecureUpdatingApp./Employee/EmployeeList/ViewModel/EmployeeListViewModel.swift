//
//  EmployeeListViewModel.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/04/09.
//

import Foundation

protocol EmployeeSelectionDelegate: AnyObject {
    func didSelectEmployee(_ employee: EmployeeDetails)
}

class EmployeeListViewModel {
    
    private let employeeListServiceCall: EmployeeListServiceCallProtocol!
    private(set) var employees: [EmployeeDetails] = []
    private(set) var error: Error?

    var onUpdate: (() -> Void)?
    
    init(employeeListServiceCall: EmployeeListServiceCallProtocol) {
        self.employeeListServiceCall = employeeListServiceCall
    }
    
    @MainActor
    func getEmployees() async {
        do {
            let employees = try await employeeListServiceCall.getEmployeeList()
            self.employees = employees
            self.error = nil
        } catch {
            self.error = error
        }
        onUpdate?()
    }
    
    func numberOfEmployees() -> Int {
        return employees.count
    }

    func employee(at index: Int) -> EmployeeDetails {
        return employees[index]
    }
}
