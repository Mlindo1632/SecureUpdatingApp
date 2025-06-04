//
//  ReviewView.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/05/12.
//

import UIKit

class ReviewView: UIView {
    
    @IBOutlet weak var reviewImageView: UIImageView!
    @IBOutlet weak var reviewFullNameLabel: UILabel!
    @IBOutlet weak var reviewEmailLabel: UILabel!
    @IBOutlet weak var reviewDOBLabel: UILabel!
    @IBOutlet weak var reviewGenderLabel: UILabel!
    @IBOutlet weak var reviewColourView: UIView!
    @IBOutlet weak var reviewColourNameLabel: UILabel!
    @IBOutlet weak var reviewPlaceOfBirthLabel: UILabel!
    @IBOutlet weak var reviewResidentialAddress: UILabel!
    @IBOutlet weak var reviewSubmitButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
        
    }
    
    func viewInit() {
        let xibView = Bundle.main.loadNibNamed("ReviewView", owner: self, options: nil)![0] as! UIView
        xibView.frame = self.bounds
        addSubview(xibView)
    }

    
}
