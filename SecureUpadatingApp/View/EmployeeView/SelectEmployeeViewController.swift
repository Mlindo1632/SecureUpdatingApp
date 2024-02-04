//
//  SelectEmployeeViewController.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/15.
//

import UIKit

class SelectEmployeeViewController: UIViewController {
    
    @IBOutlet var selectedEmployeeImageView: UIImageView!
    @IBOutlet var selectedEmployeeFullNameLabel: UILabel!
    @IBOutlet var selectedEmployeeEmailLabel: UILabel!
    @IBOutlet var dOBTextfield: UITextField!
    @IBOutlet var fullNameAndEmailStackView: UIStackView!
    
    var employeeData: Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureNextButton()
        updateUI()
        setupDatePicker()
        navigationItem.hidesBackButton = true
        fullNameAndEmailStackView.isHidden = true
    }
    
    func setupDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        dOBTextfield.inputView  = datePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: false)
        dOBTextfield.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let datePicker = dOBTextfield.inputView as? UIDatePicker {
            let selectedDate = datePicker.date
            let formattedDate = dateFormatter.string(from: selectedDate)
            dOBTextfield.text = formattedDate
            dOBTextfield.resignFirstResponder()
        }
    }
    
    func configureNextButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(fowardAction))
    }
    
    @objc func fowardAction() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AdditionalInfoViewController") as! AdditionalInfoViewController
            navigationController?.pushViewController(vc, animated: true)
    }
    
     func updateUI() {
        guard let employeeData = employeeData else { return }
        selectedEmployeeFullNameLabel.text = "\(employeeData.firstName ?? "") \(employeeData.lastName ?? "")"
        selectedEmployeeEmailLabel.text = "\(employeeData.email ?? "")"
        
        if let url = URL(string: employeeData.avatar ?? "") {
            URLSession.shared.dataTask(with: url) { data, _,error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.selectedEmployeeImageView.image = image
                        self.fullNameAndEmailStackView.isHidden = false
                    }
                }
            }.resume()
        }
    }
}


