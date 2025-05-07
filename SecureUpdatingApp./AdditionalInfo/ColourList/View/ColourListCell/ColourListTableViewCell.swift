//
//  ColourListTableViewCell.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/05/05.
//

import UIKit
import SwiftHEXColors

class ColourListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var colourView: UIView!
    @IBOutlet weak var colourName: UILabel!
    
    func setColourListCell(details: ColourDetails) {
        colourName.text = details.name
        colourView.backgroundColor = UIColor(hexString: details.color)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        colourView.layer.cornerRadius = colourView.frame.width / 2
        colourView.clipsToBounds = true
    }
}
