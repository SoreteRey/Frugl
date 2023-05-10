//
//  CalendarViewModel.swift
//  Frugl
//
//  Created by Matthew Hill on 5/9/23.
//

import Foundation

protocol CalendarViewModelDelegate: AnyObject {
    func expensesLoadedSuccessfully()
}

class CalendarViewModel {
    // MARK: - Properties
    let service: FireBaseSyncable
    weak var delegate: CalendarViewModelDelegate?
    var expenses: [Expense] = []
    var filterExpenses: [Expense] = []
    
    init(service: FireBaseSyncable = FirebaseService(), delegate: CalendarViewModelDelegate) {
        self.service = service
        self.delegate = delegate
        self.loadExpenses()
    }
    
    // MARK: - Functions
    func loadExpenses() {
        guard let currentBudget = CurrentUser.shared.currentBudget else { return }
        service.loadExpenses(forBudget: currentBudget) { result in
            switch result {
            case .success(let expenses):
                self.expenses = expenses
                
                for i in expenses {
                    if i.dueDate != "" {
                        self.filterExpenses.append(i)
                    }
                    self.delegate?.expensesLoadedSuccessfully()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
} // End of class
