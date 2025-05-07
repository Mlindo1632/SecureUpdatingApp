//
//  AdditionalInfoViewController.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/05/04.
//

import UIKit
import SwiftHEXColors

class AdditionalInfoViewController: UIViewController {
    
    private var nextBarButton: UIBarButtonItem!
    @IBOutlet weak var additionalInfoView: AdditionalInfoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Additinal Information"
        setupNextBarButton()
        setupSelectColourButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        additionalInfoView.preferredColourView.layer.cornerRadius = additionalInfoView.preferredColourView.layer.bounds.width / 2
        additionalInfoView.preferredColourView.layer.borderWidth = 3.69
        additionalInfoView.preferredColourView.layer.borderColor = UIColor.white.cgColor
        additionalInfoView.preferredColour.font = UIFont(name: "Helvetica-Bold", size: 17)
    }
    
    private func setupNextBarButton() {
       nextBarButton = UIBarButtonItem(title: "NEXT", style: .plain, target: self, action: #selector(goToReview))
       nextBarButton.isEnabled = false
       navigationItem.rightBarButtonItem = nextBarButton
   }
    
    func setupSelectColourButton() {
        additionalInfoView.selectColourButton.addTarget(self, action: #selector(selectColourButtonPressed), for: .touchUpInside)
    }
    
    @objc func goToReview() {
        
    }
    
    @objc func selectColourButtonPressed() {
        let colourListViewController = ColourListViewController(nibName: "ColourListViewController", bundle: nil)
        let serviceCall = ColourListServiceCall()
        let viewModel = ColourListViewModel(colourListServiceCall: serviceCall)
        colourListViewController.colourListViewModel = viewModel
        colourListViewController.colourSelectionDelegate = self
        
        SecureModalPresenter.present(colourListViewController, from: self)
    }
}

extension AdditionalInfoViewController: ColourSelectionDelegate {
    
    func didSelectColour(_ colour: ColourDetails) {
        additionalInfoView.preferredColour.text = colour.name
        additionalInfoView.preferredColourView.backgroundColor = UIColor(hexString: colour.color)
        
        additionalInfoView.colourDetailsView.isHidden = false
    }
}
