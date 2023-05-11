//
//  CalendarViewModel.swift
//  Frugl
//
//  Created by Matthew Hill on 5/9/23.
//

import Foundation
import FirebaseFirestore

protocol CalendarViewModelDelegate: AnyObject {
    func expensesLoadedSuccessfully()
}

class CalendarViewModel {
    // MARK: - Properties
    let service: FireBaseSyncable
    weak var delegate: CalendarViewModelDelegate?
    var expenses: [Expense] = []
    var allExpenses: [Expense] = []
    var totalAmountArray = [0.0]
    var allExpensesTotal: Double?
    
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
    
    func expensesAmount(completion: @escaping() -> Void) {
        guard let currentBudget = CurrentUser.shared.currentBudget else { return }
        service.loadExpenses(forBudget: currentBudget) { [weak self] result in
            switch result {
            case .success(let allExpenses):
                self?.allExpenses = allExpenses
                self?.totalAmountArray = allExpenses.compactMap { $0.amount }
                self?.allExpensesTotal = self?.totalAmountArray.reduce(0, { $0 + $1 }) ?? 0.0
                completion()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
} // End of class
