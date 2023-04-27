//
//  SignInViewModel.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import Foundation
import FirebaseAuth

struct SignInAccountViewModel {
    
    func signInAccount(email: String, password: String) {
     
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error {
                print(error.localizedDescription)
            }
            
            if let authResult {
                let user = authResult.user
                print(user.uid)
            }
        }
    }
}
