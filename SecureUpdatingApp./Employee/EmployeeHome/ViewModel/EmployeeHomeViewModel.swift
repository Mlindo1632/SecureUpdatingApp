//
//  EmployeeHomeViewModel.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/04/29.
//

import UIKit

protocol EmployeeHomeViewModelDelegate: AnyObject {
    func didUpdateForm(isValid: Bool)
}

class EmployeeHomeViewModel {
    
    weak var delegate: EmployeeHomeViewModelDelegate?
    
    var selectedImage: UIImage? {
        didSet { verifyForm() }
    }
    
    var placeOfBirthTextField: String = "" {
        didSet { verifyForm() }
    }
    
    var dateOfBirthTextField: String = "" {
        didSet { verifyForm() }
    }
    
    private func verifyForm() {
        let isValid = selectedImage != nil && !placeOfBirthTextField.isEmpty && !dateOfBirthTextField.isEmpty
        delegate?.didUpdateForm(isValid: isValid)
    }
    
}
