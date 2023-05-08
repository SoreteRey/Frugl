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
    func budgetsFetchedSuccessfully()
    func budgetDeletedSuccessfully()

}

class BudgetGoalsViewModel {
    // MARK: - Properties
    let service: FireBaseSyncable
    weak var delegate: BudgetGoalsViewModelDelegate?
    var budget: Budget?
    var budgets: [Budget] = []
    
    init(serviceInjected: FireBaseSyncable = FirebaseService(), delegate: BudgetGoalsViewModelDelegate) {
        self.service = serviceInjected
        self.delegate = delegate
        self.loadBudgets()
    }
    
    // MARK: - Functions
    func saveBudget(budget: Budget) {
        service.saveBudget(budget: budget)
        // MAXPOFF: - This makes the most recently added budget the currentBudget
//        CurrentUser.shared.currentBudget = budget
        self.delegate?.budgetSavedSuccessfully()
    }
    
    func loadBudgets() {
        service.loadBudget { [weak self] result in
            switch result {
            case .success(let budgets):
                self?.budgets = budgets
                self?.delegate?.budgetsFetchedSuccessfully()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteBudget(budget: Budget) {
        service.deleteBudget(budget: budget) { result in
            switch result {
            case .success(_):
                guard let indexOfBudget = self.budgets.firstIndex(of: budget) else { return }
                self.budgets.remove(at: indexOfBudget)
                self.delegate?.budgetDeletedSuccessfully()
                
            case .failure(_):
                print("Budget failed to delete.")
            }
        }
    }
}
