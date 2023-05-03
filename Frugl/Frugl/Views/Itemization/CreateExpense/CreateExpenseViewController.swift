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
              let category = categoryPopUpButton.titleLabel?.text,
              let name = expenseNameTextField.text else { return }
        
        switch category {
        case "Recurring":
            let expense = Expense(isSavings: false, isRecurring: true, isIndividual: false, amount: amount, name: name, dueDate: <#T##String?#>, dueDateAlert: <#T##String?#>, dueDateSecondAlert: <#T##String?#>)
            viewModel.createExpense(expense: expense)
        case "Individual":
            let expense = Expense(isSavings: false, isRecurring: false, isIndividual: true, amount: amount, name: name, dueDate: <#T##String?#>, dueDateAlert: <#T##String?#>, dueDateSecondAlert: <#T##String?#>)
            viewModel.createExpense(expense: expense)
        case "Savings":
            let expense = Expense(isSavings: true, isRecurring: false, isIndividual: false, amount: amount, name: name, dueDate: <#T##String?#>, dueDateAlert: <#T##String?#>, dueDateSecondAlert: <#T##String?#>)
            viewModel.createExpense(expense: expense)
        default:
            return
        }
    }
}

extension CreateExpenseViewController: CreateExpenseViewModelDelegate {
    func expenseCreatedSuccessfully() {
        
    }
}
