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
        updateUI()
        viewModel.fetchExpense()
    }
    
    
    
    // MARK: - Properties
    var viewModel: ItemizationViewModel!
    
    
    // MARK: - Functions
    func updateUI() {
        if let budget = CurrentUser.shared.currentBudget {
            budgetTotalLabel.text = "\(budget.amount)"
        }
    }
} // End of Class

// MARK: - Extensions
extension ItemizationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
        switch section {
        case 0:
            return viewModel.expenses?.filter { $0.isRecurring }.count ?? 0
        case 1:
            return viewModel.expenses?.filter { $0.isIndividual }.count ?? 0
        case 2:
            return viewModel.expenses?.filter { $0.isSavings }.count ?? 0
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        guard let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as? ItemizationTableViewCell else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath)
        
        guard let expenses = viewModel.expenses else { return UITableViewCell() }
        var config = cell.defaultContentConfiguration()
        
        switch indexPath.section {
        case 0:
            let recurringExpenses = expenses.filter { $0.isRecurring }
            let expense = recurringExpenses[indexPath.row]
            config.text = expense.name
            config.secondaryText = String(expense.amount)
        case 1:
            let individualExpenses = expenses.filter { $0.isIndividual }
            let expense = individualExpenses[indexPath.row]
            config.text = expense.name
            config.secondaryText = String(expense.amount)
        case 2:
            let savingsExpenses = expenses.filter { $0.isSavings }
            let expense = savingsExpenses[indexPath.row]
            config.text = expense.name
            config.secondaryText = String(expense.amount)
        default: break
        }
        
        cell.contentConfiguration = config
        return cell
    }
}

extension ItemizationViewController: ItemizationViewModelDelegate {
    
    func budgetLoadedSuccessfully() {
        expensesTableView.reloadData()
    }
}
