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
    var expenses: [Expense] = []
    
    init(delegate: CreateExpenseViewModelDelegate, service: FireBaseSyncable = FirebaseService()) {
        self.delegate = delegate
        self.service = service
    }
    
    func createExpense(with expense: Expense) {
        service.saveExpense(expense: expense) { result in
            switch result {
            case .success(_):
                self.expenses.append(expense)
                self.delegate?.expenseCreatedSuccessfully()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchExpenses() {
        service.loadExpense { result in
            switch result {
            case .success(let expenses):
                self.expenses = expenses
                self.delegate?.expenseCreatedSuccessfully()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func deleteExpense(with expense: Expense) {
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
