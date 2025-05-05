//
//  AdditionalInfoViewController.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/05/04.
//

import UIKit

class AdditionalInfoViewController: UIViewController {
    
    private var nextBarButton: UIBarButtonItem!
    @IBOutlet weak var additionalInfoView: AdditionalInfoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Additinal Information"
        setupNextBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    private func setupNextBarButton() {
       nextBarButton = UIBarButtonItem(title: "NEXT", style: .plain, target: self, action: #selector(goToReview))
       nextBarButton.isEnabled = false
       navigationItem.rightBarButtonItem = nextBarButton
   }
    
    @objc func goToReview() {
        
    }
}
