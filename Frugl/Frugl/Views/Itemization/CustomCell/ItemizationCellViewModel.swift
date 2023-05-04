//
//  ItemizationCellViewModel.swift
//  Frugl
//
//  Created by Jake Gloschat on 5/2/23.
//

import Foundation

protocol ItemizationCellViewModelDelegate: AnyObject {
    func expenseLoadedSuccessfully()
}

class ItemizationCellViewModel {
    
    // MARK: - Properties
    private weak var delegate: ItemizationCellViewModelDelegate?
    private var service: FireBaseSyncable
    var expense: [Expense] = []
    
    init(delegate: ItemizationCellViewModelDelegate, service: FireBaseSyncable = FirebaseService()) {
        self.service = service
    }
    
    // MARK: - Functions
    func fetchExpense() {
        service.loadExpense { result in
            switch result {
            case .success(let expense):
                self.expense = expense
                self.delegate?.expenseLoadedSuccessfully()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
