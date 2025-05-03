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
        didSet { validateForm() }
    }
    var placeOfBirthTextField: String = "" {
        didSet { validateForm() }
    }
    var dateOfBirthTextField: String = "" {
        didSet { validateForm() }
    }

    private func validateForm() {
        let isValid = selectedImage != nil &&
                      !placeOfBirthTextField.trimmingCharacters(in: .whitespaces).isEmpty &&
                      !dateOfBirthTextField.trimmingCharacters(in: .whitespaces).isEmpty

        delegate?.didUpdateForm(isValid: isValid)
    }
}
