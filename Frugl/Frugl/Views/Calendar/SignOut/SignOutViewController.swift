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
    

// MARK: - Actions
    @IBAction func signOutButtonTapped(_ sender: Any) {
        viewModel.signOutAccount()
    }
}

extension SignOutViewController: SignOutViewModelDelegate {
    func signOutSuccessfully() {
        
    }
}
