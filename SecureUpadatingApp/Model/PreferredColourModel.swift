//
//  AdditionalInfoModel.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/21.
//

import Foundation

struct PreferredColourModel: Codable {
    var data: [Colours]
}

 struct Colours: Codable {
        var name: String?
        var color: String?
}


