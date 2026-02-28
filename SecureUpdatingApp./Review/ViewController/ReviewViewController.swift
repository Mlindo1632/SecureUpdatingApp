//
//  ReviewViewController.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/05/13.
//

import UIKit
import SwiftHEXColors
import Kingfisher

class ReviewViewController: UIViewController {
    
    @IBOutlet weak var reviewView: ReviewView!
    var selectedColour: ColourDetails?
    var employee: EmployeeDetails?
    var birthPlaceDetails: BirthPlaceDetails?
    var additionalInfoDetails: AdditionalInfoDetails?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "REVIEW"
        
        reviewView.reviewColourNameLabel.text = "Colour: \(selectedColour?.name ?? "")"
        reviewView.reviewColourView.backgroundColor = UIColor(hexString: selectedColour?.color ?? "")
        reviewView.reviewFullNameLabel.text = "FullName: \(employee?.firstName ?? "") \(employee?.lastName ?? "")"
        reviewView.reviewEmailLabel.text = "Email: \(employee?.email ?? "")"
        reviewView.reviewDOBLabel.text = "D.O.B: \(birthPlaceDetails?.dateOfBirth ?? "")"
        reviewView.reviewPlaceOfBirthLabel.text = "Place of Birth: \(birthPlaceDetails?.placeOfBirth ?? "")"
        reviewView.reviewResidentialAddress.text = "Residential Address: \(additionalInfoDetails?.residentialAddress ?? "")"
        reviewView.reviewGenderLabel.text = "Gender: \(additionalInfoDetails?.gender ?? "")"
        SecureImageHelper.loadCachedImage(from: employee?.avatar ?? "", into: reviewView.reviewImageView)
        
        setUpReviewButton()
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
    
    func setUpReviewButton() {
        reviewView.reviewSubmitButton.addTarget(self, action: #selector(reviewSubmitButtonPressed), for: .touchUpInside)
    }
    
    @objc func reviewSubmitButtonPressed() {
        SecureNavigation.endFlow(using: navigationController)
        }
    
    deinit {
        print("\(self) has been removed from Memory")
    }
}
