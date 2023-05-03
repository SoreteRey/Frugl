//
//  BudgetGoalsViewController.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import UIKit

class BudgetGoalsViewController: UIViewController, BudgetGoalsViewModelDelegate, BudgetGoalsTableViewCellDelegate {
    func didUpdateExpense() {
        
    }
    
    func budgetSavedSuccessfully() {
        updateUI()
    }
    
    func didCreateExpense(_ expense: Expense) {
           viewModel.addExpense(expense)
           updateUI()
       }
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var budgetGoalsTextField: UITextField!
    
    // MARK: - Properties
    var viewModel: BudgetGoalsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BudgetGoalsViewModel(delegate: self)
        tableView.dataSource = self
        budgetGoalsTextField.delegate = self
    }
    
    // MARK: - Helper Functions
    private func updateUI() {
           tableView.reloadData()
           budgetGoalsTextField.text = ""
       }
    
    func updateExpense(at index: Int, with updatedExpense: Expense) {
        viewModel.expense[index] = updatedExpense
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let financialGoal = budgetGoalsTextField.text, financialGoal != "",
                let indexPath = tableView.indexPathForSelectedRow,
                let goalAmountString = (tableView.cellForRow(at: indexPath) as? BudgetGoalsTableViewCell)?.goalAmountTextField.text,
                let goalAmount = Double(goalAmountString) else {
              return
          }

          let expense = Expense(amount: goalAmount, name: financialGoal)
          viewModel.addExpense(expense)
          updateUI()
      }
}


   // MARK: - Extensions
extension BudgetGoalsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.expense.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as? BudgetGoalsTableViewCell else { return UITableViewCell() }

        let expense = viewModel.expense[indexPath.row]
        cell.configureCell(with: expense)

        cell.goalAmountTextField.delegate = self
        cell.delegate = self
        return cell
    }
}

extension BudgetGoalsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Hide the keyboard
        guard let amountString = budgetGoalsTextField.text, let amount = Double(amountString) else { return true }
        viewModel.saveBudget(with: amount)
        return true
    }
}
