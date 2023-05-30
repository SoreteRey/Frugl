//
//  PieChartTableViewCell.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import UIKit

class PieChartTableViewCell: UITableViewCell {

  // MARK: - Outlets
    @IBOutlet weak var expenseNameTextLabel: UILabel!
    @IBOutlet weak var expensePercentageTextLabel: UILabel!
    
    // MARK: - Properties
    var expense: Expense?
    var viewModel: PieChartViewModel!
    
    // MARK: - Functions
    func configCell(expenseName: String, amount: String) {
           expenseNameTextLabel.text = expenseName
           expensePercentageTextLabel.text = amount
    }
}
