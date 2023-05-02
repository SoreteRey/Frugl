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
    
}

class BudgetGoalsViewModel {
    // MARK: - Properties
    let service: FireBaseSyncable
    weak var delegate: BudgetGoalsViewModelDelegate?
    var budgets: [Budget] = []
    
    init(serviceInjected: FireBaseSyncable = FirebaseService(), delegate: BudgetGoalsViewModelDelegate) {
        self.service = serviceInjected
        self.delegate = delegate
    }
    
    // MARK: - Functions
    func saveBudget(with amount: Double) {
//        let budget = Budget(amount: amount)
//        service.saveBudget(budget) { [weak self] result in
//            switch result {
//            case .success(let budget):
//                self?.budgets.append(budget)
//                self?.delegate?.budgetSavedSuccessfully()
//            case .failure(let error):
//                self?.delegate?(with: error)
//            }
        
    }
    
    
    func loadBudget() {
//        service.loadBudget() { [weak self] result in
//            switch result {
//            case .success(let budgets):
//                self?.budgets = budgets
//            case .failure(let error):
//                self?.delegate?(with: error)
//            }
//        }
    }
}
