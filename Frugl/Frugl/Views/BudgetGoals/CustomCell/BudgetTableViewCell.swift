//
//  BudgetGoalsTableViewCell.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import UIKit

protocol BudgetTableViewCellDelegate: AnyObject {
    func didSelectButton(in cell: BudgetTableViewCell)
}

class BudgetTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var budgetNameLabel: UILabel!
    @IBOutlet weak var budgetAmountLabel: UILabel!
    @IBOutlet weak var isCurrentBudgetButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: BudgetTableViewCellDelegate?
    var isCurrentBudget: Bool = false {
        didSet {
            let imageName = isCurrentBudget ? "checkmark.circle.fill" : "checkmark.circle"
            isCurrentBudgetButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    // MARK: - Helper Functions
    func updateUI(with budget: Budget) {
        budgetNameLabel.text = budget.name
        budgetAmountLabel.text = String(budget.amount)
    }
    
    // MARK: - Actions
    @IBAction func checkmarkButtonTapped(_ sender: Any) {
        delegate?.didSelectButton(in: self)
    }
} // End of class
