//
//  ItemizationCellViewModel.swift
//  Frugl
//
//  Created by Jake Gloschat on 5/2/23.
//

import Foundation

// MAXPOFF: - MOST LIKELY DELETE THIS FILE

protocol ItemizationCellViewModelDelegate: AnyObject {
    func expenseLoadedSuccessfully()
}

class ItemizationCellViewModel {
    
    // MARK: - Properties
    private weak var delegate: ItemizationCellViewModelDelegate?
    private var service: FireBaseSyncable
    var expenses: [Expense] = []
    var expense: Expense?
    
    init(delegate: ItemizationCellViewModelDelegate, service: FireBaseSyncable = FirebaseService()) {
        self.service = service
    }
    
    // MARK: - Functions
   
}
