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
    var expense: Expense?
    var currentBudget: CurrentUser?
    
    init(delegate: ItemizationViewModelDelegate, service: FireBaseSyncable = FirebaseService()) {
        self.delegate = delegate
        self.service = service
    }
}
