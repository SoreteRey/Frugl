//
//  SignInViewController.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import UIKit

class SignInViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Properties
    var viewModel: SignInAccountViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SignInAccountViewModel(delegate: self)
        self.hideKeyboardWhenDone()
    }
    
    func presentErrorAlertController(error: String) {
        let alertController = UIAlertController(title: "", message: error, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Okay", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
    
    // MARK: - Actions
    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, email != "",
              let password = passwordTextField.text, password != "" else { return }
        viewModel.signInAccount(email: email, password: password) { Bool, error in
            if let error = error {
                self.presentErrorAlertController(error: error.localizedDescription)
            }
        }
    }
} // End of class

extension SignInViewController: SignInAccountViewModelDelegate {
    func signInSuccessfull() {
    }
}
