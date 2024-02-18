//
//  ReviewViewController.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/28.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet var reviewFullName: UILabel!
    
    var reviewData: Employee?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        updateUI()
    }
    
    private func updateUI() {
        guard let reviewData = reviewData else { return }
        reviewFullName.text = "\(reviewData.firstName ?? "ll") \(reviewData.lastName ?? "ll")"
    }
}
