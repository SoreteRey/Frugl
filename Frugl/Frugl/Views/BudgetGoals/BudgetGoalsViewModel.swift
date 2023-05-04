//
//  BudgetGoalsViewModel.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/27/23.
//

import Foundation
import FirebaseFirestore

protocol BudgetGoalsViewModelDelegate: AnyObject {
    func budgetSavedSuccessfully()
    func didUpdateExpense()
    
}

class BudgetGoalsViewModel {
    // MARK: - Properties
    let service: FireBaseSyncable
    weak var delegate: BudgetGoalsViewModelDelegate?
    var budget: Budget?
    var expense: [Expense] = []
    
    init(serviceInjected: FireBaseSyncable = FirebaseService(), delegate: BudgetGoalsViewModelDelegate) {
        self.service = serviceInjected
        self.delegate = delegate
    }
    
    // MARK: - Functions
    func saveBudget(with amount: Double) {
        let budget = Budget(amount: amount)
        service.saveBudget(budget: budget)
    }
    
    func updateExpense(at index: Int, with updatedExpense: Expense) {
        expense[index] = updatedExpense
        delegate?.didUpdateExpense()
    }
    
    func addExpense(_ expense: Expense) {
            self.expense.append(expense)
        }
}

