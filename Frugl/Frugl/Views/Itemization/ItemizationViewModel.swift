//
//  ItemizationViewModel.swift
//  Frugl
//
//  Created by Jake Gloschat on 5/3/23.
//

import Foundation

protocol ItemizationViewModelDelegate: AnyObject {
    func expenseLoadedSuccessfully()
}

class ItemizationViewModel {

    // MARK: - Init
    init(delegate: ItemizationViewModelDelegate, service: FireBaseSyncable = FirebaseService()) {
        self.delegate = delegate
        self.service = service
        fetchExpenses()
    }

    // MARK: - Properties
    private weak var delegate: ItemizationViewModelDelegate?
    private var service: FireBaseSyncable
    var sectionedExpenses: [[Expense]] = [[], [], []] // 2D array
    var currentBudget: CurrentUser?
    var expenses: [Expense] = []
    var currentBalance: Double?

    // MARK: - Functions
    private func updateSectionedExpenses(complete: ()->Void) {
        sectionedExpenses[0] = expenses.filter { $0.type == .recurring }
        sectionedExpenses[1] = expenses.filter { $0.type == .individual }
        sectionedExpenses[2] = expenses.filter { $0.type == .savings }
        complete()
    }

    func fetchExpenses() {
        guard let currentBudget = CurrentUser.shared.currentBudget else { return }
        service.loadExpenses(forBudget: currentBudget) { result in
            switch result {
            case .success(let expenses):
                self.expenses = expenses
                self.updateSectionedExpenses {
                    self.expectedBalance()
                    self.delegate?.expenseLoadedSuccessfully()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func expectedBalance() {
        guard let currentBudget = CurrentUser.shared.currentBudget?.amount else { return }
        let totalExpenses = sectionedExpenses.joined().map { $0.amount }.reduce(0.0, +)
        let expectedBalance = currentBudget - totalExpenses
        currentBalance = expectedBalance
        print(expectedBalance)
    }
    
    func addedExpense() {
        
    }

//    func deleteExpense() {
//        guard let expense = expense else { return }
//        service.deleteExpense(expense: expense) { result in
//            switch result {
//            case .success(_):
//                self.delegate?.budgetLoadedSuccessfully()
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//        }
//    }
}
