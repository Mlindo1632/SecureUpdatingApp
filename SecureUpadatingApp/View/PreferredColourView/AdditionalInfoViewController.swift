//
//  AdditionalInfoViewController.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/20.
//

import UIKit

class AdditionalInfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }
    
        func configureItems() {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(fowardAction))
        }
        
        @objc func fowardAction() {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AdditionalInfoViewController") as! AdditionalInfoViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }

