//
//  ItemizationCellViewModel.swift
//  Frugl
//
//  Created by Jake Gloschat on 5/2/23.
//

import Foundation

class ItemizationCellViewModel {
    
    // MARK: - Properties
    private var service: FireBaseSyncable
    var expenses: [Expense] = []
    var expense: Expense?
    
    init(service: FireBaseSyncable = FirebaseService()) {
        self.service = service
    }
}
