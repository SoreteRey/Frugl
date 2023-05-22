//
//  SignOutViewController.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/27/23.
//

import UIKit

class SignOutViewController: UIViewController {

    // MARK: - Properties
    var viewModel: SignOutViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SignOutViewModel(delegate: self)

    }
    
    // MARK: - Functions
    
    func deleteAccountAlertWarning() {
            let alertController = UIAlertController(title: "Delete Acount", message: "This action is permanent. Are you sure you want to delete your account?", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(dismissAction)
        let confirmAction = UIAlertAction(title: "Delete Account", style: .destructive) { _ in
            self.deleteAccountAlert()
        }
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true)
    }
    
    func deleteAccountAlert() {
            let alertController = UIAlertController(title: "Absolutely Sure?", message: "No longer DTF?", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(dismissAction)
            let confirmAction = UIAlertAction(title: "Delete Account", style: .destructive) { _ in
                self.viewModel.deleteUser()
            }
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true)
        }
    
// MARK: - Actions
    @IBAction func signOutButtonTapped(_ sender: Any) {
        viewModel.signOutAccount()
    }
    @IBAction func deleteAccountButtonTapped(_ sender: Any) {
        deleteAccountAlertWarning()
    }
} // End of class

// MARK: - Extension
extension SignOutViewController: SignOutViewModelDelegate {
    func signOutSuccessfully() {
    }
}
