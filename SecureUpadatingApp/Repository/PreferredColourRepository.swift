//
//  PreferredColourRepository.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/21.
//

import Foundation

class PreferredColourRepository {
    
    let preferredColourAPIService: PreferredColourAPIService
    
    init(preferredColourAPIService: PreferredColourAPIService) {
        self.preferredColourAPIService = preferredColourAPIService
    }
    
    func getPreferredColourList() {
        preferredColourAPIService.getPreferredColourList()
    }
    
}
