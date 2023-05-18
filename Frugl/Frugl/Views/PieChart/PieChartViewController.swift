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
        let totalExpenses = viewModel.allExpensesTotal ?? 0.0
        let remainingBalance = budget.amount - totalExpenses
        
        if remainingBalance > 0 {
            let remainingBalanceText = "Left Over: $\(remainingBalance)"
            let attributedString = NSMutableAttributedString(string: remainingBalanceText)
//            let darkGreen = UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0) insert into value if we want a differente color

            let range = (remainingBalanceText as NSString).range(of: "\(remainingBalance)")
            attributedString.addAttribute(.foregroundColor, value: UIColor.systemGreen, range: range)

            budgetAmountLeftTextField.attributedText = attributedString

        } else {
            let remainingBalanceText = "Over Budget: $\(remainingBalance * -1)"
            let attributedString = NSMutableAttributedString(string: remainingBalanceText)

            let range = (remainingBalanceText as NSString).range(of: "\(remainingBalance * -1)")
            attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: range)

            budgetAmountLeftTextField.attributedText = attributedString
        }
    }
    
    func budgetPercentage() {
        guard let budget = CurrentUser.shared.currentBudget else { return }
        let budgetAmount = budget.amount
        let totalExpenses = viewModel.allExpensesTotal ?? 0.0

        if totalExpenses <= budgetAmount {
            let percentageUsed = (totalExpenses / budgetAmount) * 100
            let formattedPercentage = String(format: "%.2f%%", percentageUsed)
            percentageLeftTextField.text = formattedPercentage
        } else {
            let overBudgetPercentage = ((totalExpenses - budgetAmount) / budgetAmount) * 100 + 100
            let formattedPercentage = String(format: "%.2f%%", overBudgetPercentage)
            percentageLeftTextField.text = formattedPercentage
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
            self?.budgetPercentage()
            self?.pieChartTableView.reloadData()
            self?.updatePieChart()
        }
    }
}
