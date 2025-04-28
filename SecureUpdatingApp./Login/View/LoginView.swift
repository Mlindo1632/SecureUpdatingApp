//
//  LoginView.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/03/26.
//

import UIKit

class LoginView: UIView {
    
    @IBOutlet weak var loginDetailsView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
        
        activityIndicator.isHidden = true
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        passwordTextField.isSecureTextEntry = true
        loginButton.isEnabled = false
        
        SecureTextFieldModifier.roundCorners(textField: emailTextField, radius: 20.0)
        SecureTextFieldModifier.roundCorners(textField: passwordTextField, radius: 20.0)
        
        loginDetailsView.layer.borderWidth = 4
        loginDetailsView.layer.borderColor = UIColor.blue.cgColor
    }
    
    func viewInit() {
        let xibView = Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)![0] as! UIView
        xibView.frame = self.bounds
        addSubview(xibView)
    }
}

