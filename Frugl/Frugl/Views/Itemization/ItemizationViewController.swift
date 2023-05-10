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
//        viewModel.fetchExpenses()
//        updateUI()
    }
    
    // MARK: - Properties
    var viewModel: ItemizationViewModel!
    
    // MARK: - Functions
    func updateUI() {
        if let budget = CurrentUser.shared.currentBudget {
            budgetTotalLabel.text = "$\(budget.amount)"
            expectedBalanceLabel.text = "$\(viewModel.currentidk ?? 0)"
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
}

extension ItemizationViewController: ItemizationViewModelDelegate {
    func expenseLoadedSuccessfully() {
        updateUI()
        expensesTableView.reloadData()
    }
}
