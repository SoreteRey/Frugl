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
    
    // MARK: - Properties
    var viewModel: PieChartViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
       // Needs real data.
        pieChartTableView.dataSource = self
    
        viewModel = PieChartViewModel(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //TableView
        budgetAmountLabel()
        fetchDataforTableView()
        //PieChart
//        viewModel.calculateSlices()
//        updatePieChart()
        
    }
    
    func fetchDataforTableView() {
        #warning("Ask yourself. Do I want to FETCH the data from Firestore everytime this view will appear? Or, is that too much.")
        viewModel.fetchExpenses()

    }
    
    func updatePieChart() {
//        let slices = viewModel.slices
//
//        pieChartView.slices = slices.map { slice in
//            return Slice(percent: slice.percent, color: slice.color, expenseName: slice.expenseName)
//        }
        pieChartView.slices = viewModel.slices
        pieChartView.setNeedsDisplay()
        pieChartView.animateChart()
    }
    
    func budgetAmountLabel() {
        if let budget = CurrentUser.shared.currentBudget {
            monthlyBudgetGoalTextField.text = "$\(budget.amount)"
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
        if let budget = CurrentUser.shared.currentBudget {
            
            let formattedAmount = String(format: "%.2f%%", (expense.amount / budget.amount) * 100)
            
            cell.configCell(expenseName: expense.name, amount: formattedAmount)
        }
        
        return cell
    }
}


// MARK: - PieChartViewModelDelegate

extension PieChartViewController: PieChartViewModelDelegate {
    func loadExpensesSuccessfully() {
        DispatchQueue.main.async { [weak self] in
            self?.pieChartTableView.reloadData()
            self?.updatePieChart()
        }
    }
}
