//
//  BudgetGoalsViewController.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import UIKit

class BudgetGoalsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var budgetTableView: UITableView!
    @IBOutlet weak var budgetNameTextField: UITextField!
    @IBOutlet weak var budgetAmountTextField: UITextField!
    
    // MARK: - Properties
    var viewModel: BudgetGoalsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BudgetGoalsViewModel(delegate: self)
        budgetTableView.dataSource = self
        
    }
    
    // MARK: - Helper Functions
    private func updateUI() {
        budgetNameTextField.text = ""
        budgetAmountTextField.text = ""
        budgetTableView.reloadData()
    }

    // MARK: - Actions
    @IBAction func addBudgetButtonTapped(_ sender: Any) {
        guard let name = budgetNameTextField.text else { return }
        guard let amount = Double(budgetAmountTextField.text ?? "0.0") else { return}
        let budget = Budget(amount: amount, name: name)
        viewModel.saveBudget(budget: budget)
        updateUI()
    }
} // End of class

// MARK: - Extensions
extension BudgetGoalsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.budgets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "budgetCell", for: indexPath) as? BudgetTableViewCell else { return UITableViewCell() }
        
        let budget = viewModel.budgets[indexPath.row]
        cell.updateUI(with: budget)
        cell.budget = budget
        return cell
    }
}

extension BudgetGoalsViewController: BudgetGoalsViewModelDelegate {
    func budgetsFetchedSuccessfully() {
        budgetTableView.reloadData()
    }
    
    func budgetSavedSuccessfully() {
        viewModel.loadBudgets()
        budgetTableView.reloadData()
    }
}

