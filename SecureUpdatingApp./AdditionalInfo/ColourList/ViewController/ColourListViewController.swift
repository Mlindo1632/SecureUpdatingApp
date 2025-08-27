//
//  ColourListViewController.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/05/05.
//

import UIKit

class ColourListViewController: UIViewController {
    
    @IBOutlet weak var colourListView: ColourListView!
    
    var colourListViewModel: ColourListViewModel?
    weak var colourSelectionDelegate: ColourSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setupViewModel()
        fetchColours()
    }
    
    func setUpTableView() {
        colourListView.colourListTableView.delegate = self
        colourListView.colourListTableView.dataSource = self
        colourListView.colourListTableView.register(UINib(nibName: "ColourListTableViewCell", bundle: nil), forCellReuseIdentifier: "ColourListTableViewCell")
    }
    
    private func setupViewModel() {
        let service = ColourListServiceCall()
        colourListViewModel = ColourListViewModel(colourListServiceCall: service)
        
        colourListViewModel?.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.colourListView.colourListTableView.reloadData()
                
                if let error = self?.colourListViewModel?.error {
                    SecureAlertController.showAlert(on: self!, message: error.localizedDescription, title: "Warning")
                }
            }
        }
    }
    
    private func fetchColours() {
        Task {
            await colourListViewModel?.getColours()
        }
    }
    
    deinit {
        print("\(self) has been removed from Memory")
    }
}

extension ColourListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return colourListViewModel!.numberOfColours()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let colour = colourListViewModel!.colour(at: indexPath.row)
        let cell = colourListView.colourListTableView.dequeueReusableCell(withIdentifier: "ColourListTableViewCell") as! ColourListTableViewCell
        cell.setColourListCell(details: colour)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let colour = colourListViewModel?.colour(at: indexPath.row) {
            colourSelectionDelegate?.didSelectColour(colour)
            dismiss(animated: true)
        }
    }
}
