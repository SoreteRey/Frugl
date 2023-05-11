//
//  ItemizationTableViewCell.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import UIKit

class ItemizationTableViewCell: UITableViewCell {

// MARK: - Outlets
    @IBOutlet weak var expenseNameLabel: UILabel!
    @IBOutlet weak var expenseAmountLabel: UILabel!
    
    
    // MARK: - Properties
    var viewModel: ItemizationCellViewModel!
    var expense: Expense?
    // MARK: - Functions

    func configCell(expense: [Expense]) {
        guard let expense = self.expense else { return }
        expenseNameLabel.text = expense.name
        expenseAmountLabel.text = "$\(expense.amount)"
    }
}
