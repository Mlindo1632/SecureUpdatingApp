//
//  EmployeeListView.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/04/13.
//

import UIKit

class EmployeeListView: UIView {
    
    @IBOutlet weak var employeeListTableView: UITableView!
    @IBOutlet weak var employeeListNavigationBar: UINavigationBar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
    }
    
    func viewInit() {
        let xibView = Bundle.main.loadNibNamed("EmployeeListView", owner: self, options: nil)![0] as! UIView
        xibView.frame = self.bounds
        addSubview(xibView)
    }
}
