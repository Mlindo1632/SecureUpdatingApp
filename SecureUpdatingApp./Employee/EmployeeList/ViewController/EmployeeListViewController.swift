//
//  EmployeeListViewController.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/04/08.
//

import UIKit

class EmployeeListViewController: UIViewController {
    
    @IBOutlet weak var employeeListView: EmployeeListView!
    
     var employeeListViewModel: EmployeeListViewModel?
     weak var selectionDelegate: EmployeeSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupViewModel()
        fetchEmployees()
    }
    
    private func setupTableView() {
        employeeListView.employeeListTableView.delegate = self
        employeeListView.employeeListTableView.dataSource = self
        employeeListView.employeeListTableView.register(UINib(nibName: "EmployeeListTableViewCell", bundle: nil), forCellReuseIdentifier: "EmployeeListTableViewCell")
    }
    
    private func setupViewModel() {
        let service = EmployeeListServiceCall()
        employeeListViewModel = EmployeeListViewModel(employeeListServiceCall: service)
        
        employeeListViewModel?.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.employeeListView.employeeListTableView.reloadData()
                
                if let error = self?.employeeListViewModel?.error {
                    SecureAlertController.showAlert(on: self!, message: error.localizedDescription, title: "Warning")
                    self?.dismiss(animated: true)
                }
            }
        }
    }
 
    private func fetchEmployees() {
        Task {
           await employeeListViewModel?.getEmployees()
        }
    }
    
    deinit {
        print("\(self) has been removed from Memory")
    }
}

extension EmployeeListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeListViewModel!.numberOfEmployees()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let employee = employeeListViewModel!.employee(at: indexPath.row)
        let cell = employeeListView.employeeListTableView.dequeueReusableCell(withIdentifier: "EmployeeListTableViewCell") as! EmployeeListTableViewCell
        cell.setEmployeeListCell(details: employee)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let employee = employeeListViewModel?.employee(at: indexPath.row){
            selectionDelegate?.didSelectEmployee(employee)
            dismiss(animated: true)
        }
    }
}

