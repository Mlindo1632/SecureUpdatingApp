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
        employeeFirstName.text = "\(details.firstName) \(details.lastName)"
        employeeEmail.text = details.email
        SecureImageHelper.downloadAndCache(from: details.avatar, into: employeeAvatar)
    }
}
