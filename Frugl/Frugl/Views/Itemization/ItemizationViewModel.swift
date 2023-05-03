//
//  ItemizationViewModel.swift
//  Frugl
//
//  Created by Jake Gloschat on 5/3/23.
//

import Foundation

protocol ItemizationViewModelDelegate: AnyObject {
    func budgetLoadedSuccessfully()
}

class ItemizationViewModel {
    
    // MARK: - Properties
    private weak var delegate: ItemizationViewModelDelegate?
    private var service: FireBaseSyncable
    var budget: Budget?
    
    init(delegate: ItemizationViewModelDelegate, service: FireBaseSyncable = FirebaseService()) {
        self.delegate = delegate
        self.service = service
    }
    
    func loadBudget() {
        service.loadBudget { result in
            switch result {
            case .success(let budget):
                self.budget = budget
                self.delegate?.budgetLoadedSuccessfully()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
