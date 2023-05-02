//
//  BudgetGoalsTableViewCell.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import UIKit

class BudgetGoalsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var financialGoalTextField: UITextField!
    @IBOutlet weak var goalAmountTextField: UITextField!
    
   // MARK: - Helper Functions
    func configureCell(with budget: Budget) {
        financialGoalTextField.text =
    }
    
    // MARK: - Actions
    @IBAction func checkmarkButtonTapped(_ sender: Any) {
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let financialGoal = financialGoalTextField.text, financialGoal != "",
              let goalAmount = goalAmountTextField.text, goalAmount != "" else { return }
        
    }
    
}
