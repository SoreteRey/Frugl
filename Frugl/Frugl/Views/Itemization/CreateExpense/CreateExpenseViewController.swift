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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
    }
    
    
}
