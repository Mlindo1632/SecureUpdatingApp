//
//  ColourListViewModel.swift
//  SecureUpdatingApp.
//
//  Created by Lindokuhle Khumalo on 2025/05/05.
//

import Foundation

protocol ColourListViewModelDelegate: AnyObject {
    func didFetchColours()
    func didFailWithError(_ error: Error)
}

protocol ColourSelectionDelegate: AnyObject {
    func didSelectColour(_ colour: ColourDetails)
}

class ColourListViewModel {
    
    private let colourListServiceCall: ColourListServiceCallProtocol!
    private (set) var colours: [ColourDetails] = []
    weak var delegate: ColourListViewModelDelegate?
    
    init(colourListServiceCall: ColourListServiceCallProtocol!) {
        self.colourListServiceCall = colourListServiceCall
    }
    
    func getColours() {
        colourListServiceCall.getColourList { [weak self] result in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                switch result {
                case .success(let colours):
                    self.colours = colours
                    self.delegate?.didFetchColours()
                case .failure(let error):
                    self.delegate?.didFailWithError(error)
                }
            }
        }
    }
    
    func numberOfColours() -> Int {
        return colours.count
    }
    
    func colour(at index: Int) -> ColourDetails {
        return colours [index]
    }
}
