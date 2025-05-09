//
//  AdditionalInfoHomeViewModel.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/05/08.
//

import UIKit

protocol AdditionalInfoHomeViewModelDelegate: AnyObject {
    func didUpdateForm(isValid: Bool)
}

class AdditionalInfoHomeViewModel {
    
    weak var delegate: AdditionalInfoHomeViewModelDelegate?
    private (set) var selectedGender: Gender = .male
    
    var selectedColourView: UIView? {
        didSet { verifyForm() }
    }
    
    var chosenGender: UISegmentedControl? {
        didSet { verifyForm() }
    }
    
    var residentialAddressTextField: String = "" {
        didSet { verifyForm() }
    }
    
    func updateGender(index: Int) {
        if let gender = Gender(rawValue: index) {
            selectedGender = gender
        }
    }
    
    private func verifyForm() {
        let hasBackGroundColour = selectedColourView?.backgroundColor != nil
        let hasValidGender = chosenGender?.selectedSegmentIndex != UISegmentedControl.noSegment
        let hasAddress = !residentialAddressTextField.trimmingCharacters(in: .whitespaces).isEmpty
        
        let isValid = hasBackGroundColour && hasValidGender && hasAddress
        delegate?.didUpdateForm(isValid: isValid)
    }
}
