//
//  ReviewViewController.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/05/13.
//

import UIKit
import SwiftHEXColors

class ReviewViewController: UIViewController {
    
    @IBOutlet weak var reviewView: ReviewView!
    var formData: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "REVIEW"
        
        reviewView.reviewColourNameLabel.text = "Colour: \(formData["preferredColour"] as? String ?? "" )"
        reviewView.reviewColourView.backgroundColor = UIColor(hexString: "\(formData["colour"] ?? "")")
        reviewView.reviewResidentialAddress.text = "Address: \(formData["residentialAddress"] ?? "")"
        reviewView.reviewGenderLabel.text = "Gender: \(formData["gender"] ?? "")"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        reviewView.reviewColourView.layer.masksToBounds = true
        reviewView.reviewColourView.layer.cornerRadius = reviewView.reviewColourView.frame.height / 2
        reviewView.reviewColourView.layer.borderWidth = 4
        reviewView.reviewColourView.layer.borderColor = UIColor.white.cgColor
    }
}
