//
//  BudgetGoalsTableViewCell.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import UIKit

class BudgetTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var budgetNameLabel: UILabel!
    @IBOutlet weak var budgetAmountLabel: UILabel!
    @IBOutlet weak var isCurrentBudgetButton: UIButton!
    
    // MARK: - Properties
    var budget: Budget?
    
    // MARK: - Helper Functions
    func updateUI(with budget: Budget) {
        budgetNameLabel.text = budget.name
        budgetAmountLabel.text = String(budget.amount)
    }
    
    func currentBudget() {
        guard let budget = budget else { return }
        let isCurrentBudget = CurrentUser.shared.currentBudget
        if isCurrentBudget != nil {
            isCurrentBudgetButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            isCurrentBudgetButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }
    }
    
    
    
    // MARK: - Actions
    @IBAction func checkmarkButtonTapped(_ sender: Any) {
        guard let budget = budget else { return }
        if CurrentUser.shared.currentBudget == budget {
            isCurrentBudgetButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            CurrentUser.shared.currentBudget = budget
        } else {
            isCurrentBudgetButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            CurrentUser.shared.currentBudget != budget
        }
    }
} // End of class
