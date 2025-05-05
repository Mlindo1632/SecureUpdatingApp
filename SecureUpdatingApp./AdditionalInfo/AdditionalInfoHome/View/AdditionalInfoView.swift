//
//  AdditionalInfoView.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/05/04.
//

import UIKit

class AdditionalInfoView: UIView {
    
    
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var colourDetailsView: UIView!
    @IBOutlet weak var preferredColourView: UIView!
    @IBOutlet weak var preferredColour: UILabel!
    @IBOutlet weak var selectColourButton: UIButton!
    @IBOutlet weak var residentialAddressTextField: UITextField!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
        
        colourDetailsView.isHidden = true
        
        SecureTextFieldModifier.modifyTextFields(textField: residentialAddressTextField, radius: 20)
    }
    
    func viewInit() {
        let xibView = Bundle.main.loadNibNamed("AdditionalInfoView", owner: self, options: nil)![0] as! UIView
        xibView.frame = self.bounds
        addSubview(xibView)
    }
}
