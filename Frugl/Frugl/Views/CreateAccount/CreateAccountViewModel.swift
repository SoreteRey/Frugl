//
//  CreateAccountViewModel.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import Foundation
import FirebaseAuth

struct CreateAccountViewModel {
    
    func createAccount(email: String, password: String, confirmPassword: String) {
        
        if password == confirmPassword {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error {
                    print(error.localizedDescription)
                }
                
                if let authResult {
                    let user = authResult.user
                    print(user.uid)
                }
            }
        } else {
            print("Passwords don't match")
        }
    }
    
    func signOutAccount() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
