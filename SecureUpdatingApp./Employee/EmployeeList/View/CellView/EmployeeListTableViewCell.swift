//
//  EmployeeListTableViewCell.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/04/13.
//

import UIKit

class EmployeeListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var employeeAvatar: UIImageView!
    @IBOutlet weak var employeeFirstName: UILabel!
    @IBOutlet weak var employeeEmail: UILabel!
    
    func setEmployeeListCell(details: EmployeeDetails) {
        employeeAvatar.layer.cornerRadius = employeeAvatar.layer.bounds.width / 2
        employeeAvatar.clipsToBounds = true
        
        employeeFirstName.text = "\(details.firstName) \(details.lastName)"
        employeeEmail.text = details.email
        loadImage(from: details.avatar)
        
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            employeeAvatar.image = nil
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    self?.employeeAvatar.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}
