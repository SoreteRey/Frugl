//
//  BudgetGoalsViewController.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import UIKit

class BudgetGoalsViewController: UIViewController {
    
    
    // MARK: - Properties
    var viewModel: BudgetGoalsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BudgetGoalsViewModel()
    }
}
