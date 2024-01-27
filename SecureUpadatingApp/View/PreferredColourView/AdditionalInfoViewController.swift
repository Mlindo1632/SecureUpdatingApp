//
//  AdditionalInfoViewController.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/20.
//

import UIKit

class AdditionalInfoViewController: UIViewController {
    
    @IBOutlet var selectedActualColourView: UIView!
    @IBOutlet var selectedPreferredColorLabel: UILabel!
    
    var colorData: Colours?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        updateUI()
    }
    
    private func updateUI() {
        guard let colorData = colorData else { return }
        selectedPreferredColorLabel.text = colorData.name
       // selectedActualColourView.backgroundColor = colorData.name.
    }
    
    
    
        func configureItems() {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(fowardAction))
        }
        
        @objc func fowardAction() {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AdditionalInfoViewController") as! AdditionalInfoViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }

