//
//  ColourListTableViewCell.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/05/05.
//

import UIKit

class ColourListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var colourView: UIView!
    @IBOutlet weak var colourName: UILabel!
    
    func setColourListCell(details: ColourDetails) {
        colourName.text = details.name
    }
}
