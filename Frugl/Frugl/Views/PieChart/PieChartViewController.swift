//
//  PieChartViewController.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import UIKit

class PieChartViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var pieChartView: PieChartView!
    @IBOutlet weak var monthlyBudgetGoalTextField: UILabel!
    @IBOutlet weak var pieChartTableView: UITableView!
    @IBOutlet weak var overdueBudgetTextField: UILabel!
    @IBOutlet weak var budgetAmountLeftTextField: UILabel!
    @IBOutlet weak var percentageLeftTextField: UILabel!
    
    
    // MARK: - Properties
    var viewModel: PieChartViewModel!
    var allExpenses: [Expense] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChartTableView.dataSource = self
        viewModel = PieChartViewModel(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDataforTableView()
        budgetAmountLabel()
    }
    
    func fetchDataforTableView() {
        viewModel.fetchExpenses()
    }
    
    func updatePieChart() {
        pieChartView.slices = viewModel.slices
        pieChartView.setNeedsDisplay()
        pieChartView.animateChart()
    }
    
    func budgetAmountLabel() {
        guard let budget = CurrentUser.shared.currentBudget else { return }
        monthlyBudgetGoalTextField.text = "Budget: $\(budget.amount)"
    }
    
    func budgetAmountLeftOver() {
        guard let budget = CurrentUser.shared.currentBudget else { return }
        //        let newBudget = viewModel.newBudgetAmount
        let totalExpenses = viewModel.allExpensesTotal ?? 0.0
        let remainingBalance = budget.amount - totalExpenses
        print("expenses", totalExpenses)
        
        if remainingBalance > 0 {
            budgetAmountLeftTextField.text = "Left Over: $\(remainingBalance)"
            
        } else {
            budgetAmountLeftTextField.text = "Over Budget: $\(remainingBalance)"
        }
    }
}

// MARK: - UITableViewDataSource
extension PieChartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pieChartCell", for: indexPath) as? PieChartTableViewCell else {
            return UITableViewCell()
        }
        
        let expense = viewModel.expenses[indexPath.row]
        let budget = CurrentUser.shared.currentBudget
        let budgetAmount = budget?.amount ?? 0.0
        let newBudget = viewModel.newBudgetAmount ?? 0.0
        print("New", newBudget)
        print("Old", budgetAmount)
        
        if newBudget == 0 {
            
            let formattedAmount = String(format: "%.2f%%", (expense.amount / budgetAmount) * 100)
            
            cell.configCell(expenseName: expense.name, amount: formattedAmount)
            
        } else if newBudget != budgetAmount  {
            
            let newFormattedAmount = String(format: "%.2f%%", (expense.amount / newBudget) * 100)
            
            cell.configCell(expenseName: expense.name, amount: newFormattedAmount)
        }
        
        return cell
    }
}

// MARK: - PieChartViewModelDelegate
extension PieChartViewController: PieChartViewModelDelegate {
    func loadExpensesSuccessfully() {
        DispatchQueue.main.async { [weak self] in
            self?.budgetAmountLeftOver()
            self?.pieChartTableView.reloadData()
            self?.updatePieChart()
        }
    }
}
