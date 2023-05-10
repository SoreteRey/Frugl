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
    
    init(service: FireBaseSyncable = FirebaseService(), delegate: CalendarViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
    
    // MARK: - Functions
    func loadExpenses() {
        guard let currentBudget = CurrentUser.shared.currentBudget else { return }
        service.loadExpenses(forBudget: currentBudget) { [weak self] result in
            switch result {
            case .success(let expenses):
                self?.expenses = expenses
                self?.expenses = expenses.filter { $0.dueDate != ""}
                    self?.delegate?.expensesLoadedSuccessfully()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
} // End of class
