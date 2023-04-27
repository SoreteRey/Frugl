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
        
        viewModel = SignInAccountViewModel()
    }
    
    // MARK: - Actions
    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
        viewModel.signInAccount(email: email, password: password)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
