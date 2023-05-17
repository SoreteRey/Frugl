//
//  PieChartViewModel.swift
//  Frugl
//
//  Created by Sebastian Guiscardo on 5/8/23.
//

import UIKit
import Firebase

protocol PieChartViewModelDelegate: AnyObject {
    func loadExpensesSuccessfully()
}

class PieChartViewModel {
    
    // MARK: - Properties
    var slices: [Slice] = []
    var expenses: [Expense] = []
    var totalAmountArray = [0.0]
    var allExpensesTotal: Double?
    private var service: FireBaseSyncable
    private weak var delegate: PieChartViewModelDelegate?
    var newBudgetAmount: Double?
    
    init(firebaseService: FireBaseSyncable = FirebaseService(), delegate: PieChartViewModelDelegate) {
        self.service = firebaseService
        self.delegate = delegate
        
    }
    
    func fetchExpenses() {
        guard let currentBudget = CurrentUser.shared.currentBudget else { return }
        service.loadExpenses(forBudget: currentBudget) { result in
            switch result {
            case .success(let expenses):
                self.expenses = expenses
                self.calculateSlices(for: currentBudget)
                self.totalAmountArray = expenses.compactMap { $0.amount }
                self.allExpensesTotal = self.totalAmountArray.reduce(0, { $0 + $1 })
                self.delegate?.loadExpensesSuccessfully()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func calculateSlices(for budget: Budget) {
        
        let debts = expenses.map { $0.amount }
        let totalDebt = debts.reduce(0, +)
        let remainingBalance = budget.amount - totalDebt
        let remainingBalancePercent = CGFloat(remainingBalance / budget.amount)
        
        if totalDebt <= budget.amount {
            var tempSlices = expenses.enumerated().map { index, expense in
                let amount = debts[index]
                print(amount)
                let percent = CGFloat(amount / budget.amount)
                let color = getRandomColor()
                let name = expense.name // Assuming the expense struct has a 'name' property
                return Slice(percent: percent, color: color, expenseName: name)
            }
            // green
            let remainingSlice = Slice(percent: remainingBalancePercent, color: .systemGreen, expenseName: "Available")
            
            tempSlices.append(remainingSlice)
            self.slices = tempSlices
            
        } else {

            self.newBudgetAmount = (remainingBalance * -1) + budget.amount
            var tempSlices = expenses.enumerated().map { index, expense in
                let amount = debts[index]
                print(amount)
                let percent = CGFloat(amount / newBudgetAmount!)
                let color = getRandomColor()
                let name = expense.name // Assuming the expense struct has a 'name' property
                return Slice(percent: percent, color: color, expenseName: name)
            }
            self.slices = tempSlices
        }
    }
    
        //     Helper function to generate random colors
        private func getRandomColor() -> UIColor {
//            let red = CGFloat.random(in: 0...0.7)
            let green = CGFloat.random(in: 0...0.6)
            let blue = CGFloat.random(in: 0...0.9)
            
            return UIColor(red: 0, green: green, blue: blue, alpha: 1.0)
        }
    }

