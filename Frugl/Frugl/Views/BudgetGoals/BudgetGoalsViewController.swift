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
    var selectedIndexPath: IndexPath?
    
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
extension BudgetGoalsViewController: BudgetTableViewCellDelegate {
    func didSelectButton(in cell: BudgetTableViewCell) {
        if let indexPath = budgetTableView.indexPath(for: cell) {
            if let previousSelectedIndexPath = selectedIndexPath {
                let previousCell = budgetTableView.cellForRow(at: previousSelectedIndexPath) as? BudgetTableViewCell
                previousCell?.isCurrentBudget = false
            }
            cell.isCurrentBudget = true
            CurrentUser.shared.currentBudgetID = viewModel.budgets[indexPath.row].uuid
            selectedIndexPath = indexPath
        }
    }
}

extension BudgetGoalsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.budgets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "budgetCell", for: indexPath) as? BudgetTableViewCell else { return UITableViewCell() }
        
        let budget = viewModel.budgets[indexPath.row]
        if let currentBudgetID = CurrentUser.shared.currentBudgetID, currentBudgetID == budget.uuid {
            cell.isCurrentBudget = true
            selectedIndexPath = indexPath
        } else {
            cell.isCurrentBudget = false
        }
        cell.updateUI(with: budget)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            let alertController = UIAlertController(title: "Delete Budget?", message: "You sure you want to delete this budget?", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(dismissAction)
            let confirmAction = UIAlertAction(title: "Delete Budget", style: .destructive) { _ in
                let budget = self.viewModel.budgets[indexPath.row]
                guard let budget = self.viewModel.budgets.first(where: { $0.uuid == budget.uuid} ) else { return }
                self.viewModel.deleteBudget(budget: budget)
                self.navigationController?.popViewController(animated: true)
            }
            
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true)
        }
    }
}

extension BudgetGoalsViewController: BudgetGoalsViewModelDelegate {
    func budgetDeletedSuccessfully() {
        budgetTableView.reloadData()
    }
    
    func budgetsFetchedSuccessfully() {
        budgetTableView.reloadData()
    }
    
    func budgetSavedSuccessfully() {
        viewModel.loadBudgets()
        budgetTableView.reloadData()
    }
}
