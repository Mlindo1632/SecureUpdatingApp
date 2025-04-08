//
//  EmployeeHomeView.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/04/07.
//

import UIKit

class EmployeeHomeView: UIView {
    
    @IBOutlet weak var employeeDetailsView: UIView!
    @IBOutlet weak var selectedEmployeeImage: UIImageView!
    @IBOutlet weak var selectedEmployeeName: UILabel!
    @IBOutlet weak var selectedEmployeeEmail: UILabel!
    @IBOutlet weak var dateOfBirthTextfield: UITextField!
    @IBOutlet weak var placeOfBirthTextfield: UITextField!
    @IBOutlet weak var selectEmployeeButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
        
        employeeDetailsView.isHidden = true
    }
    
    func viewInit() {
        let xibView = Bundle.main.loadNibNamed("EmployeeHomeView", owner: self, options: nil)![0] as! UIView
        xibView.frame = self.bounds
        addSubview(xibView)
    }
}
