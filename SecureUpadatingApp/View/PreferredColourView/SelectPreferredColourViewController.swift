//
//  SelectPreferredColourViewController.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/21.
//

import UIKit

class SelectPreferredColourViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,  PreferredColourListViewModelDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    private var preferredColourListViewModel: PreferredColourListViewModel!
    private var preferredColourList: PreferredColourModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.hidesBackButton = true
        setUpViewModel()
        preferredColourListViewModel.getPreferredColourList()
    }
    
    func setUpViewModel() {
        let preferredColourAPIService = PreferredColourAPIService()
        let preferredColourRepository = PreferredColourRepository(preferredColourAPIService: preferredColourAPIService)
        preferredColourListViewModel = PreferredColourListViewModel(preferredColourListRepository: preferredColourRepository)
        preferredColourListViewModel.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func didReceiveList(preferredColourList: PreferredColourModel) {
        self.preferredColourList = preferredColourList
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func didNotReceiveList(error: Error) {
        print("Failed to print colours. Error: \(error.localizedDescription)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        preferredColourList?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    let cell = tableView.dequeueReusableCell(withIdentifier: "ColourDetails", for: indexPath) as! PreferredColourTableViewCell
        let preferrdColor = preferredColourList?.data[indexPath.row]
        cell.preferredColourNameLabel.text = "\(preferrdColor?.name ?? "")"
        cell.actualColourUIView?.backgroundColor = UIColor(named: preferrdColor?.color ?? "")
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//    }
}
