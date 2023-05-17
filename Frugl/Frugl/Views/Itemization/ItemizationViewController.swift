//
//  ItemizationViewController.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import UIKit

class ItemizationViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var budgetTotalLabel: UILabel!
    @IBOutlet weak var expensesTableView: UITableView!
    @IBOutlet weak var expectedBalanceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expensesTableView.dataSource = self
        expensesTableView.delegate = self
        viewModel = ItemizationViewModel(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchExpenses()
    }
    
    // MARK: - Properties
    var viewModel: ItemizationViewModel!
    
    // MARK: - Functions
    func updateUI() {
        if let budget = CurrentUser.shared.currentBudget {
            budgetTotalLabel.text = "$\(budget.amount)"
            expectedBalanceLabel.text = "$\(viewModel.currentBalance ?? 0)"
            expensesTableView.reloadData()
        }
    }
    
    func presentExpenseAlert() {
        let alertController = UIAlertController(title: "Limit Reached", message: "You have reached your limit of 20 expenses", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreateExpense" {
            if self.viewModel.expenses.count <= 19 {
                guard segue.destination is CreateExpenseViewController else { return }
            } else {
                presentExpenseAlert()
            }
        }
    }
} // End of Class

// MARK: - Extensions
extension ItemizationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionedExpenses.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Recurring"
        case 1: return "Individual"
        case 2: return "Savings"
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sectionedExpenses[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath)
        
        let expense = viewModel.sectionedExpenses[indexPath.section][indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = expense.name
        config.secondaryText = "$\(expense.amount)"
        cell.contentConfiguration = config
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            let alertController = UIAlertController(title: "Delete Expense?", message: "You sure you want to delete this expense?", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(dismissAction)
            let confirmAction = UIAlertAction(title: "Delete Expense", style: .destructive) { _ in
                let expense = self.viewModel.sectionedExpenses[indexPath.section][indexPath.row]
                guard let expense = self.viewModel.expenses.first(where: { $0.uuid == expense.uuid }) else { return }
                self.viewModel.deleteExpense(expense: expense) {
                    self.expensesTableView.reloadData()
                    self.viewModel.fetchExpenses()
                }
                self.navigationController?.popViewController(animated: true)
            }
            
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true)
        }
    }
}

extension ItemizationViewController: ItemizationViewModelDelegate {
    func expenseDeletedSuccessfully() {
        self.expensesTableView.reloadData()
        updateUI()
    }
    
    func expenseLoadedSuccessfully() {
        updateUI()
    }
}
