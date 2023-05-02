//
//  BudgetGoalsViewController.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import UIKit

class BudgetGoalsViewController: UIViewController, BudgetGoalsViewModelDelegate {
    func budgetSavedSuccessfully() {
    }
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var budgetGoalsTextField: UITextField!
    
    // MARK: - Properties
    var viewModel: BudgetGoalsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BudgetGoalsViewModel(delegate: self)
        viewModel.loadBudget()
        tableView.dataSource = self
        
    }

    // MARK: - Helper Functions
    private func updateUI() {
           tableView.reloadData()
           budgetGoalsTextField.text = ""
       }
    // MARK: - Actions
       @IBAction func addButtonTapped(_ sender: Any) {
           guard let amountString = budgetGoalsTextField.text, let amount = Double(amountString) else { return }
           viewModel.saveBudget(with: amount)
       }
   }

   // MARK: - Extensions

extension BudgetGoalsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.budgets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "budgetCell", for: indexPath) as? BudgetGoalsTableViewCell else { return UITableViewCell() }
        
        let budget = viewModel.budgets[indexPath.row]
           cell.configureCell(with: budget)
           return cell
    }
}

extension BudgetGoalsViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let budget = searchBar.text else { return }
//        viewModel.saveBudget(with: budget.)
//    }
}
