//
//  ColourListModel.swift
//  SecureUpdatingApp.
//
//  Created by on 2025/05/05.
//

import Foundation

struct ColourListModel: Codable {
    let data: [ColourDetails]
}

struct ColourDetails: Codable {
    let id: Int
    let name: String
    let year: Int
    let color: String
    let pantoneValue: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case year
        case color
        case pantoneValue = "pantone_value"
    }
}
