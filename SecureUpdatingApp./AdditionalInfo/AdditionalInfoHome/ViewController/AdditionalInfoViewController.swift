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
    private var additionalInfoViewModel: AdditionalInfoHomeViewModel?
    var selectedColour: ColourDetails?
    var employee: EmployeeDetails?
    var birthPlaceDetails: BirthPlaceDetails?
    var additionalInfoDetails: AdditionalInfoDetails?
    
    
    init(additionalInfoViewModel: AdditionalInfoHomeViewModel) {
        self.additionalInfoViewModel = additionalInfoViewModel
        super.init(nibName: String(describing: AdditionalInfoViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ADDITIONAL INFORMATION"
        setupNextBarButton()
        setupSelectColourButtonAndSegmentedControlAndResidentialAddressTextField()
        additionalInfoViewModel?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        additionalInfoView.preferredColourView.layer.cornerRadius = additionalInfoView.preferredColourView.layer.bounds.width / 2
        additionalInfoView.preferredColourView.layer.borderWidth = 4
        additionalInfoView.preferredColourView.layer.borderColor = UIColor.white.cgColor
        additionalInfoView.preferredColour.font = UIFont(name: "Helvetica-Bold", size: 17)
    }
        
    private func setupNextBarButton() {
       nextBarButton = UIBarButtonItem(title: "NEXT", style: .plain, target: self, action: #selector(goToReview))
       nextBarButton.isEnabled = false
       navigationItem.rightBarButtonItem = nextBarButton
   }
    
    func setupSelectColourButtonAndSegmentedControlAndResidentialAddressTextField() {
        additionalInfoView.selectColourButton.addTarget(self, action: #selector(selectColourButtonPressed), for: .touchUpInside)
        additionalInfoView.genderSegmentedControl.addTarget(self, action: #selector(genderChanged(_:)), for: .valueChanged)
        additionalInfoView.residentialAddressTextField.addTarget(self, action: #selector(textFieldChanged), for: .allEvents)
    }
    
    @objc func selectColourButtonPressed() {
        let colourListViewController = ColourListViewController(nibName: "ColourListViewController", bundle: nil)
        let serviceCall = ColourListServiceCall()
        let viewModel = ColourListViewModel(colourListServiceCall: serviceCall)
        colourListViewController.colourListViewModel = viewModel
        colourListViewController.colourSelectionDelegate = self
        
        SecureModalPresenter.present(colourListViewController, from: self)
    }
    
    @objc func genderChanged(_ sender: UISegmentedControl) {
        let selectedGender = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""
        additionalInfoView.genderLabel.text = selectedGender
        additionalInfoView.genderLabel.isHidden = false
        additionalInfoViewModel?.chosenGenderLabel = selectedGender
    }
    
    @objc func textFieldChanged() {
        additionalInfoViewModel?.residentialAddressTextField = additionalInfoView.residentialAddressTextField.text ?? ""
    }
    deinit {
        print("\(self) has been removed from Memory")
    }
}

extension AdditionalInfoViewController: ColourSelectionDelegate {
    
    func didSelectColour(_ colour: ColourDetails) {
        self.selectedColour = colour
        
        additionalInfoView.preferredColour.text = colour.name
        additionalInfoView.preferredColourView.backgroundColor = UIColor(hexString: colour.color)
        
        additionalInfoView.colourDetailsView.isHidden = false
        
        additionalInfoViewModel?.selectedColourView = additionalInfoView.preferredColourView
        
    }
    
    @objc func goToReview() {
        guard let colour = self.selectedColour else { return }
        
        let reviewController = ReviewViewController(nibName: "ReviewViewController", bundle: nil)
        reviewController.employee = employee
        reviewController.birthPlaceDetails = birthPlaceDetails
        reviewController.selectedColour = colour
        
        reviewController.additionalInfoDetails = AdditionalInfoDetails(
            gender: additionalInfoView.genderLabel.text ?? "",
            residentialAddress: additionalInfoView.residentialAddressTextField.text ?? "")
        
        SecureNavigation.navigate(from: self, to: reviewController)
    }
}

extension AdditionalInfoViewController: AdditionalInfoHomeViewModelDelegate {
    
    func didUpdateForm(isValid: Bool) {
        nextBarButton.isEnabled = isValid
    }
}
