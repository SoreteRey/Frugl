//
//  CreateAccountViewController.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPassWordTextField: UITextField!
    @IBOutlet weak var userConfirmPasswordTextField: UITextField!
    
    
    // MARK: - Properties
    var viewModel: CreateAccountViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CreateAccountViewModel()
    }
    
    // MARK: - Action
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        guard let email = userEmailTextField.text,
              let password = userPassWordTextField.text,
              let confirmPassword = userConfirmPasswordTextField.text else { return }
        
        viewModel.createAccount(email: email, password: password, confirmPassword: confirmPassword)
        self.navigationController?.popViewController(animated: true)
    }
}
