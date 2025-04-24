//
//  EmployeeListTableViewCell.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/04/13.
//

import UIKit
import Kingfisher

class EmployeeListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var employeeAvatar: UIImageView!
    @IBOutlet weak var employeeFirstName: UILabel!
    @IBOutlet weak var employeeEmail: UILabel!
    
    let roundCorner = RoundCornerImageProcessor(radius: .widthFraction(0.5), roundingCorners: [.topLeft, .bottomRight])
    
    func setEmployeeListCell(details: EmployeeDetails) {
        employeeFirstName.text = "\(details.firstName) \(details.lastName)"
        employeeEmail.text = details.email
        //loadImage(from: details.avatar)
        let url = URL(string: details.avatar)
        employeeAvatar.kf.setImage(with: url, options: [.processor(roundCorner)])
    }
}
