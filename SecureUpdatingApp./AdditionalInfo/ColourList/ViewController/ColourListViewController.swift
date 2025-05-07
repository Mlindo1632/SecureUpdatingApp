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
        
        colourListViewModel?.delegate = self
        setUpTableView()
        colourListViewModel?.getColours()
        colourListView.colourListTableView.register(UINib(nibName: "ColourListTableViewCell", bundle: nil), forCellReuseIdentifier: "ColourListTableViewCell")
    }
    
    func setUpTableView() {
        colourListView.colourListTableView.delegate = self
        colourListView.colourListTableView.dataSource = self
    }
}
    
extension ColourListViewController: ColourListViewModelDelegate {
    func didFetchColours() {
        print("Success. Displaying Colour details")
        colourListView.colourListTableView.reloadData()
    }
    
    func didFailWithError(_ error: Error) {
        print("Failed to display colours")
        dismiss(animated: true)
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
