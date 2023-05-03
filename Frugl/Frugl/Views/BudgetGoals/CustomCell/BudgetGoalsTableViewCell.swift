//
//  BudgetGoalsTableViewCell.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import UIKit

protocol BudgetGoalsTableViewCellDelegate: AnyObject {
    func didCreateExpense(_ expense: Expense)
    
}

class BudgetGoalsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var financialGoalTextField: UITextField!
    @IBOutlet weak var goalAmountTextField: UITextField!
    
    // MARK: - Properties
    weak var delegate: BudgetGoalsTableViewCellDelegate?
    
    // MARK: - Helper Functions
    func configureCell(with expense: Expense) {
        financialGoalTextField.text = expense.name
        goalAmountTextField.text = String(expense.amount)
    }
 
    
    // MARK: - Actions
    @IBAction func checkmarkButtonTapped(_ sender: Any) {
    }
}
