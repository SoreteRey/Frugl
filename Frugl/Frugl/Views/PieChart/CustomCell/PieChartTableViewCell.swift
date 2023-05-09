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
    
    func configure(with expenseName: String, expensePercentage: String) {
         expenseNameTextLabel.text = expenseName
         expensePercentageTextLabel.text = expensePercentage
     }
     
     func configure(with percentage: CGFloat) {
         let formattedPercentage = String(format: "%.0f%%", percentage * 100)
         expenseNameTextLabel.text = formattedPercentage
     }
 }
