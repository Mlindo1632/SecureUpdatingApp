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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeListViewModel?.delegate = self
        setupTableView()
        employeeListViewModel?.getEmployees()
        employeeListView.employeeListTableView.register(UINib(nibName: "EmployeeListTableViewCell", bundle: nil), forCellReuseIdentifier: "EmployeeListTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        employeeListView.employeeListNavigationBar.isTranslucent = false
    }
    
    func setupTableView() {
        employeeListView.employeeListTableView.delegate = self
        employeeListView.employeeListTableView.dataSource = self
    }
    
}
extension EmployeeListViewController: EmployeeListViewModelDelegate {
    func didFetchEmployees() {
        employeeListView.employeeListTableView.reloadData()
        print("Success")
    }
    
    func didFailWithError(_ error: Error) {
        print("FAILED")
        dismiss(animated: true)
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
        dismiss(animated: true)
    }
}

