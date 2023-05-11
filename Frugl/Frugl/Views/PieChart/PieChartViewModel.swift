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

//struct PieSlice {
//    var percent: CGFloat
//    var color: UIColor
//    var expenseName: String
//}

class PieChartViewModel {
    
    // MARK: - Properties
    var slices: [Slice] = []
    var expenses: [Expense] = []
    private var service: FireBaseSyncable
    private weak var delegate: PieChartViewModelDelegate?
    
    init(firebaseService: FireBaseSyncable = FirebaseService(), delegate: PieChartViewModelDelegate) {
        self.service = firebaseService
        self.delegate = delegate
//        fetchExpenses() // This will fetch only ONCE - as we are only initializing the VM in the VDL
    }
    
    func fetchExpenses() {
        guard let currentBudget = CurrentUser.shared.currentBudget else { return }
        service.loadExpenses(forBudget: currentBudget) { result in
            switch result {
            case .success(let expenses):
                self.expenses = expenses
                self.calculateSlices()
                self.delegate?.loadExpensesSuccessfully()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
     func calculateSlices() {
        let amounts = expenses.map { $0.amount }
        let totalAmount = amounts.reduce(0, +)

        self.slices = expenses.enumerated().map { index, expense in
            let amount = amounts[index]
            let percent = CGFloat(amount / totalAmount)
            let color = getRandomColor()
            let name = expense.name // Assuming the expense struct has a 'name' property
            return Slice(percent: percent, color: color, expenseName: name)
        }
    }
    
//     Helper function to generate random colors
    private func getRandomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)

        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
