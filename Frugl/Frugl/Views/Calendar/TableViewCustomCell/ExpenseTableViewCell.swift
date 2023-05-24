//
//  ExpenseTableViewCell.swift
//  Frugl
//
//  Created by Matthew Hill on 5/9/23.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var expenseNameLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var expenseAmountLabel: UILabel!
    
    // MARK: - Functiones
    func updateUI(with expense: Expense) {
        expenseNameLabel.text = expense.name
        dueDateLabel.text = expense.dueDate
        expenseAmountLabel.text = ("\(expense.amount)")
    }
}
