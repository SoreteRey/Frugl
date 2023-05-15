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

    private var datePicker = UIDatePicker()
    private var firstAlertDatePickerInitialized = UIDatePicker()
    private var secondAlertDatePickerInitialized = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CreateExpenseViewModel(delegate: self)
        popUpConfig()
        dueDateDatePicker()
        firstAlert()
        secondAlert()
        self.hideKeyboardWhenDone()
    }
    
    // MARK: - Functions
    func popUpConfig() {
        let closure = { (action: UIAction) in
            print(action.title)
        }
        categoryPopUpButton.menu = UIMenu(children: [
            UIAction(title: "Recurring/Individual/Savings", attributes: .hidden, state: .on, handler: closure),
            UIAction(title: "Recurring", handler: closure),
            UIAction(title: "Individual", handler: closure),
            UIAction(title: "Savings", handler: closure)
        ])
        categoryPopUpButton.showsMenuAsPrimaryAction = true
        categoryPopUpButton.changesSelectionAsPrimaryAction = true
    }
    
    func dueDateDatePicker() {
        // adds the toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // Adds the bar button item
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        // Date Picker Attributes
        dueDatePicker.inputView = datePicker
        dueDatePicker.inputAccessoryView = toolbar
        dueDatePicker.textAlignment = .center
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
    }
    
    @objc func donePressed() {
        // Formatter for Date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        dueDatePicker.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func firstAlert() {
        // adds the toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // Adds the bar button item
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedAlert))
        toolbar.setItems([doneBtn], animated: true)
        
        // Date Picker Attributes
        firstAlertDatePicker.inputView = firstAlertDatePickerInitialized
        firstAlertDatePicker.inputAccessoryView = toolbar
        firstAlertDatePicker.textAlignment = .center
        firstAlertDatePickerInitialized.datePickerMode = .date
        firstAlertDatePickerInitialized.preferredDatePickerStyle = .wheels
    }
    
    @objc func donePressedAlert() {
        // Formatter for Date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        firstAlertDatePicker.text = formatter.string(from: firstAlertDatePickerInitialized.date)
        self.view.endEditing(true)
    }
    
    func secondAlert() {
        // adds the toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // Adds the bar button item
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedSecondAlert))
        toolbar.setItems([doneBtn], animated: true)
        
        // Date Picker Attributes
        secondAlertDatePicker.inputView = secondAlertDatePickerInitialized
        secondAlertDatePicker.inputAccessoryView = toolbar
        secondAlertDatePicker.textAlignment = .center
        secondAlertDatePickerInitialized.datePickerMode = .date
        secondAlertDatePickerInitialized.preferredDatePickerStyle = .wheels
    }
    
    @objc func donePressedSecondAlert() {
        // Formatter for Date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        secondAlertDatePicker.text = formatter.string(from: secondAlertDatePickerInitialized.date)
        self.view.endEditing(true)
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
            let expense = Expense(type: .recurring, amount: amount, name: name, dueDate: dueDate, dueDateAlert: firstAlert, dueDateSecondAlert: secondAlert)
            viewModel.createExpense(expense: expense)
        case "Individual":
            let expense = Expense(type: .individual, amount: amount, name: name, dueDate: dueDate, dueDateAlert: firstAlert, dueDateSecondAlert: secondAlert)
            viewModel.createExpense(expense: expense)
        case "Savings":
            let expense = Expense(type: .savings, amount: amount, name: name, dueDate: dueDate, dueDateAlert: firstAlert, dueDateSecondAlert: secondAlert)
            viewModel.createExpense(expense: expense)
        default:
            return
        }
    }
}

extension CreateExpenseViewController: CreateExpenseViewModelDelegate {
    func expenseCreatedSuccessfully() {
        self.dismiss(animated: true)
    }
}
