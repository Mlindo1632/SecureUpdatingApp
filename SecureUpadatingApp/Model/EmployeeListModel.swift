//
//  ListOfEmployeesModel.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/16.
//

import Foundation

struct EmployeeListModel: Codable {
    var data: [Employee]
}

struct Employee: Codable {
    var id: Int?
    var firstName: String?
    var lastName: String?
    var email: String?
    var avatar: String?
    
    enum CodingKeys: String, CodingKey {
       case id = "id"
       case firstName = "first_name"
       case lastName = "last_name"
       case email = "email"
       case avatar = "avatar"
    }
}

