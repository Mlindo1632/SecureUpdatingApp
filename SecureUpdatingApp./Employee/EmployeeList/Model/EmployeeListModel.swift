//
//  File.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/04/09.
//

import Foundation

struct EmployeeListModel: Codable {
    let data: [EmployeeDetails]
}

struct EmployeeDetails: Codable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}
