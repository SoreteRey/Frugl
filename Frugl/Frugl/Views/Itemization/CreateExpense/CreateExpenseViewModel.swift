//
//  CreateExpenseViewModel.swift
//  Frugl
//
//  Created by Jake Gloschat on 5/2/23.
//

import Foundation

protocol CreateExpenseViewModelDelegate: AnyObject {
    func expenseCreatedSuccessfully()
}

class CreateExpenseViewModel {
    
    // MARK: - Properties
    private weak var delegate: CreateExpenseViewModelDelegate?
    private var service: FireBaseSyncable
    var expense: Expense?
    
    init(delegate: CreateExpenseViewModelDelegate, service: FireBaseSyncable = FirebaseService()) {
        self.delegate = delegate
        self.service = service
    }
    
    func createExpense(name: String, amount: Double) {
        guard let expense = expense else { return }
    
    }
    
    func deleteExpense() {
        guard let expense = expense else { return }
        service.deleteExpense(expense: expense) { result in
            switch result {
            case .success(_):
                self.delegate?.expenseCreatedSuccessfully()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
