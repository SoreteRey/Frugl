//
//  CreateAccountViewModel.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import Foundation
import FirebaseAuth

protocol CreateAccountViewModelDelegate: AnyObject {
    func accountCreatedSuccessfully()
}

struct CreateAccountViewModel {
    
    // MARK: - Properties
    var delegate: CreateAccountViewModelDelegate?
    
    init(delegate: CreateAccountViewModelDelegate) {
        self.delegate = delegate
    }
    
    func createAccount(email: String, password: String, confirmPassword: String, completion: @escaping (Bool, Error?) -> Void) {
        if password == confirmPassword {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error {
                    print("Error Creating User", error.localizedDescription)
                    completion(false, error)
                }
                if let authResult {
                    let user = authResult.user
                    print(user.uid)
                    completion(true, nil)
                }
            }
        } else {
            print("Password Dont Match")
            completion(false, NSError(domain: "Invalid Input", code: -1, userInfo: [NSLocalizedDescriptionKey: "Passwords don't match"]))
        }
    }
}
