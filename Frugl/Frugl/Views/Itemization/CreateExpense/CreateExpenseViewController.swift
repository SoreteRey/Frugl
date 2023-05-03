//
//  CreateExpenseViewController.swift
//  Frugl
//
//  Created by Jake Gloschat on 5/1/23.
//

import UIKit

class CreateExpenseViewController: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var expenseNameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var optionalDueDateTextField: UITextField!
    @IBOutlet weak var optionalFirstAlertTextField: UITextField!
    @IBOutlet weak var optionalSecondAlertTextField: UITextField!
    @IBOutlet weak var categoryPopUpButton: UIButton!
    
    // MARK: - Properties
    var viewModel: CreateExpenseViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CreateExpenseViewModel(delegate: self)
        popUpConfig()
    }
    
    func popUpConfig() {
        let closure = { (action: UIAction) in
            print(action.title)
        }
        categoryPopUpButton.menu = UIMenu(children: [
            UIAction(title: "Recurring/Individual/Savings ↓", attributes: .hidden, state: .on, handler: closure),
            UIAction(title: "Recurring", handler: closure),
            UIAction(title: "Individual", handler: closure),
            UIAction(title: "Savings", handler: closure)
        ])
        categoryPopUpButton.showsMenuAsPrimaryAction = true
        categoryPopUpButton.changesSelectionAsPrimaryAction = true
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let amount = Double(amountTextField.text ?? "0.0"),
        let name = expenseNameTextField.text else { return }
        let expense = Expense(amount: amount, name: name)
        viewModel.createExpense(expense: expense)
    }
    
    @IBAction func popUpButtonTapped(_ sender: Any) {
    }
    
    
    
}
extension CreateExpenseViewController: CreateExpenseViewModelDelegate {
    func expenseCreatedSuccessfully() {

    }
}
