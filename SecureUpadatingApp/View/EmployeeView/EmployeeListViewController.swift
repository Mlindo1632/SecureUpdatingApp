//
//  EmployeeListViewController.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/17.
//

import UIKit

class EmployeeListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,EmployeeListViewModelDelegate  {

    @IBOutlet  private var tableView: UITableView!
    
    private var employeeListViewModel: EmployeeListViewModel!
    private var employeeList: EmployeeListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.hidesBackButton = true
        setUpViewModel()
        employeeListViewModel.getEmployees()
    }
    
    func setUpViewModel() {
        let employeeListAPIService = EmployeeListAPIService()
        let employeeListRepository = EmployeeListRepository(employeeListAPIService: employeeListAPIService)
        employeeListViewModel = EmployeeListViewModel(employeeListRepository: employeeListRepository)
        employeeListViewModel.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func didReceiveList(employeeList: EmployeeListModel) {
        
        self.employeeList = employeeList
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didNotReceiveList(error: Error) {
        print("Failed to print employees. Error: \(error.localizedDescription)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeList?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as! EmployeeListTableViewCell
        let emp = employeeList?.data[indexPath.row]
        cell.fullNameLabel.text = "\(emp?.firstName ?? "") \(emp?.lastName ?? "")"
        cell.emailLabel.text = "\(emp?.email ?? "")"
        
        if let url = URL(string: emp?.avatar ?? "") {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.avatarImageView.image = image
                    }
                }
            }.resume()
        }
        return cell
    }
    
    func tableView (_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Cell", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Cell", let indexPath = sender as? IndexPath {
            let destinationVC = segue.destination as! SelectEmployeeViewController
            let selectedEmployee = employeeList?.data[indexPath.row]
            destinationVC.employeeData = selectedEmployee
        }
    }
}
