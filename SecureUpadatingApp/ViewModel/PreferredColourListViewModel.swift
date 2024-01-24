//
//  PreferredColourListViewModel.swift
//  SecureUpadatingApp
//
//  Created by Khumalo, Lindokuhle L on 2024/01/21.
//

import Foundation

protocol PreferredColourListViewModelDelegate: AnyObject {
    func didReceiveList(preferredColourList: PreferredColourModel)
    func didNotReceiveList(error: Error)
}

class PreferredColourListViewModel: PreferredColourAPIServiceDelegate {
    
    weak var delegate: PreferredColourListViewModelDelegate?
    
    private let preferredColourListRepository: PreferredColourRepository
    
    init(preferredColourListRepository: PreferredColourRepository) {
        self.preferredColourListRepository = preferredColourListRepository
        self.preferredColourListRepository.preferredColourAPIService.delegate = self
    }
    
    func getPreferredColourList() {
        preferredColourListRepository.getPreferredColourList()
    }
    
    func didReceiveList(result: Result<PreferredColourModel, Error>) {
        switch result {
        case .success(let colour):
            delegate?.didReceiveList(preferredColourList: colour)
        case .failure(let error):
            delegate?.didNotReceiveList(error: error)
        }
    }
    
}
