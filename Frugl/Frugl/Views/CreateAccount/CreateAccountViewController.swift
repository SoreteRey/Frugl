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
        viewModel = CreateAccountViewModel(delegate: self)
        self.hideKeyboardWhenDone()
    }
    
    // MARK: - Functions
    func presentMainVC() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "navigation")
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: true)
    }
    
    func presentErrorAlertController(error: String) {
        let alertController = UIAlertController(title: "", message: error, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Okay", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
    
    // MARK: - Action
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        guard let email = userEmailTextField.text,
              let password = userPassWordTextField.text,
              let confirmPassword = userConfirmPasswordTextField.text else { return }
        
        viewModel.createAccount(email: email, password: password, confirmPassword: confirmPassword) { success, error in
            if success == true {
                print("succesful account creation")
            } else {
                self.presentErrorAlertController(error: error?.localizedDescription ?? "")
            }
        }
    }
} // End of class

// MARK: - Extensions
extension CreateAccountViewController: CreateAccountViewModelDelegate {
    func accountCreatedSuccessfully() {
        presentMainVC()
    }
}

