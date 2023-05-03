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
    @IBOutlet weak var dueDatePicker: UITextField!
    @IBOutlet weak var firstAlertDatePicker: UITextField!
    @IBOutlet weak var secondAlertDatePicker: UITextField!
    @IBOutlet weak var categoryPopUpButton: UIButton!
    
    // MARK: - Properties
    var viewModel: CreateExpenseViewModel!
    
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(CreateExpenseViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CreateExpenseViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        dueDatePicker.inputView = datePicker
        firstAlertDatePicker.inputView = datePicker
        secondAlertDatePicker.inputView = datePicker
        
        viewModel = CreateExpenseViewModel(delegate: self)
        popUpConfig()
    }
    
    // MARK: - Functions
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dueDatePicker.text = dateFormatter.string(from: datePicker.date)
        firstAlertDatePicker.text = dateFormatter.string(from: datePicker.date)
        secondAlertDatePicker.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
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
              let dueDate = dueDatePicker.text,
              let firstAlert = firstAlertDatePicker.text,
              let secondAlert = secondAlertDatePicker.text,
              let name = expenseNameTextField.text else { return }
        
        switch category {
        case "Recurring":
            let expense = Expense(isSavings: false, isRecurring: true, isIndividual: false, amount: amount, name: name, dueDate: dueDate, dueDateAlert: firstAlert, dueDateSecondAlert: secondAlert)
            viewModel.createExpense(expense: expense)
        case "Individual":
            let expense = Expense(isSavings: false, isRecurring: false, isIndividual: true, amount: amount, name: name, dueDate: dueDate, dueDateAlert: firstAlert, dueDateSecondAlert: secondAlert)
            viewModel.createExpense(expense: expense)
        case "Savings":
            let expense = Expense(isSavings: true, isRecurring: false, isIndividual: false, amount: amount, name: name, dueDate: dueDate, dueDateAlert: firstAlert, dueDateSecondAlert: secondAlert)
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
