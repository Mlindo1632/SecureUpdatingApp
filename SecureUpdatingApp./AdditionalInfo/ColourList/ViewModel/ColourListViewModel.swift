//
//  ColourListViewModel.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/05/05.
//

import Foundation

protocol ColourSelectionDelegate: AnyObject {
    func didSelectColour(_ colour: ColourDetails)
}

class ColourListViewModel {
    
    private let colourListServiceCall: ColourListServiceCallProtocol!
    private (set) var colours: [ColourDetails] = []
    private (set) var error: Error?
    
    var onUpdate: (() -> Void)?
    
    init(colourListServiceCall: ColourListServiceCallProtocol!) {
        self.colourListServiceCall = colourListServiceCall
    }
    
    @MainActor
    func getColours() async {
        do {
            let colours = try await colourListServiceCall.getColourList()
            self.colours = colours
            self.error = nil
            
        } catch {
            self.error = error
        }
        onUpdate?()
    }
    
    func numberOfColours() -> Int {
        return colours.count
    }
    
    func colour(at index: Int) -> ColourDetails {
        return colours [index]
    }
}
