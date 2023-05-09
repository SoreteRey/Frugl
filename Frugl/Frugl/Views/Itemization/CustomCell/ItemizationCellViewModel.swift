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
    var expenses: [Expense] = []
    var expense: Expense?
    
    init(delegate: ItemizationCellViewModelDelegate, service: FireBaseSyncable = FirebaseService()) {
        self.service = service
    }
    
    // MARK: - Functions
    func fetchExpense() {
        service.loadExpense { result in
            switch result {
            case .success(let expense):
                self.expenses = expense
                self.delegate?.expenseLoadedSuccessfully()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func deleteExpense() {
        guard let expense = expense else { return }
        service.deleteExpense(expense: expense) { result in
            switch result {
            case .success(_):
                self.delegate?.expenseLoadedSuccessfully()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
