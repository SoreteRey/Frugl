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
    var budget: Budget?
    var expense: Expense?
    
    init(delegate: ItemizationViewModelDelegate, service: FireBaseSyncable = FirebaseService()) {
        self.delegate = delegate
        self.service = service
    }
    
//    func loadBudget() {
//        service.loadBudget { result in
//            switch result {
//            case .success(let budget):
//                self.budget = budget
//                self.delegate?.budgetLoadedSuccessfully()
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//        }
//    }
    
    func deleteExpense() {
        guard let expense = expense else { return }
        service.deleteExpense(expense: expense) { result in
            switch result {
            case .success(_):
                self.delegate?.budgetLoadedSuccessfully()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
