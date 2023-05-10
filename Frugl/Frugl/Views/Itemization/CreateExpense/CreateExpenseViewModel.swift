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
    
    func createExpense(expense: Expense) {
        service.saveExpense(expense: expense)
        self.delegate?.expenseCreatedSuccessfully()
    }
}
