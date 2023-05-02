//
//  BudgetGoalsViewController.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import UIKit

class BudgetGoalsViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var budgetGoalsTextField: UITextField!
    
    // MARK: - Properties
    var viewModel: BudgetGoalsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BudgetGoalViewModel()
        
        tableView.dataSource = self
        
    }
    
    
    // MARK: - Helper Functions
    private func updateUI() {
        
    }
    
}
    

extension BudgetGoalsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
