//
//  SecureDatePicker.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/05/03.
//

import UIKit

struct SecureDatePicker {
    
    static func attachDatePicker(to textField: UITextField) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        
        textField.inputView = datePicker
        
        datePicker.addTarget(nil, action: #selector(textField.didPickDate), for: .valueChanged)
    }
}

private var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}

private extension UITextField {
    @objc func didPickDate(_ sender: UIDatePicker) {
        self.text = dateFormatter.string(from: sender.date)
        
    }
}

